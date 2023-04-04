//
//  ConsoleView.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 04/04/23.
//

import Foundation

protocol ConsoleViewable {
    func view() -> Void
}

class ConsoleView {
    let components: ConsoleComponent = ConsoleComponent()
    
    func clearScreen() -> Void {
        for _ in 1...100 {
            print("")
        }
    }
}
