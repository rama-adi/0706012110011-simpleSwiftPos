//
//  ShopAfl1.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 03/03/23.
//

import Foundation

// typealias to shrink the length of declaration
typealias ShopModel = (ID: Int, name: String, products: [ ProductModel ])

// model definitions for the shop
let Model_Shops_GetShops: [ShopModel] = [
    ( ID: 1, name: "tuku-tuku", products: [
        (ID: 1, name: "Es teh poci", price: 10000),
        (ID: 2, name: "Nissin Mie", price: 12000)
    ]),
    
    ( ID: 2, name: "Gotri", products: [
        (ID: 1, name: "Mi malaysia", price: 10000),
        (ID: 2, name: "Es teh tarik", price: 12000)
    ]),
    
    ( ID: 3, name: "Madam Lie", products: [
        (ID: 1, name: "Paket Ayam + Nasi + Es teh", price: 28000),
    ]),
    
    
    ( ID: 4, name: "Kopte", products: [
        (ID: 1, name: "Kopi Asik", price: 10000),
    ]),
]


