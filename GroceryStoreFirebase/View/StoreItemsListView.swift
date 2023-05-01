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
            TextField("Enter item name", text: $storeItemsListVM.storeItemVS.name).textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Enter price", text: $storeItemsListVM.storeItemVS.price).textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Enter quantity", text: $storeItemsListVM.storeItemVS.quantity).textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save") {
                storeItemsListVM.addItemsToStore(storeId: store.storeId) { error in
                    
                }
                //storeItemsListVM.addItemsToStore(storeId: store.storeId)
            }
            
            List(storeItemsListVM, id: \.name) { item in
                Text(item.name)
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
