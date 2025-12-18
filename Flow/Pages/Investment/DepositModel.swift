//
//  DepositModel.swift
//  Flow
//
//  Created by Adilet Toktarbay on 12.12.2025.
//


import Foundation

struct DepositItem: Identifiable { // Убрал Equatable, так как он не обязателен
    var id = UUID() // Теперь id может быть изменен, но лучше использовать специальную функцию
    
    // Обязательные поля
    var name: String
    var totalAmount: Double
    var investmentAmount: Double
    var interestRate: Double
    var startDate: Date
    
    // Необязательное поле
    var endDate: Date?
    
    // Срок (в месяцах) - храним как String для формы
    var termMonths: String = ""
}
