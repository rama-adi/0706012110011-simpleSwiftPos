//
//  ProductAfl1.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 03/03/23.
//

import Foundation
var Consts_ShoppingCart: [ String: [ String: (price: Int, amount: Int) ] ] = [:]

typealias ProductModel = ( ID: Int, name: String, price: Int )


func ProductModel_AddToCart(shop:ShopModel, product: ProductModel, amount: Int) {
    
    if Consts_ShoppingCart[shop.name] == nil {
        Consts_ShoppingCart[shop.name] = [:]
    }
    if Consts_ShoppingCart[shop.name]![product.name] == nil {
        Consts_ShoppingCart[shop.name]![product.name] = (
            price: product.price,
            amount: 0
        )
    }
    
    Consts_ShoppingCart[shop.name]![product.name] = (
        price: product.price,
        amount: Consts_ShoppingCart[shop.name]![product.name]!.amount + amount
    )
    
}
