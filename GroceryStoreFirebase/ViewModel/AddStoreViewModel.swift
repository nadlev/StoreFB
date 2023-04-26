//
//  AddStoreViewModel.swift
//  GroceryStoreFirebase
//
//  Created by Надежда Левицкая on 4/24/23.
//

import Foundation

class AddStoreViewModel: ObservableObject {
    
    private var firestoreManager: FirestoreManager
    @Published var saved: Bool = false
    @Published var message: String = ""
    
    var name: String = ""
    var location: String = ""
    
    init() {
        firestoreManager = FirestoreManager()
    }
    
    func save() {
        
        let store = Store(name: name, location: location)
        firestoreManager.save(store: store) { result in
            switch result {
            case .success(let store):
                DispatchQueue.main.async {
                    self.saved = store == nil ? false : true
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.message = Constants.Messeges.storedSavedFailure
                }
            }
        }
    }
}
