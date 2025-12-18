//
//  InvestmentsViewModel.swift
//  Flow
//
//  Created by Adilet Toktarbay on 12.12.2025.
//

import Foundation
import Combine

class InvestmentsViewModel: ObservableObject {
    
    // MARK: - Published Data
    
    @Published var deposits: [DepositItem] = []
    @Published var stocks: [StockItem] = []
    @Published var selectedCurrency: AppCurrency = .kzt
    
    // MARK: - Calculated Values
    
    var depositValue: Double { deposits.map { $0.totalAmount }.reduce(0, +) }
    var marketValue: Double { stocks.map { $0.totalValue }.reduce(0, +) }
    var totalValue: Double { depositValue + marketValue }
    
    var depositPercent: Double { depositValue / max(totalValue, 1) }
    var marketPercent: Double { marketValue / max(totalValue, 1) }
    
    // MARK: - Initializer (для предпросмотра)
    
    init() {
        
    }
    
    // MARK: - Functions
    
    func formattedAmount(_ amount: Double) -> String {
        let value = amount * selectedCurrency.rate
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.maximumFractionDigits = 0
        let text = formatter.string(from: NSNumber(value: value)) ?? "0"
        return "\(text) \(selectedCurrency.suffix)"
    }
    
    // Formats a total amount that is stored in USD to the selected currency
    func formattedAmountFromUSD(_ amountUSD: Double) -> String {
        let value = amountUSD * selectedCurrency.usdMultiplier
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.maximumFractionDigits = 0
        let text = formatter.string(from: NSNumber(value: value)) ?? "0"
        return "\(text) \(selectedCurrency.suffix)"
    }

    // Formats a per-unit price that is stored in USD to the selected currency (2 fraction digits)
    func formattedPricePerUnitFromUSD(_ priceUSD: Double) -> String {
        let value = priceUSD * selectedCurrency.usdMultiplier
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.maximumFractionDigits = 2
        let text = formatter.string(from: NSNumber(value: value)) ?? "0"
        return "\(text) \(selectedCurrency.suffix)"
    }
    
    func formattedPricePerUnit(_ priceInUSD: Double) -> String {
        let value = priceInUSD * selectedCurrency.rate
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.maximumFractionDigits = 2
        let text = formatter.string(from: NSNumber(value: value)) ?? "0"
        return "\(text) \(selectedCurrency.suffix)"
    }
    
    // Display values in the selected currency space
    var depositDisplayValue: Double { depositValue * selectedCurrency.rate }
    var marketDisplayValue: Double { marketValue * selectedCurrency.usdMultiplier }
    var totalDisplayValue: Double { depositDisplayValue + marketDisplayValue }

    func formattedDisplayValue(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.maximumFractionDigits = 0
        let text = formatter.string(from: NSNumber(value: value)) ?? "0"
        return "\(text) \(selectedCurrency.suffix)"
    }
    
    func addNewDeposit(item: DepositItem) {
        deposits.append(item)
    }
    
    func editDeposit(item: DepositItem) {
        if let index = deposits.firstIndex(where: { $0.id == item.id }) {
            deposits[index] = item
        }
    }
    
    func topUpDeposit(item: DepositItem, amount: Double) {
        if let index = deposits.firstIndex(where: { $0.id == item.id }) {
            deposits[index].totalAmount += max(0, amount)
        }
    }
    
    func deleteDeposit(item: DepositItem) {
        deposits.removeAll { $0.id == item.id }
    }
    
    func addStock(_ item: StockItem) { stocks.append(item) }
    func editStock(_ item: StockItem) {
        if let idx = stocks.firstIndex(where: { $0.id == item.id }) { stocks[idx] = item }
    }
    func deleteStock(_ item: StockItem) { stocks.removeAll { $0.id == item.id } }
}

