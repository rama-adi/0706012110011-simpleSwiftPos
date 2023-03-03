//
//  MainScreenController.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 01/03/23.
//

import Foundation

func MainScreenController_ShowMainScreen() -> Void {
    print("Welcome to UC Walk Cafeteria 👨🏼‍🍳👨🏼‍🍳")
    
    var options = Model_Shops_GetShops.map({ shop in
        return Util_ConsoleAsk_Option(value: String(shop.ID), label: shop.name)
    })
    
   
    options += [
        Util_ConsoleAsk_Option(value: "", label: "-", isSeparator: true),
        Util_ConsoleAsk_Option(value: "S", label: "hopping cart"),
        Util_ConsoleAsk_Option(value: "Q", label: "uit")
    ]
    

    let select = Util_ConsoleAsk_Dropdown(
        question: "Please choose cafeteria:",
        options: options,
        caseInsensitive: true
    )
    
    
    switch select.value {
    case "S":
        CartController_ShowCart()
    case "Q":
        exit(0)
    default:
        let shop = Model_Shops_GetShops[ Int(select.value)! - 1 ]
        OrderController_StartOrder(shop: shop)
    }
}
