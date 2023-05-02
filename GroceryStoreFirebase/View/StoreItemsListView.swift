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
    
    private func deleteStoreItem(at indexSet: IndexSet) {
        indexSet.forEach{ index in
            let storeItem = storeItemsListVM.storeItems[index]
            storeItemsListVM.deleteStoreItem(storeId: store.storeId, storeItemId: storeItem.storeItem.id)
        }
    }
    
    var body: some View {
        VStack {
            TextField("Enter item name", text: $storeItemsListVM.storeItemVS.name).textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Enter price", text: $storeItemsListVM.storeItemVS.price).textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Enter quantity", text: $storeItemsListVM.storeItemVS.quantity).textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save") {
                storeItemsListVM.addItemsToStore(storeId: store.storeId) { error in
                    
                    if error == nil {
                        storeItemsListVM.getStoreItemsBy(storeId: store.storeId)
                    }
                }
                
            }
            
            List {
                ForEach(storeItemsListVM.storeItems, id: \.storeItem.id) {
                    storeItem in
                    Text(storeItem.name)
                }.onDelete(perform: deleteStoreItem)
            }
            
            
            /*if let store = storeItemsListVM.store {
                List(store.items, id: \.self) { item in
                    Text(item)
                }
            }*/
            
            Spacer()
            
            .onAppear(perform: {
                storeItemsListVM.getStoreItemsBy(storeId: store.storeId)
            })
        }
    }
}

struct StoreItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        StoreItemsListView(store: StoreViewModel(store: Store(name: "123", location: "1200")))
    }
}
