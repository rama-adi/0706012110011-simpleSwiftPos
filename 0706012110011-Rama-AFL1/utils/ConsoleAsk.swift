//
//  ConsoleAskUtil.swift
//  0706012110011-Rama-AFL1
//
//  Created by Rama Adi Nugraha on 01/03/23.
//

import Foundation

struct ConsoleComponent {
    
    

    /// A `struct` to define the base configuration.
    ///
    /// Each input type will have these base configuration applied to them.
    /// You can modify each by changing the `baseConfiguration` params on each input type,
    /// and passing your own ``BaseConfiguration`` struct.
    struct BaseConfiguration {
        var emptyInputMessage: String = "The input is empty! please try again"
        var errorMessage: String = "The input is invalid! Please try again"
    }
    
    /// A `struct` for modifying ``ConfirmationInput(question:baseConfig:config:)`` configration
    ///
    /// Each types of input will have their own struct to define their configuration.
    /// you can override their default configuration by passing your own modified configuration struct
    struct ConfirmationInputConfiguration {
        var invalidConfirmationInputMessage: String = "You can only input y/N as the answer!"
    }
    
    
    /// Presents the user a yes/no confirmation message. the user can type in `yes/no` or `y/n` (case insesitive) to confirm their selection
    ///
    /// To present a user with a yes/no question. if the user tries to input anything except a yes/no question, they will be asked to re-input their answer.
    ///
    ///     let like_dessert = ConfirmationInput(
    ///         question: "Do you like dessert?"
    ///     )
    ///
    /// - Parameters:
    ///   - question: the question that the user must confirm with yes/no
    ///   - baseConfig: ``BaseConfiguration`` struct
    ///   - config: a ``ConfirmationInputConfiguration`` struct where you can configure the settings for the confirmation input
    /// - Returns: a boolean that confirms their selection (true - yes, and false - no)
    func ConfirmationInput(
        question: String,
        baseConfig: BaseConfiguration = BaseConfiguration(),
        config: ConfirmationInputConfiguration = ConfirmationInputConfiguration()
    ) -> Bool {
        print("\(question) [y/N]: ", terminator: "")
        
        guard let input = readLine() else {
            print(baseConfig.emptyInputMessage)
            return ConfirmationInput(question: question, baseConfig: baseConfig, config: config)
        }
        
        switch input {
        case let x where ["y", "yes"].contains(x.lowercased()):
            return true
            
        case let x where ["n", "no"].contains(x.lowercased()):
            return false
            
        default:
            print(config.invalidConfirmationInputMessage)
            return ConfirmationInput(question: question, baseConfig: baseConfig, config: config)
        }
    }
    
    /// A `struct` for the options that can be passed to ``DropdownInput(question:options:baseConfig:config:)``
    ///
    ///
    ///     let available_desserts = [
    ///         DropdownOption(value: "1", label: "Potato donut")
    ///         DropdownOption(value: "2", label: "Ube Donut")
    ///
    ///         // add a separator
    ///         DropdownOption(value: "", label: "-", isSeparator: true)
    ///
    ///         // continue
    ///         DropdownOption(value: "3", label: "Croffle")
    ///     ]
    struct DropdownOption {
        var value: String
        var label: String
        var isSeparator: Bool
    }
    
    /// A `struct` for modifying ``DropdownInput(question:options:baseConfig:config:)`` configration
    ///
    /// Each types of input will have their own struct to define their configuration.
    /// you can override their default configuration by passing your own modified configuration struct
    struct DropdownInputConfiguration {
        var caseInsensitive: Bool = true
        
        var inputSelectionAboveMessage: String = "please input one of the selection above: "
        
        var displayFormat: (String,String) -> String = { value, label in
            return "[\(value)] \(label)"
        }
        
        var separatorDisplayFormat: (_ label:String) -> String = { label in
            return "\(label)"
        }
        
    }
    
    
    /// Presents the user a dropdown list of predefined options they can pick from.
    ///
    /// To confirm their selection, a user must pick the value from the value (by default from the left-most, bracketed text.)
    /// If the user tried to input anything that is not on the list, they will be asked to reinput their selection.
    ///
    ///     let my_favorite_dessert = DropdownInput(
    ///         question: "Please pick out from an available desser options:"
    ///     )
    ///
    /// - Parameters:
    ///   - question: the question that the user must confirm with yes/no
    ///   - options: the array of questions that the user can pick out from
    ///   - baseConfig: ``BaseConfiguration`` struct
    ///   - config: a ``DropdownInputConfiguration`` struct where you can configure the settings for the dropdown
    /// - Returns: a ``DropdownOption`` that the user picked
    func DropdownInput(
        question: String,
        options: [DropdownOption],
        baseConfig: BaseConfiguration = BaseConfiguration(errorMessage: "The option doesn't exist! try again."),
        config: DropdownInputConfiguration = DropdownInputConfiguration()
    ) -> DropdownOption {
        print(question)
        
        // prints the list of options specified
        for option in options {
            if option.isSeparator != true {
                print(config.displayFormat(option.value, option.label))
            } else {
                print(config.separatorDisplayFormat(option.label))
            }
        }
        
        // print the selection message
        print(config.inputSelectionAboveMessage, terminator: "")
        
        // a null-check that re-prompts the user if they haven't picked any options
        guard var input = readLine() else {
            print(baseConfig.emptyInputMessage)
            
            return DropdownInput(
                question: question,
                options: options,
                baseConfig: baseConfig,
                config: config
            )
        }
        
        // holder for the selected option
        var selected: DropdownOption? = nil
        
        // lowercase the input if the dropdown specified is case insensitive
        if config.caseInsensitive {
            input = input.lowercased()
        }
        
        // loop thru the options and assign the picked option from the list
        for option in options {
            var value = ""
            
            if config.caseInsensitive {
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
            print(baseConfig.errorMessage)
            return DropdownInput(
                question: question,
                options: options,
                baseConfig: baseConfig,
                config: config
            )
        }
        
        return selected!
    }
    
    
    /// A `struct` for modifying ``IntegerInput(question:config:baseConfig:)`` configration
    ///
    /// Each types of input will have their own struct to define their configuration.
    /// you can override their default configuration by passing your own modified configuration struct
    struct IntegerInputConfiguration {
        var cancelable: Bool = false
        var cancelableMessage: String = "to cancel, type !CANCEL"
    }
    
    
    /// Ask the user to input a numeric value
    ///
    /// A basic usage for the integer input
    ///     let answer_to_life = IntegerInput(
    ///         question: "What's the meaning of life? answer:"
    ///     )
    ///
    /// An ``IntegerInput(question:config:baseConfig:)`` can also be marked as `cancelable`, if you want to know if the user canceled the input.
    ///
    /// - Parameters:
    ///   - question: the question that the user must confirm with yes/no
    ///   - baseConfig: ``BaseConfiguration`` struct
    ///   - config: a ``IntegerInputConfiguration`` struct where you can configure the input
    /// - Returns: a tuple (`canceled` and `value`)
    func IntegerInput(
        question: String,
        config: IntegerInputConfiguration = IntegerInputConfiguration(),
        baseConfig: BaseConfiguration = BaseConfiguration()
    ) -> (canceled: Bool, value: Int) {
        
        // tells the user if they can cancel
        if config.cancelable {
            print(config.cancelableMessage)
        }
        
        print("\(question) ", terminator: "")
        
        
        
        guard let input = readLine() else {
            print(baseConfig.emptyInputMessage)
            return IntegerInput(
                question: question,
                config: config,
                baseConfig: baseConfig
            )
        }
        
        if config.cancelable {
            if input == "!CANCEL" {
                return (true, 0)
            }
        }
        
        guard let integer = Int(input) else {
            print(baseConfig.errorMessage)
            return IntegerInput(
                question: question,
                config: config,
                baseConfig: baseConfig
            )
        }
        
        
        return (false, integer)
    }

}
