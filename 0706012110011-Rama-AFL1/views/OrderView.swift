//
//  OrderView.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 05/04/23.
//

import Foundation

/// class to start the ordering process from a certain shop
class OrderView: ConsoleView, ConsoleViewable {
    private var selectedShop: Shop
    
    init(selectedShop: Shop) {
        self.selectedShop = selectedShop
    }
    
    func view() -> Void {
        print("Hi, welcome back to \(selectedShop.name)!")
        
        // prepares the product to add in the option
        var options = selectedShop.products.map({ product in
            return components.dropdownOption(value: String(product.ID), label: product.name)
        })
        
        // extra options passed to add separator or back button
        options += [
            components.dropdownOption(value: "", label: "-", isSeparator: true),
            components.dropdownOption(value: "B", label: "ack to main menu"),
        ]
        
        let select = components.DropdownInput(
            question: "What would you like to order?",
            options: options,
            config: ConsoleComponent.DropdownInputConfiguration(caseInsensitive: true)
        )
        
        switch select.value {
        case "B":
            MainView().view()
        default:
            orderProcess(product: selectedShop.products[ Int(select.value)! - 1 ])
            
        }
    }
    
    fileprivate func orderProcess(product: Product) {
        clearScreen()
        print("\(product.name) @ \(product.price)")
        
        let amountQuestion = components.IntegerInput(
            question: "How many \(product.name) do you want to buy?",
            config: ConsoleComponent.IntegerInputConfiguration(cancelable: true)
        )
        
        // a user can cancel their order if they wanted to
        if amountQuestion.canceled {
            clearScreen()
            view()
        }
        
        
        // sanity check for the amount
        if amountQuestion.value == 0 {
            print("You didn't order the item. not added to the cart.")
        } else {
            Consts.addToShoppingCart(shop: selectedShop, product: product, amount: amountQuestion.value)
            print("\(amountQuestion.value)x \(product.name) - Total: \(product.price * amountQuestion.value)")
            print("Added to cart.")
        }
        
        // they can also add more items if they want
        let addMore = components.ConfirmationInput(question: "Do you want to add more product from this store?")
        
        if addMore {
            clearScreen()
            view()
        }
        
        
        clearScreen()
        MainView().view()
    }
}
