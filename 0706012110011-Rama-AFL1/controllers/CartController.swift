//
//  CartController.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 02/03/23.
//

import Foundation


struct CartController {
    static func showCart() {
        print("Your orders:")
        
        var total = 0
        
        if Consts_ShoppingCart.isEmpty {
            print("Your shopping cart is still empty")
            print("\nPress [return] to go back to main screen")
            let _ = readLine()
            
            MainScreenController_ShowMainScreen()
        
        }
        
        
        Consts_ShoppingCart.forEach({ (item, amount) in
            print("- \(item.name) (\(item.price) ea) x\(amount) - \(item.price * amount)")
            total += (item.price * amount)
        })
        
        if !Consts_ShoppingCart.isEmpty {
            print("Total price: \(total)")
            let confirmPaymentNow = ConsoleAskUtil_Confirm(question: "Do you want to pay now?")
            
            if confirmPaymentNow {
                confirmPayment(total: total)
            } else {
                MainScreenController_ShowMainScreen()
            }
        }
    }
    
    
    static func confirmPayment(total: Int) {
        let money = ConsoleAskUtil_Integer(question: "Please enter the amount of money: ")
        
        if money.value < 0 {
            print("Amount is invalid! \n")
            confirmPayment(total: total)
        }
        
        if money.value == 0 {
            print("Amount cannot be zero! \n")
            confirmPayment(total: total)
        }
        
        if money.value < total {
            print("Insufficient payment amount for this transaction! (need \(total)) \n")
            confirmPayment(total: total)
        }
        
        print("Your total order: \(total)")
        
        
        if money.value > total {
            print("You pay: \(money) Change: \(money.value - total)")
        } else {
            print("You pay: \(money) (no change)")
        }
        
        Consts_ShoppingCart = [:]
        print("Enjoy your meals!")
        print("\n\nPress [return] to go back to main screen")
        let _ = readLine()
        
        MainScreenController_ShowMainScreen()
    }
}
