//
//  OrderController.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 01/03/23.
//

import Foundation

struct OrderController {
    static func startOrder(shop: Shop.Model) {
        Utils.Console.clearScreen()
        
        print("Hi, welcome back to \(shop.name)!")
    
        
        var options = shop.products.map({ product in
            return Utils.ConsoleAsk.option(value: String(product.ID), label: product.name)
        })
        
        options += [
            Utils.ConsoleAsk.option(value: "", label: "-", isSeparator: true),
            Utils.ConsoleAsk.option(value: "B", label: "ack to main menu"),
        ]
        
        let select = Utils.ConsoleAsk.dropdown(
            question: "What would you like to order?",
            options: options,
            caseInsensitive: true
        )
        
        switch select.value {
        case "B":
            MainScreenController.showMainScreen()
        default:
            let product = shop.products[ Int(select.value)! - 1 ]
            orderProcess(product: product, shop: shop)
            
        }
    }
    
    static private func orderProcess(product: Product.Model, shop: Shop.Model) {
        Utils.Console.clearScreen()
        print("\(product.name) @ \(product.price)")
        
        let amountQuestion = Utils.ConsoleAsk.integer(
            question: "How many \(product.name) do you want to buy?",
            cancelable: true
        )
        
        if amountQuestion.canceled {
            startOrder(shop: shop)
        }
        
    
        if amountQuestion.value == 0 {
            print("You didn't order the item. not added to the cart.")
        } else {
            Consts.shoppingCart[product] = (Consts.shoppingCart[product] ?? 0) + amountQuestion.value
            print("\(amountQuestion.value)x \(product.name) - Total: \(product.price * amountQuestion.value)")
            print("Added to cart.")
        }
        
        let addMore = Utils.ConsoleAsk.confirm(question: "Do you want to add more product from this store?")
        
        if addMore {
            startOrder(shop: shop)
        }
        
        MainScreenController.showMainScreen()
    }
}
