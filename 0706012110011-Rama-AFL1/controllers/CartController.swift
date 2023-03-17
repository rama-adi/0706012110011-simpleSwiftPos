//
//  CartController.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 02/03/23.
//

import Foundation


func CartController_ShowCart() {
    print("Your orders:")
    
    var total = 0
    
    if Consts_ShoppingCart.isEmpty {
        print("Your shopping cart is still empty")
        print("\nPress [return] to go back to main screen")
        let _ = readLine()
        
        MainScreenController_ShowMainScreen()
    
    }
    
    
    
    total = CartController_ShowBuyProduct()
    
    if !Consts_ShoppingCart.isEmpty {
        print("Total price: \(total)")
        let confirmPaymentNow = Util_ConsoleAsk_Confirm(question: "Do you want to pay now?")
        
        if confirmPaymentNow {
            CartController_ConfirmPayment(total: total)
        } else {
            MainScreenController_ShowMainScreen()
        }
    }
}

func CartController_ShowBuyProduct() -> Int {
    var total = 0
    
    Consts_ShoppingCart.forEach({ (shop, carts) in
        print("Products from \(shop):")
        carts.forEach({ product, data in
            print("- \(product) x\(data.amount)")
            total += data.amount * data.price
        })
    })
    
    return total
}

func CartController_BreakdownIDSequence(IDSequence: String) -> (shop: ShopModel, product: ProductModel) {
    let sequence = IDSequence.components(separatedBy: "|")
    let shop = Model_Shops_GetShops.filter{ String($0.ID) == sequence[0] }[0]
    let product = shop.products.filter{ String($0.ID) == sequence[1] }[0]
    
    return (shop, product)
}

func CartController_ConfirmPayment(total: Int) {
    let money = Util_ConsoleAsk_Integer(question: "Please enter the amount of money: ")
    
    if money.value < 0 {
        print("Amount is invalid! \n")
        CartController_ConfirmPayment(total: total)
    }
    
    if money.value == 0 {
        print("Amount cannot be zero! \n")
        CartController_ConfirmPayment(total: total)
    }
    
    if money.value < total {
        print("Insufficient payment amount for this transaction! (need \(total)) \n")
        CartController_ConfirmPayment(total: total)
    }
    
    print("Your total order: \(total)")
    
    
    if money.value > total {
        print("You pay: \(money.value) Change: \(money.value - total)")
    } else {
        print("You pay: \(money.value) (no change)")
    }
    
    Consts_ShoppingCart = [:]
    print("Enjoy your meals!")
    print("\n\nPress [return] to go back to main screen")
    let _ = readLine()
    
    MainScreenController_ShowMainScreen()
}

