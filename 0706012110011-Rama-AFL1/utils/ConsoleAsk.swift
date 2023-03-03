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

func confirm(question: String, errorMessage: String = "Invalid input!") -> Bool {
    print("\(question) [y/N]: ", terminator: "")
    
    guard let input = readLine() else {
        print("Input is empty! Please fill out the question.")
        return confirm(question: question, errorMessage: errorMessage)
    }
    
    switch input {
    case let x where ["y", "yes"].contains(x.lowercased()):
        return true
        
    case let x where ["n", "no"].contains(x.lowercased()):
        return false
        
    default:
        print("Please only input only y/N answer!")
        return confirm(question: question, errorMessage: errorMessage)
    }
}

struct ConsoleAskUtil {
    
    struct SelectOption {
        var value: String
        var label: String
        var isSeparator: Bool = false
    }
    
    /// Build the options that the user can pick
    func option(value: String, label: String, isSeparator: Bool = false)
    -> SelectOption {
        return SelectOption(
            value: value,
            label: label,
            isSeparator: isSeparator
        )
        
    }
    
    /// Presents a list of options the user can pick.
    ///
    /// The user must input the left-hand string inside of brackets to select the option
    /// otherwise, re-prompt them again
    func dropdown(question: String, options: [SelectOption], caseInsensitive: Bool = true, errorMessage: String = "Invalid input!")
    -> SelectOption {
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
            return dropdown(question: question, options: options, errorMessage: errorMessage)
        }
        
        var selected: SelectOption? = nil
        
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
            return dropdown(question: question, options: options, errorMessage: errorMessage)
        }
        
        return selected!
        
    }
    
    /// Asks the user for input and return the resulting input.
    ///
    /// the type of input is integer
    /// if the user's input are invalid, ask them again
    func integer(
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
            return integer(question: question, errorMessage: errorMessage)
        }
        
        if cancelable {
            if input == "!CANCEL" {
                return (true, 0)
            }
        }
        
        guard let integer = Int(input) else {
            print(errorMessage)
            return integer(question: question, errorMessage: errorMessage)
        }
        
      
        return (false, integer)
    }
    
    /// Asks the user to confirm their selection.
    /// 
    /// User must confirm by entering: yes/y or no/n
    func confirm(question: String, errorMessage: String = "Invalid input!") -> Bool {
        print("\(question) [y/N]: ", terminator: "")
        
        guard let input = readLine() else {
            print("Input is empty! Please fill out the question.")
            return confirm(question: question, errorMessage: errorMessage)
        }
        
        switch input {
        case let x where ["y", "yes"].contains(x.lowercased()):
            return true
            
        case let x where ["n", "no"].contains(x.lowercased()):
            return false
            
        default:
            print("Please only input only y/N answer!")
            return confirm(question: question, errorMessage: errorMessage)
        }
    }
    
    
}
