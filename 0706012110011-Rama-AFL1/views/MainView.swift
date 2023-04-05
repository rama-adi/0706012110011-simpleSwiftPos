
import Foundation

/// class to show the main screen
class MainView: ConsoleView, ConsoleViewable {
    func view() -> Void {
        clearScreen()
        print("Welcome to UC Walk Cafeteria 👨🏼‍🍳👨🏼‍🍳")
        
        // prepare the options that the user can pick out from
        var options = Consts.shops.map({ shop in
            return components.dropdownOption(value: String(shop.ID), label: shop.name)
        })
        
        // add extra options to the dropdown
        options += [
            components.dropdownOption(value: "", label: "-", isSeparator: true),
            components.dropdownOption(value: "S", label: "hopping cart"),
            components.dropdownOption(value: "Q", label: "uit")
        ]
        
        let select = components.DropdownInput(
            question: "Please choose cafeteria:",
            options: options,
            config: ConsoleComponent.DropdownInputConfiguration(caseInsensitive: true)
        )
        
        
        switch select.value {
        case "S":
            clearScreen()
            CartView().view()
        case "Q":
            exit(0)
        default:
            clearScreen()
            OrderView(
                selectedShop: Consts.shops[ Int(select.value)! - 1 ]
            ).view()
        }
    }
}
