//
//  AccountView.swift
//  Flow
//
//  Created by Darking Almas on 10.12.2025.
//

import SwiftUI

struct AccountsView: View {
    @Binding var totalAccount: Int
    @Binding var cashAccount: Int
    @Binding var bankAccount: Int
    
    var cashPercentage: Double {
        guard totalAccount > 0 else { return 0 }
        return Double(cashAccount) / Double(totalAccount)
    }
    
    var bankPercentage: Double {
        guard totalAccount > 0 else { return 0 }
        return Double(bankAccount) / Double(totalAccount)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                DonutChart(segments: [
                    ChartSegment(color: Color(red: 0.2, green: 0.78, blue: 0.35), percentage: cashPercentage),
                    ChartSegment(color: Color(red: 0.96, green: 0.26, blue: 0.21), percentage: bankPercentage),
                ])
                .frame(width: 230, height: 230)
                
                Text("\(totalAccount) тг")
                    .font(.system(size: 24, weight: .semibold))
            }
            .padding(.bottom, 20)

            HStack(spacing: 30) {
                LegendItem(color: Color(red: 0.2, green: 0.78, blue: 0.35), text: "Наличные")
                LegendItem(color: Color(red: 0.96, green: 0.26, blue: 0.21), text: "Kaspi Bank")
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
                    value: "\(cashAccount) тг"
                )
                
                CategoryCard(
                    icon: "KaspiBank",
                    color: Color(red: 0.96, green: 0.26, blue: 0.21),
                    value: "\(bankAccount) тг"
                )
            }
            .padding(.top, 10)
            .padding(.bottom, 120)
        }
    }
}
