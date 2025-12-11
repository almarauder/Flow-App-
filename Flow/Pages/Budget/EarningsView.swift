//
//  EarningsView.swift
//  Flow
//
//  Created by Darking Almas on 09.12.2025.
//

import SwiftUI

struct EarningsView: View {
    @Binding var totalIncome: Int
    @Binding var salaryIncome: Int
    @Binding var businessIncome: Int
    @Binding var investmentIncome: Int
    
    var salaryPercentage: Double {
        guard totalIncome > 0 else { return 0 }
        return Double(salaryIncome) / Double(totalIncome)
    }
    
    var businessPercentage: Double {
        guard totalIncome > 0 else { return 0 }
        return Double(businessIncome) / Double(totalIncome)
    }
    
    var investmentPercentage: Double {
        guard totalIncome > 0 else { return 0 }
        return Double(investmentIncome) / Double(totalIncome)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                DonutChart(segments: [
                    ChartSegment(color: Color(red: 0.2, green: 0.78, blue: 0.35), percentage: salaryPercentage),
                    ChartSegment(color: Color(red: 0.96, green: 0.26, blue: 0.21), percentage: businessPercentage),
                    ChartSegment(color: Color(red: 0.54, green: 0.46, blue: 0.21), percentage: investmentPercentage)
                ])
                .frame(width: 230, height: 230)
                
                Text("\(totalIncome) тг")
                    .font(.system(size: 24, weight: .semibold))
            }
            .padding(.bottom, 20)

            HStack(spacing: 30) {
                LegendItem(color: Color(red: 0.2, green: 0.78, blue: 0.35), text: "Заработок")
                LegendItem(color: Color(red: 0.96, green: 0.26, blue: 0.21), text: "Бизнес")
                LegendItem(color: Color(red: 0.54, green: 0.46, blue: 0.21), text: "Инвестиция")
            }
            .padding(.bottom, 20)

            Button {
                
            } label: {
                HStack(spacing: 5) {
                    Text("7 окт. - 7 нояб.")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color("MainMobileColor"))
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 14))
                        .foregroundColor(Color("MainMobileColor"))
                }
            }
            .padding(.bottom, 15)
            
            VStack(spacing: 15) {
                CategoryCard(
                    icon: "Debts",
                    color: Color(red: 0.2, green: 0.78, blue: 0.35),
                    value: "\(salaryIncome) тг"
                )
                
                CategoryCard(
                    icon: "Budget",
                    color: Color(red: 0.96, green: 0.26, blue: 0.21),
                    value: "\(businessIncome) тг"
                )
                CategoryCard(
                    icon: "Investment",
                    color: Color(red: 0.54, green: 0.46, blue: 0.21),
                    value: "\(investmentIncome) тг"
                )
            }
            .padding(.top, 10)
            .padding(.bottom, 120)
        }
    }
}
