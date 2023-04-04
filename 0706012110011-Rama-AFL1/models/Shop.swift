//
//  ShopAfl1.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 03/03/23.
//

import Foundation


struct Shop {
    static let shared: [Shop] = [
        Shop(ID: 1, name: "Tuku-tuku", products: [
            Product(ID: 1, name: "Es Teh Poci", price: 10000),
            Product(ID: 2, name: "Nissin Mie", price: 12000)
        ]),
        
        Shop(ID: 2, name: "Gotri", products: [
           Product(ID: 1, name: "Mi malaysia", price: 25000)
           Product(ID: 2, name: "Es teh tarik", price: 12000)
        ]),
        
        Shop(ID: 3, name: "Madam Lie", products: [
            Product(ID: 1, name: "Paket Ayam + Nasi + Es Teh", price: 28000),
            Product(ID: 2, name: "Paket Ayam + Nasi", price: 20000)
        ]),
        
        Shop(ID: 4, name: "Kopte", products: [
            Product(ID: 1, name: "Es teh tarik", price: 18000)
        ])
    ]
    
    class Shop: Identifiable {
        var ID: Int
        var name: String
        var products: [Product]
        
        init(ID: Int, name: String, products: [Product]) {
            self.ID = ID
            self.name = name
            self.products = products
        }
    }
}


