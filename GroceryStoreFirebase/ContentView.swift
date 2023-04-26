//
//  ContentView.swift
//  GroceryStoreFirebase
//
//  Created by Надежда Левицкая on 4/23/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            Text("Hello")
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
