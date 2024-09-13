//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 25/06/22.
//

import UIKit

class FollowerListVC: GFDataLoadingVC {
    
    // MARK: - Enums
    
    enum Section {
        case main
    }
    
    // MARK: - Subviews
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: UIHelper.create3CollumnFlowLayout(in: view)
        )
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            FollowerCell.self,
            forCellWithReuseIdentifier: FollowerCell.reuseId
        )
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - Private properties

    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var followers: [Follower] = []
    var filterFollowers: [Follower] = []
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    // MARK: - Injected properties
    
    var username: String!
    
    // MARK: - Inicialization
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Configuration
    
    private func configure() {
        view.addSubview(collectionView)
        
        getFollowers(username: username, page: page)
        configureDataSource()
        configureSearchController()
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func configureDataSource() {
        // o equivalente ao cellforindexpath
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, follower in
                
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowerCell.reuseId,
                    for: indexPath
                ) as! FollowerCell
                
                cell.set(follower: follower)
                
                return cell
            }
        )
    }
    
    // MARK: - Network call
    
    //TODO: aplicar algum padrão de arquitetura aqui
    func getFollowers(username:String, page: Int) {
        
        showLoadingView()
        
        NetworkManager.shared.getFollowers(
            for: username,
            page: page
        ) { [weak self] result in
            //weak self pq ele ta referenciando a propria tela
            //e isso causa memory leak, por isso que precisa ser assim
            //se não, quando o NetworkManager sair da memoria
            //vai existir um reference ao ViewController ainda
            
            guard let self = self else { return } //pra não precisar usar ? no self
            
            self.dismissLoadingView()
            
            switch result {
                
            case .success(let followers):
                
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    
                    DispatchQueue.main.async {
                        self.showEmptyStateView(
                            with: "Esse usuário não tem seguidores 🙄",
                            in: self.view
                        )
                    }
                    return
                }
                
                self.updateData(on: self.followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(
                    title: "Bad stuff message",
                    message: error.rawValue,
                    bnuttonTitle: "ok"
                )
            }
        }
    }
    
    func updateData(on followers: [Follower]) {
        //isso serve para animar quando o datasource mudar
        //vale usar isso quando ter barra de busca na tela
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    // MARK: - Actions
    
    @objc func addButtonTapped() {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    
                    guard let self = self else { return }
                    
                    guard let error = error else {
                        self.presentGFAlertOnMainThread(title: "Success", message: "You saved this user ", bnuttonTitle: "Horray")
                        return
                    }
                    
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, bnuttonTitle: "Ok")
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, bnuttonTitle: "Ok")
                
            }
        }
    }
    
}

// MARK: - UICollectionViewDelegate

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        //decidir se o usuario esta chegando no final da collectionview
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filterFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destVC        = UserInfoVC()
        destVC.username   = follower.login
        destVC.delegate   = self //vai fazer essa classe ouvir o evento que a UserInfoVC disparar
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

// MARK: - UISearchResultsUpdating, UISearchBarDelegate

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard
            let filter = searchController.searchBar.text,
            !filter.isEmpty else {
            return
        }
        isSearching = true
        filterFollowers = followers.filter{
            $0.login.lowercased().contains(filter.lowercased())
        }
        updateData(on: filterFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }

}

// MARK: - UserInfoVCDelegate

extension FollowerListVC: UserInfoVCDelegate {
    
    func didRequestFollowers(for username: String) {
        self.username = username
        title         = username
        page          = 1
        followers.removeAll()
        filterFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true) //voltar a colletionview ao topo
        getFollowers(username: username, page: page)
    }
    
}
