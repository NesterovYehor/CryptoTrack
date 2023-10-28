

import Foundation


extension Double{
    
    // Converts a Double into a Currency with 2 decimal places
    /// ```
    ///Convert 1234.56 to $1,234.56
    // ```
    
    
    private var currencyFormater2: NumberFormatter{
        let formator = NumberFormatter()
        formator.usesGroupingSeparator = true
        formator.numberStyle = .currency
        formator.minimumFractionDigits = 2
        formator.maximumFractionDigits = 2
        return formator
        
    }
    
    // Converts a Double into a Currency as a String with 2 decimal places
    /// ```
    ///Convert 1234.56 to "$1,234.56"
    // ```
    func asCurrencyWith2Decimals() -> String{
        let number = NSNumber(value: self)
        return currencyFormater2.string(from: number) ?? "$0.00"
    }

    
    // Converts a Double into a Currency with 2-6 decimal places
    /// ```
    ///Convert 1234.56 to $1,234.56
    ///Convert 12.3456 to $12.3456
    ///Convert 0.123456 to $0.123456
    // ```
    
    
    private var currencyFormater6: NumberFormatter{
        let formator = NumberFormatter()
        formator.usesGroupingSeparator = true
        formator.numberStyle = .currency
        formator.minimumFractionDigits = 2
        formator.maximumFractionDigits = 6
        return formator
        
    }
    
    // Converts a Double into a Currency as a String with 2-6 decimal places
    /// ```
    ///Convert 1234.56 to "$1,234.56"
    ///Convert 12.3456 to "$12.3456"
    ///Convert 0.123456 to "$0.123456"
    // ```
    func asCurrencyWith6Decimals() -> String{
        let number = NSNumber(value: self)
        return currencyFormater6.string(from: number) ?? "$0.00"
    }
    // Converts a Double into string representation
    /// ```
    ///Convert 1234.56 to "$1.23"
    // ```
    func asNumberString() -> String{
        return String(format: "%.2f", self)
    }
    // Converts a Double into string representation with persent symbol
    /// ```
    ///Convert 1234.56 to "$1.23%"
    // ```
    func asPresentString() -> String{
        return asNumberString() + "%"
    }
    
    func formatedWithAbbreviations() -> String{
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""
        
        switch num{
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()
        default:
            return "\(sign)\(self)"
        }
    }
    
}



