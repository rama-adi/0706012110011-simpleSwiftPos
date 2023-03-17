//
//  ProductAfl1.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 03/03/23.
//

import Foundation
// the shopping cart
var Consts_ShoppingCart: [ String: [ String: (price: Int, amount: Int) ] ] = [:]

// typealias to shrink the length of declaration
typealias ProductModel = ( ID: Int, name: String, price: Int )

/// function to add an item to the cart
func ProductModel_AddToCart(shop:ShopModel, product: ProductModel, amount: Int) {
    
    // do some initialization before we can add to the cart
    if Consts_ShoppingCart[shop.name] == nil {
        Consts_ShoppingCart[shop.name] = [:]
    }
    
    if Consts_ShoppingCart[shop.name]![product.name] == nil {
        Consts_ShoppingCart[shop.name]![product.name] = (
            price: product.price,
            amount: 0
        )
    }
    
    
    // add to the cart after initialization is done
    Consts_ShoppingCart[shop.name]![product.name] = (
        price: product.price,
        amount: Consts_ShoppingCart[shop.name]![product.name]!.amount + amount
    )
    
}
