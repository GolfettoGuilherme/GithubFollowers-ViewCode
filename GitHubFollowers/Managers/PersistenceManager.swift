//
//  PersistenceManager.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 23/10/22.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    //-----------------------------------------------------------------------
    // MARK: - Singleton
    //-----------------------------------------------------------------------
    static private let defaults = UserDefaults.standard
    
    //-----------------------------------------------------------------------
    // MARK: - Enums
    //-----------------------------------------------------------------------
    enum Keys {
        static let favorites = "favorites"
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Public methods
    //-----------------------------------------------------------------------
    
    static func updateWith(
        favorite: Follower,
        actionType: PersistenceActionType,
        completed: @escaping(GFError?) -> Void
    ) {
        
        retrieveFavorites { result in
            
            switch result {
                
            case .success(let favorites):
                var retrievedFavorites = favorites
                
                switch actionType {
                    
                case .add:
                    
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorite)
                        return
                    }
                    
                    retrievedFavorites.append(favorite)
                case .remove:
                    retrievedFavorites.removeAll { $0.login == favorite.login }
                }
                
                completed(save(favorites: retrievedFavorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Private methods
    //-----------------------------------------------------------------------
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
        
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}