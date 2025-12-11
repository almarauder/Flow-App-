//
//  AddIncomeView.swift
//  Flow
//
//  Created by Darking Almas on 09.12.2025.
//

import SwiftUI

struct AddIncomeView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var salaryIncome: Int
    @Binding var businessIncome: Int
    @Binding var investmentIncome: Int
    @Binding var totalIncome: Int
    
    @State private var selectedDate = Date()
    @State private var amount = ""
    @State private var comment = ""
    @State private var selectedCategory: IncomeCategory?
    @State private var showDatePicker = false
    
    enum IncomeCategory: String, CaseIterable , CategoryType {
        case salary = "Зароботок"
        case business = "Бизнес"
        case investment = "Инвестиции"
        case gifts = "Подарки"
        
        var icon: String {
            switch self {
            case .salary: return "Debts"
            case .business: return "Budget"
            case .investment: return "Investment"
            case .gifts: return "Gift"
            }
        }
        
        var color: Color {
            switch self {
            case .salary: return Color(red: 1.0, green: 0.75, blue: 0.0)
            case .business: return Color(red: 0.47, green: 0.40, blue: 0.73)
            case .investment: return Color(red: 0.54, green: 0.46, blue: 0.22)
            case .gifts: return Color.orange
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("MainMobileColor")
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        Text("Добавить Доход")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Color.clear
                            .frame(width: 24, height: 24)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 30)

                    ScrollView {
                        VStack(alignment: .leading, spacing: 25) {
                            VStack(alignment: .leading, spacing: 10) {
                                DatePickerField(
                                    selectedDate: $selectedDate,
                                    showDatePicker: $showDatePicker
                                )
                                
                                AmountField(amount: $amount)
                                
                                CommentField(comment: $comment)
                            }

                            VStack(alignment: .leading, spacing: 15) {
                                Text("Выберите категорию!")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                                
                                HStack(spacing: 20) {
                                    ForEach(IncomeCategory.allCases, id: \.self) { category in
                                        CategoryButton(
                                            category: category,
                                            isSelected: selectedCategory == category
                                        ) {
                                            selectedCategory = category
                                        }
                                    }
                                }
                            }

                            Button(action: {
                                addIncome()
                            }) {
                                Text("Добавить")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(Color("MainMobileColor"))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 18)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color(red: 0.82, green: 0.93, blue: 0.98))
                                    )
                            }
                            .padding(.top, 20)
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
    }
    
    func addIncome() {
        guard let incomeAmount = Int(amount),
              incomeAmount > 0,
              let category = selectedCategory else {
            return
        }
        
        switch category {
        case .salary:
            salaryIncome += incomeAmount
        case .business:
            businessIncome += incomeAmount
        case .investment:
            investmentIncome += incomeAmount
        case .gifts:
            break
        }
        
        totalIncome = salaryIncome + businessIncome + investmentIncome
        
        dismiss()
    }
}
