//
//  ConsoleAskUtil.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 01/03/23.
//

import Foundation

typealias _Option = ( value: String, label: String, isSeparator: Bool )


func ConsoleAskUtil_Option(value: String, label: String, isSeparator: Bool = false) -> _Option  {
    return (
        value, label, isSeparator
    )
}

func ConsoleAskUtil_Dropdown(question: String, options: [_Option], caseInsensitive: Bool = true, errorMessage: String = "Invalid input!") -> _Option {
    print(question)
    for option in options {
        if option.isSeparator != true {
            print("[\(option.value)] \(option.label)")
        } else {
            print("\(option.label)")
        }
    }
    
    print("please input one of the selection above: ", terminator: "")
    
    guard var input = readLine() else {
        print("Input is empty! Please fill out the question.")
        return ConsoleAskUtil_Dropdown(question: question, options: options, errorMessage: errorMessage)
    }
    
    var selected: _Option? = nil
    
    if caseInsensitive {
        input = input.lowercased()
    }
    
    for option in options {
        var value = ""
        
        if caseInsensitive {
            value = option.value.lowercased()
        } else {
            value = option.value
        }
        
        if option.isSeparator != true && input == value {
            selected = option
            break
        }
    }
    
    if selected == nil {
        print(errorMessage)
        return ConsoleAskUtil_Dropdown(question: question, options: options, errorMessage: errorMessage)
    }
    
    return selected!
}

func ConsoleAskUtil_Integer(
    question: String,
    errorMessage: String = "Invalid input!",
    cancelable: Bool = false
) -> (canceled: Bool, value: Int) {
    if cancelable {
        print("to cancel, type !CANCEL")
    }
    
    print("\(question) ", terminator: "")
    
    
    
    guard let input = readLine() else {
        print("Input is empty! Please fill out the question.")
        return ConsoleAskUtil_Integer(question: question, errorMessage: errorMessage)
    }
    
    if cancelable {
        if input == "!CANCEL" {
            return (true, 0)
        }
    }
    
    guard let integer = Int(input) else {
        print(errorMessage)
        return ConsoleAskUtil_Integer(question: question, errorMessage: errorMessage)
    }
    
  
    return (false, integer)
}

func ConsoleAskUtil_Confirm(question: String, errorMessage: String = "Invalid input!") -> Bool {
    print("\(question) [y/N]: ", terminator: "")
    
    guard let input = readLine() else {
        print("Input is empty! Please fill out the question.")
        return ConsoleAskUtil_Confirm(question: question, errorMessage: errorMessage)
    }
    
    switch input {
    case let x where ["y", "yes"].contains(x.lowercased()):
        return true
        
    case let x where ["n", "no"].contains(x.lowercased()):
        return false
        
    default:
        print("Please only input only y/N answer!")
        return ConsoleAskUtil_Confirm(question: question, errorMessage: errorMessage)
    }
}
