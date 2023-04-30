//
//  FirestoreManager.swift
//  GroceryStoreFirebase
//
//  Created by Надежда Левицкая on 4/24/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class FirestoreManager {
    
    private var db: Firestore
    
    init() {
        db = Firestore.firestore()
    }
    
    func getStoreByID(storeId: String, completion: @escaping (Result<Store?, Error>) -> Void) {
        
        let ref = db.collection("stores").document(storeId)
        ref.getDocument { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                if let snapshot = snapshot {
                    var store: Store? = try? snapshot.data(as: Store.self)
                    if store != nil {
                        store!.id = snapshot.documentID
                        completion(.success(store))
                    }
                }
            }
        }
    }
    
    func updateStore(storeId: String, values: [AnyHashable: Any], completion: @escaping (Result<Store?>, Error) -> Void) {
        
        let ref = db.collection("stores").document(storeId)
        
        ref.updateData(
        [
            "items": FieldValue.arrayUnion((values["items"] as? [String]) ?? [])
        ]
        ) { error in
            
            if let error = error {
                completion(.failure(error))
            } else {
                ref.getDocument { (snapshot, error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        self.getStoreByID(storeId: storeId) { result in
                            switch result {
                            case .success(let store):
                                completion(.success(store))
                            case .failure(let error):
                                completion(.failure(error))
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getAllStores(completion: @escaping (Result<[Store]?, Error>) -> Void) {
        db.collection("stores")
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    if let shapshot = snapshot {
                        let stores: [Store?] = shapshot.documents.compactMap { doc in
                            var store = try? doc.data(as: Store.self)
                            if store != nil {
                                store!.id = doc.documentID
                            }
                            return store
                        }
                        completion(.success(stores))
                    }
                }
            }
    }
        
        func save(store: Store, completion: @escaping(Result<Store?, Error>) -> Void) {
            
            do {
                let ref = try db.collection("stores").addDocument(from: store)
                ref.getDocument { snapshot, error in
                    guard let snapshot = snapshot, error == nil else {
                        completion(.failure(error!))
                        return
                    }
                    
                    let store = try? snapshot.data(as: Store.self)
                    completion(.success(store))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
    }

