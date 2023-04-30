//
//  StoreModel.swift
//  GroceryStoreFirebase
//
//  Created by Надежда Левицкая on 4/24/23.
//

import Foundation

struct Store: Codable {
    var id: String?
    let name: String
    let location: String
    var items: [String]?
}
