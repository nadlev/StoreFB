//
//  ContentView.swift
//  GroceryStoreFirebase
//
//  Created by Надежда Левицкая on 4/23/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented: Bool = false
    @ObservedObject private var storeListVM = StoreListViewModel()
    
    var body: some View {
        VStack {
            List(storeListVM.stores, id: \.storeId) { store in
                VStack(alignment: .leading, spacing: 8) {
                    Text(store.name)
                        .font(.headline)
                    Text(store.location)
                        .font(.body)
                }
            }
        }
        
        .sheet(isPresented: $isPresented, content: {
            AddStoreView()
        })
        
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }, label: {
            Image(systemName: "plus")
        }))
        
        .navigationTitle("Grocery App")
        .embededNavigationView()
        
        .onAppear(perform: {
            storeListVM.getAll()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
