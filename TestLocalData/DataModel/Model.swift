//
//  Model.swift
//  TestLocalData
//
//  Created by Michele Manniello on 09/07/22.
//

import UIKit
import SwiftUI
struct Person: Codable,Identifiable{
    var id = UUID().uuidString
    var name: String
    var surname: String
    var age: Int
    
    enum CodingKes: CodingKey{
        case name
        case surname
        case age
    }
}
let persons = [
    Person(name: "Pippo", surname: "Pluto", age: 20),
    Person(name: "Paperino", surname: "Gianni", age: 34),
    Person(name: "Topino", surname: "Rossi", age: 40)
]
