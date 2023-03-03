//
//  MainScreenController.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 01/03/23.
//

import Foundation

struct MainScreenController {
    static func showMainScreen() -> Void {
        print("Welcome to UC Walk Cafeteria 👨🏼‍🍳👨🏼‍🍳")
        
        var options = Shop.shops.map({ shop in
            return Utils.ConsoleAskElement.SelectOption(value: String(shop.ID), label: shop.name)
        })
        
       
        options += [
            Utils.ConsoleAsk.option(value: "", label: "-", isSeparator: true),
            Utils.ConsoleAsk.option(value: "S", label: "hopping cart"),
            Utils.ConsoleAsk.option(value: "Q", label: "uit"),
        ]
        

        let select = Utils.ConsoleAsk.dropdown(
            question: "Please choose cafeteria:",
            options: options
        )
        
        
        switch select.value {
        case "S":
            return CartController.showCart()
        case "Q":
            exit(0)
        default:
            let shop = Shop.shops[ Int(select.value)! - 1 ]
            OrderController.startOrder(shop: shop)
        }
    }
}
