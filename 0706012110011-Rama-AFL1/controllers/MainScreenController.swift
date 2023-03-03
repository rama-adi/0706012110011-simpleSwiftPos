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
        
        var options = Model_Shops_GetShops.map({ shop in
            return ConsoleAskUtil_Option(value: String(shop.ID), label: shop.name)
        })
        
       
        options += [
            ConsoleAskUtil_Option(value: "", label: "-", isSeparator: true),
            ConsoleAskUtil_Option(value: "S", label: "hopping cart"),
            ConsoleAskUtil_Option(value: "Q", label: "uit")
        ]
        

        let select = ConsoleAskUtil_Dropdown(
            question: "Please choose cafeteria:",
            options: options
        )
        
        
        switch select.value {
        case "S":
            return CartController.showCart()
        case "Q":
            exit(0)
        default:
            let shop = Model_Shops_GetShops[ Int(select.value)! - 1 ]
            OrderController.startOrder(shop: shop)
        }
    }
}
