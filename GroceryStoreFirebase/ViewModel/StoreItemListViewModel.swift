//
//  StoreItemListViewModel.swift
//  GroceryStoreFirebase
//
//  Created by Надежда Левицкая on 4/29/23.
//

import Foundation

class StoreItemListViewModel: ObservableObject {
    private var firestoreManager: FirestoreManager
    var groceryItemName: String = ""
    @Published var store: StoreViewModel?
    
    
    init() {
        firestoreManager = FirestoreManager()
    }
    
    func getStoreById(storeId: String) {
        firestoreManager.getStoreByID(storeId: storeId) { result in
            switch result {
            case .success(let store):
                if let store = store {
                    DispatchQueue.main.async {
                        self.store = StoreViewModel(store: store)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addItemsToStore(storeId: String) {
        
        firestoreManager.updateStore(storeId: storeId, values: ["items": [groceryItemName]]) { result in
            switch result {
            case .success(let storeModel):
                if let model = storeModel {
                    DispatchQueue.main.async {
                        self.store = StoreViewModel(store: model)

                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
