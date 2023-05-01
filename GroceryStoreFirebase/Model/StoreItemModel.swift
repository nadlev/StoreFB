//
//  StoreItemModel.swift
//  GroceryStoreFirebase
//
//  Created by Надежда Левицкая on 5/1/23.
//

import Foundation

struct StoreItemModel: Codable {
    var name: String = ""
    var price: Double = 0.0
    var quantity: Int = 0
}

extension StoreItemModel {
    
    static func from(_ storeItemVS: StoreItemViewState) -> StoreItemModel {
        return StoreItemModel(name: storeItemVS.name, price: Doublr(storeItemVS.price) ?? 0.0, quantity: Int(storeItemVS.quantity) ?? 0)
    }
}
