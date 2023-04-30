//
//  StoreItemsListView.swift
//  GroceryStoreFirebase
//
//  Created by Надежда Левицкая on 4/30/23.
//

import SwiftUI

struct StoreItemsListView: View {
    
    var store: StoreViewModel
    @StateObject private var storeItemsListVM = StoreItemListViewModel()
    
    var body: some View {
        VStack {
            TextField("Enter item name", text: $storeItemsListVM.groceryItemName).textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save") {
                storeItemsListVM.addItemsToStore(storeId: store.storeId)
            }
            
            if let store = storeItemsListVM.store {
                List(store.items, id: \.self) { item in
                    Text(item)
                }
            }
            
            Spacer()
            
            .onAppear(perform: {
                storeItemsListVM.getStoreById(storeId: store.storeId)
            })
        }
    }
}

struct StoreItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        StoreItemsListView(store: StoreViewModel(store: Store(name: "123", location: "1200")))
    }
}
