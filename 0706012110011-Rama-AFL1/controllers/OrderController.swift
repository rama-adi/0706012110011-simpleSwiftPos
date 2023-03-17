//
//  OrderController.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 01/03/23.
//

import Foundation


/// function to start the ordering process from a certain shop
func OrderController_StartOrder(shop: ShopModel) {
    ConsoleUtil_ClearScreen()
    
    print("Hi, welcome back to \(shop.name)!")
    
    // prepares the product to add in the option
    var options = shop.products.map({ product in
        return Util_ConsoleAsk_Option(value: String(product.ID), label: product.name)
    })
    
    // extra options passed to add separator or back button
    options += [
        Util_ConsoleAsk_Option(value: "", label: "-", isSeparator: true),
        Util_ConsoleAsk_Option(value: "B", label: "ack to main menu"),
    ]
    
    let select = Util_ConsoleAsk_Dropdown(
        question: "What would you like to order?",
        options: options,
        caseInsensitive: true
    )
    
    switch select.value {
    case "B":
        MainScreenController_ShowMainScreen()
    default:
        let product = shop.products[ Int(select.value)! - 1 ]
        OrderController_OrderProcess__P(product: product, shop: shop)
        
    }
}

/// function to ask the user how much of the product they want to buy
func OrderController_OrderProcess__P(product: ProductModel, shop: ShopModel) {
    ConsoleUtil_ClearScreen()
    print("\(product.name) @ \(product.price)")
    
    let amountQuestion = Util_ConsoleAsk_Integer(
        question: "How many \(product.name) do you want to buy?",
        cancelable: true
    )
    
    // a user can cancel their order if they wanted to
    if amountQuestion.canceled {
        ConsoleUtil_ClearScreen()
        OrderController_StartOrder(shop: shop)
    }
    
    // sanity check for the amount
    if amountQuestion.value == 0 {
        print("You didn't order the item. not added to the cart.")
    } else {
        ProductModel_AddToCart(shop: shop, product: product, amount: amountQuestion.value)
        print("\(amountQuestion.value)x \(product.name) - Total: \(product.price * amountQuestion.value)")
        print("Added to cart.")
    }
    
    // they can also add more items if they want
    let addMore = Util_ConsoleAsk_Confirm(question: "Do you want to add more product from this store?")
    
    if addMore {
        ConsoleUtil_ClearScreen()
        OrderController_StartOrder(shop: shop)
    }
    
    
    ConsoleUtil_ClearScreen()
    MainScreenController_ShowMainScreen()
}
