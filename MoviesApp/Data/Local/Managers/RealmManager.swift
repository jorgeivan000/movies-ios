//
//  RealmManager.swift
//  MoviesApp
//
//  Created by jorgehc on 1/8/19.
//  Copyright 2019 jorgehc.com. All rights reserved.
//

import Foundation
import Realm
import RealmSwift


enum RealmCollectionStatus {
    case empty
    case filled
}

class RealmManager {
    var backgroundThread = "background"
    // delete particular object
    func deleteObjectById(id : String, type: Object.Type, onComplete: @escaping((Object?) -> ()) ) {
        let config = try! Realm().configuration
        DispatchQueue.global(qos: .background).async {
            self.getObjectById(id, type: type, onComplete: { objects in
                let realm = try? Realm(configuration: config)
                guard let objectsToDelete = objects else {
                    return
                }
                try? realm!.write ({
                    realm!.delete(objectsToDelete)
                })
                onComplete(nil)
            })
        }
    }
    
    //Save objects to database
    func saveObjects(objs: [Object], type: Object.Type, deleteAll: Bool = false) {
        DispatchQueue.global(qos: .background).async {
            let realmBack = try? Realm()
            autoreleasepool {
                if let objects = realmBack?.objects(type) {
                    try! realmBack?.write ({
                        if deleteAll {realmBack?.delete(objects)}
                        realmBack?.add((objs))
                    })
                }
            }
        }
    }
    
    //Save objects to database
    func syncMovies(addedObjs: [Movie], removedObjs: [Movie], onComplete: @escaping(() -> Void)) {
        DispatchQueue.global(qos: .background).async {
            let realmBack = try? Realm()
            autoreleasepool {
                //find realm objects
                var managedRealmObjects = [Movie]()
                for removedObj in removedObjs {
                    guard let realmObject = (realmBack?.objects(Movie.self).filter("id= '\(removedObj.id)'").toArray(type: Movie.self)[safe: 0]) else {
                        continue
                    }
                    managedRealmObjects.append(realmObject)
                }
                if let _ = realmBack?.objects(Movie.self) {
                    try! realmBack?.write ({
                        realmBack?.delete((managedRealmObjects))
                        realmBack?.add((addedObjs), update: .modified)
                    })
                }
        }
        }
    }
    
    func getRealmCollectionStatus(type: Object.Type, onComplete: @escaping((RealmCollectionStatus) -> ())) {
        DispatchQueue.global(qos: .background).async {
            let config = try! Realm().configuration
            autoreleasepool {
                do {
                    let realm = try Realm(configuration: config)
                    if realm.objects(type).isEmpty {
                        onComplete(RealmCollectionStatus.empty)
                    } else {
                        onComplete(RealmCollectionStatus.filled)
                    }
                } catch {}
            }
        }
    }
    
    //Update objects with a given filter
    func updateObjectsWithFilter(objs: [Object], type: Object.Type, filterQuery: String, deleteAll: Bool = false, onComplete: @escaping(() -> Void)) {
        DispatchQueue.global(qos: .background).async {
            let realmBack = try? Realm()
            autoreleasepool {
                if let objects = realmBack?.objects(type).filter(filterQuery)  {
                    try! realmBack?.write ({
                        if deleteAll {realmBack?.delete(objects)}
                        realmBack?.add((objs))
                    })
                    DispatchQueue.main.async{
                        onComplete()
                    }
                }
            }
    }
    }
        
    //Save objects to database
    func saveObjects(objs: [Object], type: Object.Type, deleteAll: Bool = false, onComplete: @escaping(() -> Void)) {
        DispatchQueue.global(qos: .background).async {
            let realmBack = try? Realm()
            autoreleasepool {
                if let objects = realmBack?.objects(type) {
                    try! realmBack?.write ({
                        if deleteAll {realmBack?.delete(objects)}
                        realmBack?.add((objs))
                    })
                    onComplete()
                }
            }
        }
    }
    
    func getObjectById(_ id: String, type: Object.Type, onComplete: @escaping((Object?) -> ())) {
        let predicate = NSPredicate(format: "id = %@", id)
        let config = try! Realm().configuration
        do {
            let realm = try Realm(configuration: config)
            if let object = realm.objects(type).filter(predicate).first {
                onComplete(object)
            }
        } catch(let error) {
            debugPrint(error)
            onComplete(nil)
        }
    }

    func getObjects(type: Object.Type, onComplete: @escaping((Results<Object>) -> ())) {
        DispatchQueue.global(qos: .background).async {
            let config = try! Realm().configuration
            autoreleasepool {
                do {
                    let realm = try Realm(configuration: config)
                    onComplete(realm.objects(type))
                } catch {}
            }
        }
    }
    
    func getMovies(onComplete: @escaping(([MovieStruct]) -> ())) {
        DispatchQueue.global(qos: .background).async {
            let config = try! Realm().configuration
            autoreleasepool {
                do {
                    let realm = try Realm(configuration: config)
                    onComplete(RealmManager.toUnmanagedMovies(movies: realm.objects(Movie.self).toArray(type: Movie.self)))
                } catch {}
            }
        }
    }
    
    func getMoviesBy(category: String = .empty, onComplete: @escaping(([MovieStruct]) -> ())) {
        let ascending = false
        let dateSortingQuery = "releaseDate"
        let moviesByCategoryQuery = "category == '\(category)'"
        DispatchQueue.global(qos: .background).async {
            let config = try! Realm().configuration
            autoreleasepool {
                do {
                    let realm = try Realm(configuration: config)
                    var sortedMovies = [Movie]()
                    sortedMovies = realm.objects(Movie.self)
                            .filter(moviesByCategoryQuery)
                            .sorted(byKeyPath: dateSortingQuery, ascending: ascending).toArray(type: Movie.self)

                    let unwrappedMovies = RealmManager.toUnmanagedMovies(movies: sortedMovies)
                    DispatchQueue.main.async{
                        onComplete(unwrappedMovies)
                    }
                } catch {}
            }
        }
    }
    
    func getOrderedObjects(type: Object.Type, orderBy property: String, ascending: Bool? = false, onComplete: @escaping((Results<Object>) -> ())) {
        DispatchQueue.global(qos: .background).async {
            let config = try! Realm().configuration
            autoreleasepool {
                do {
                    let realm = try Realm(configuration: config)
                    onComplete(realm.objects(type).sorted(byKeyPath: property, ascending: ascending!))
                } catch {}
            }
        }
    }
    
    func localMoviesExistsByCategory(_ category: String) -> Bool {
        let config = try! Realm().configuration
        let filterById = "category == '\(category)'"
        do {
            let realm = try Realm(configuration: config)
            let movies = realm.objects(Movie.self)
                .filter(filterById)
            return movies.first != nil
        } catch{}
        return false
    }
    
    func localMoviesExists(_ id: String) -> Bool {
        let config = try! Realm().configuration
        let filterById = "id == '\(id)'"
        do {
            let realm = try Realm(configuration: config)
            let contacts = realm.objects(Movie.self)
                .filter(filterById)
            return contacts.first != nil
        } catch{}
        return false
    }
    
        /*
    func getContactNameById(_ id: String, senderName: String) -> String {
        let sessionManager = SessionManager()
        let userId = sessionManager.retrieve(key: .contactId)
        if userId != id {
            let config = try! Realm().configuration
            let filterById = "id == '\(id)'"
            do {
                let realm = try Realm(configuration: config)
                let contacts = realm.objects(Contact.self)
                    .filter(filterById)
                guard let contact = contacts.first else { return senderName }
                return contact.name.isEmpty ? contact.phone : contact.name
            } catch{}
            return senderName
        } else {
            return .you
        }
    }*/
    
    func deleteAll() {
        DispatchQueue.global(qos: .background).async {
            let realmBack = try! Realm()
            autoreleasepool {
                try! realmBack.write {
                    realmBack.deleteAll()
                }
            }
        }
    }
}

extension RealmManager {
    static func toUnmanagedMovies(movies: [Movie]) -> [MovieStruct] {
        var unmanagedMovies = [MovieStruct]()
        for movie in movies {
            unmanagedMovies.append(movie.toStruct())
        }
        return unmanagedMovies
    }
}
