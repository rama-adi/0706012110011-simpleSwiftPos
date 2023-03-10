//
//  ConsoleAskUtil.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 01/03/23.
//

import Foundation

/// A type alias for the shape of an option type in dictionary form
///
/// **This is an internal typealias only used by the ConsoleAsk utility**, if you want to add a dropdown
/// question to your console app, please use the `Util_ConsoleAsk_Option` function
///
///     let available_desserts = [
///         Util_ConsoleAsk_Option(value: "1", "Croffle")
///         Util_ConsoleAsk_Option(value: "2", "Donut")
///     ]
typealias Util_ConsoleAsk_Option_Type = ( value: String, label: String, isSeparator: Bool )


/// A proxy for the `Util_ConsoleAsk_Option_Type` typealias that presents the shape of an option in a dictionary format
///
/// a `Util_ConsoleAsk_Confirm` will accepts an array of `Util_ConsoleAsk_Option_Type` to display a list of options the user can pick from
///
///     let available_desserts = [
///         Util_ConsoleAsk_Option(value: "1", "Croffle")
///         Util_ConsoleAsk_Option(value: "2", "Donut")
///     ]
func Util_ConsoleAsk_Option(value: String, label: String, isSeparator: Bool = false) -> Util_ConsoleAsk_Option_Type  {
    return (
        value, label, isSeparator
    )
}


/// Presents the user a yes/no confirmation message. the user can type in `yes/no` or `y/n` (case insesitive) to confirm their selection
///
/// To present a user with a yes/no question. if the user tries to input anything except a yes/no question, they will be asked to re-input their answer.
///
///     let like_dessert = Util_ConsoleAsk_Confirm(
///         question: "Do you like dessert?"
///     )
///
/// - Parameters:
///   - question: the question that the user must confirm with yes/no
///   - errorMessage: an optional error message that you can costumize
/// - Returns: a boolean that confirms their selection (true - yes, and false - no)
func Util_ConsoleAsk_Confirm(question: String, errorMessage: String = "Invalid input!") -> Bool {
    print("\(question) [y/N]: ", terminator: "")
    
    guard let input = readLine() else {
        print("Input is empty! Please fill out the question.")
        return Util_ConsoleAsk_Confirm(question: question, errorMessage: errorMessage)
    }
    
    switch input {
    case let x where ["y", "yes"].contains(x.lowercased()):
        return true
        
    case let x where ["n", "no"].contains(x.lowercased()):
        return false
        
    default:
        print("Please only input only y/N answer!")
        return Util_ConsoleAsk_Confirm(question: question, errorMessage: errorMessage)
    }
}

/// Presents the user a dropdown list of predefined options they can pick from. To confirm their selection
///
/// To confirm their selection, a user must pick the value from the left-most, bracketed text. If the user tried to input
/// anything that is not on the list, they will be asked to reinput their selection.
///
///     let my_favorite_dessert = Util_ConsoleAsk_Option(
///         question: "Please pick out from an available desser options:"
///         options: available_dessers
///         caseInsensitive: false
///     )
///
/// - Parameters:
///   - question: the question that the user must confirm with yes/no
///   - options: the array of questions that the user can pick out from
///   - caseInsensitive: toggle the case sensitivity of the label to pick from
/// - Returns: a `Util_ConsoleAsk_Option_Type` that the user picked
func Util_ConsoleAsk_Dropdown(question: String, options: [Util_ConsoleAsk_Option_Type], caseInsensitive: Bool = true, errorMessage: String = "Invalid input!") -> Util_ConsoleAsk_Option_Type {
    print(question)
    
    // prints the list of options specified
    for option in options {
        if option.isSeparator != true {
            print("[\(option.value)] \(option.label)")
        } else {
            print("\(option.label)")
        }
    }
    
    print("please input one of the selection above: ", terminator: "")
    
    // a null-check that re-prompts the user if they haven't picked any options
    guard var input = readLine() else {
        print("Input is empty! Please fill out the question.")
        return Util_ConsoleAsk_Dropdown(question: question, options: options, errorMessage: errorMessage)
    }
    
    var selected: Util_ConsoleAsk_Option_Type? = nil
    
    // lowercase the input if the dropdown specified is case insensitive
    if caseInsensitive {
        input = input.lowercased()
    }
    
    // loop thru the options and assign the picked option from the list
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
    
    // if the option didn't exist, print the error message and re-prompt the user
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
