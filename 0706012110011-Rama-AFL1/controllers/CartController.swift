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
        
        if Consts.shoppingCart.isEmpty {
            print("Your shopping cart is still empty")
            print("\nPress [return] to go back to main screen")
            let _ = readLine()
            
            MainScreenController.showMainScreen()
        
        }
        
        
        Consts.shoppingCart.forEach({ (item, amount) in
            print("- \(item.name) (\(item.price) ea) x\(amount) - \(item.price * amount)")
            total += (item.price * amount)
        })
        
        if !Consts.shoppingCart.isEmpty {
            print("Total price: \(total)")
            let confirmPaymentNow = Utils.ConsoleAsk.confirm(question: "Do you want to pay now?")
            
            if confirmPaymentNow {
                confirmPayment(total: total)
            } else {
                MainScreenController.showMainScreen()
            }
        }
    }
    
    
    static func confirmPayment(total: Int) {
        let money = Utils.ConsoleAsk.integer(question: "Please enter the amount of money: ")
        
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
        
        Consts.shoppingCart = [:]
        print("Enjoy your meals!")
        print("\n\nPress [return] to go back to main screen")
        let _ = readLine()
        
        MainScreenController.showMainScreen()
    }
}
