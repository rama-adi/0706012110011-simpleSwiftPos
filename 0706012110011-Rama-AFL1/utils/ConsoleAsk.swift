//
//  ConsoleAskUtil.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 01/03/23.
//

import Foundation

typealias Util_ConsoleAsk_Option_Type = ( value: String, label: String, isSeparator: Bool )


func Util_ConsoleAsk_Option(value: String, label: String, isSeparator: Bool = false) -> Util_ConsoleAsk_Option_Type  {
    return (
        value, label, isSeparator
    )
}

func Util_ConsoleAsk_Dropdown(question: String, options: [Util_ConsoleAsk_Option_Type], caseInsensitive: Bool = true, errorMessage: String = "Invalid input!") -> Util_ConsoleAsk_Option_Type {
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
        return Util_ConsoleAsk_Dropdown(question: question, options: options, errorMessage: errorMessage)
    }
    
    var selected: Util_ConsoleAsk_Option_Type? = nil
    
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
        return Util_ConsoleAsk_Dropdown(question: question, options: options, errorMessage: errorMessage)
    }
    
    return selected!
}

func Util_ConsoleAsk_Integer(
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
        return Util_ConsoleAsk_Integer(question: question, errorMessage: errorMessage)
    }
    
    if cancelable {
        if input == "!CANCEL" {
            return (true, 0)
        }
    }
    
    guard let integer = Int(input) else {
        print(errorMessage)
        return Util_ConsoleAsk_Integer(question: question, errorMessage: errorMessage)
    }
    
  
    return (false, integer)
}
