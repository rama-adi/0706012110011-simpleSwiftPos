//
//  ProductAfl1.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 03/03/23.
//

import Foundation
var Consts_ShoppingCart: [String: Int] = [:]
typealias ProductModel = ( ID: Int, name: String, price: Int )


func ProductModel_AddToCart(shop:ShopModel, product: ProductModel, amount: Int) {
    Consts_ShoppingCart["\(shop.ID)|\(product.ID)"] += (Consts_ShoppingCart["SHOPID:\(shop.ID)-PID:\(product.ID)"] ?? 0) + amount
}
