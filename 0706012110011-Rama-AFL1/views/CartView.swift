//
//  CartView.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 05/04/23.
//

import Foundation


class CartView: ConsoleView, ConsoleViewable {
    func view() -> Void {
        print("🛒 Your orders:")
        
        if Consts.getShoppingCart().isEmpty {
            print("❌ Your shopping cart is still empty")
            print("\nPress [return] to go back to main screen")
            let _ = readLine()
            
            clearScreen()
            MainView().view()
        }
        
        // get the total amount
        let total = showPurchasedProduct()
        print("💵 Total amount needed to pay: \(total). we did not accept NGEBON.")
        PayView(total: total).view()
    }
    
    
    func showPurchasedProduct() -> Int {
        var total = 0
        
        // Dictionary format: [ Shop Name -> [ Product Name -> ( price, amount bought ) ] ]
        // this groups all of the products bought from the same shop together
        Consts.getShoppingCart().forEach({ (shop, carts) in
            print("Products from \(shop):")
            carts.forEach({ product, data in
                print("- \(product) x\(data.amount)")
                total += data.amount * data.price
            })
        })
        
        return total
    }
    
    
}
