//
//  PayView.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 05/04/23.
//

import Foundation


class PayView: ConsoleView, ConsoleViewable {
    var total: Int
    
    init(total: Int) {
        self.total = total
    }
    
    func view() -> Void {
        let money = components.IntegerInput(question: "Please enter the amount of money: ")
        
        if money.value < 0 {
            print("Amount is invalid! \n")
            view()
        }
        
        if money.value == 0 {
            print("Amount cannot be zero! \n")
            view()
        }
        
        if money.value < total {
            print("Insufficient payment amount for this transaction! (need \(total)) \n")
            view()
        }
        
        print("Your total order: \(total)")
        
        
        if money.value > total {
            print("You pay: \(money.value) Change: \(money.value - total)")
        } else {
            print("You pay: \(money.value) (no change)")
        }
        
        // clear the shopping cart
        Consts.resetShoppingCart()
        print("Enjoy your meals!")
        print("\n\nPress [return] to go back to main screen")
        let _ = readLine()
        
        // back to main menu
        clearScreen()
        MainView().view()
    }
}
