//
//  Consts.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 05/04/23.
//

import Foundation


struct Consts {
    
    typealias shoppingCartType = [ String: [ String: (price: Int, amount: Int) ] ]
    fileprivate static var shoppingCart: shoppingCartType = [:]
    
    static let shops: [Shop] = [
        Shop(ID: 1, name: "Tuku-tuku", products: [
            Product(ID: 1, name: "Es Teh Poci", price: 10000),
            Product(ID: 2, name: "Nissin Mie", price: 12000)
        ]),
        
        Shop(ID: 2, name: "Gotri", products: [
            Product(ID: 1, name: "Mi malaysia", price: 25000),
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
    
    /// function to add an item to the cart
    static func addToShoppingCart(shop:Shop, product: Product, amount: Int) {
        
        // do some initialization before we can add to the cart
        if shoppingCart[shop.name] == nil {
            shoppingCart[shop.name] = [:]
        }
        
        
        if shoppingCart[shop.name]![product.name] == nil {
            shoppingCart[shop.name]![product.name] = (
                price: product.price,
                amount: 0
            )
        }
        
        
        // add to the cart after initialization is done
        shoppingCart[shop.name]![product.name] = (
            price: product.price,
            amount: shoppingCart[shop.name]![product.name]!.amount + amount
        )
        
    }
    
    static func getShoppingCart() -> shoppingCartType {
        return shoppingCart
    }
    
    static func resetShoppingCart() {
        shoppingCart = [:]
    }
}
