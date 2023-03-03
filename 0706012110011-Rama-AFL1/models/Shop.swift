//
//  Shop.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 01/03/23.
//

import Foundation

struct Shop {
    struct Model {
        var ID: Int
        var name: String
        var products: [Product.Model]
    }
    
    static let shops: [Model] = [
        Model( ID: 1, name: "Tuku-Tuku", products: [
            Product.Model(ID: 1, name: "Es POCI TA", price: 10000),
            Product.Model(ID: 2, name: "NISSIN MI", price: 12000),
        ]),
        Model(ID: 2, name: "Gotri", products: [
            Product.Model(ID: 1, name: "Mi Malaysia", price: 25000),
            Product.Model(ID: 2, name: "Es teh tarik", price: 10000)
        ]),
        Model(ID: 3, name: "Madam Lie", products: [
            Product.Model(ID: 1, name: "Paket ayam + Es Teh", price: 28000),
        ]),
        Model(ID: 4, name: "Kopte", products: [
            Product.Model(ID: 1, name: "Kopi asik", price: 10000)
        ])
    ]
}
