//
//  ProductAfl1.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 03/03/23.
//

import Foundation

class Product: Identifiable {
    var ID: Int
    var name: String
    var price: Int
    
    init(ID: Int, name: String, price: Int) {
        self.ID = ID
        self.name = name
        self.price = price
    }
}
