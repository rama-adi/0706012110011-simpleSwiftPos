//
//  CartController.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 02/03/23.
//

import Foundation



/// function to show the cart content
func CartController_ShowCart() {
    print("Your orders:")
    
    var total = 0
    
    // if the cart is empty
    if Consts_ShoppingCart.isEmpty {
        print("Your shopping cart is still empty")
        print("\nPress [return] to go back to main screen")
        let _ = readLine()
        
        ConsoleUtil_ClearScreen()
        MainScreenController_ShowMainScreen()
    
    }
    
    
    // get the total amount
    total = CartController_ShowBuyProduct()
    
    CartController_ConfirmPayment(total: total)
}


/// function to show the products in the cart
func CartController_ShowBuyProduct() -> Int {
    var total = 0
    
    // Dictionary format: [ Shop Name -> [ Product Name -> ( price, amount bought ) ] ]
    // this groups all of the products bought from the same shop together
    Consts_ShoppingCart.forEach({ (shop, carts) in
        print("Products from \(shop):")
        carts.forEach({ product, data in
            print("- \(product) x\(data.amount)")
            total += data.amount * data.price
        })
    })
    
    return total
}

/// function to confirm the user payment
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
    
    // clear the shopping cart
    Consts_ShoppingCart = [:]
    print("Enjoy your meals!")
    print("\n\nPress [return] to go back to main screen")
    let _ = readLine()
    
    // back to main menu
    ConsoleUtil_ClearScreen()
    MainScreenController_ShowMainScreen()
}

