import Foundation

struct SummaryCardModel {
    let amount: Double
    let currency: AppCurrency

    var amountString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.maximumFractionDigits = 0
        let amountFormatted = formatter.string(from: NSNumber(value: amount)) ?? "0"
        return "\(amountFormatted) \(currency.suffix)"
    }
}
