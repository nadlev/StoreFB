//
//  StoreItemListViewModel.swift
//  GroceryStoreFirebase
//
//  Created by Надежда Левицкая on 4/29/23.
//

import Foundation

struct StoreItemViewState {
    var name: String = ""
    var price: String = ""
    var quantity: String = ""
}

struct StoreItemViewModel {
    let storeItem: StoreItemModel
    
    var name: String {
        storeItem.name
    }
    
    var price: Double {
        storeItem.price
    }
    
    var quantity: Int {
        storeItem.quantity
    }
}


class StoreItemListViewModel: ObservableObject {
    private var firestoreManager: FirestoreManager
    var groceryItemName: String = ""
    @Published var store: StoreViewModel?
    @Published var storeItems: [StoreItemViewModel] = []
    
    var storeItemVS = StoreItemViewState()
    
    init() {
        firestoreManager = FirestoreManager()
    }
    
    func getStoreItemsBy(storeId: String) {
        
        firestoreManager.getStoreItemsBy(storeId: storeId) { result in
            switch result {
            case .success(let items):
                if let items = items {
                    DispatchQueue.main.async {
                        self.storeItems = items.map(StoreItemViewModel.init)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
    
    func addItemsToStore(storeId: String, completion: @escaping (Error?) -> Void) {
        
        let storeItem = StoreItemModel.from(storeItemVS)
        firestoreManager.updateStore(storeId: storeId, storeItem: storeItem) {
            result in
            switch result {
            case .success(_):
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    /*func addItemsToStore(storeId: String) {
        
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
    }*/
}
