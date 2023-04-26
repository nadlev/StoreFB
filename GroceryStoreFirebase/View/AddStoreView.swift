//
//  AddStoreView.swift
//  GroceryStoreFirebase
//
//  Created by Надежда Левицкая on 4/24/23.
//

import SwiftUI

struct AddStoreView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var addStoreVM = AddStoreViewModel()
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $addStoreVM.name)
                TextField("Location", text: $addStoreVM.location)
                
                HStack {
                    Spacer()
                    Button("Save") {
                        addStoreVM.save()
                    }.onChange(of: addStoreVM.saved) { newValue in
                        if newValue {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    Spacer()
                }
                
                Text(addStoreVM.message)
            }
            
        }
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
        }))
        .navigationTitle("Add new store")
        .embededNavigationView()
    }
}

struct AddStoreView_Previews: PreviewProvider {
    static var previews: some View {
        AddStoreView()
    }
}
