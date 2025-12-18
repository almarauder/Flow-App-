//
//  GeneralDebtView.swift
//  Flow
//
//  Created by Darking Almas on 17.12.2025.
//

import SwiftUI

struct GeneralDebtView: View {
    @Binding var Debts: Int
    @Binding var Debtors: Int

    var totalDebts: Int {
        Debts + Debtors
    }
    
    var debtsPercentage: Double {
        guard totalDebts > 0 else { return 0 }
        return Double(Debts) / Double(totalDebts)
    }
    
    var debtorsPercentage: Double {
        guard totalDebts > 0 else { return 0 }
        return Double(Debtors) / Double(totalDebts)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                DonutChart(segments: [
                    ChartSegment(color: Color(.red), percentage: debtsPercentage),
                    ChartSegment(color: Color(.orange), percentage: debtorsPercentage),
                ])
                .frame(width: 230, height: 230)
                
                Text("\(totalDebts) тг")
                    .font(.system(size: 24, weight: .semibold))
            }
            .padding(.bottom, 20)

            HStack(spacing: 30) {
                LegendItem(color: Color(.red), text: "Долги")
                LegendItem(color: Color(.orange), text: "Должники")
            }
            .padding(.bottom, 20)
            
            VStack(spacing: 15) {
                DebtSummaryCard(
                    title: "Долги",
                    progress: debtsPercentage,
                    amount: Debts,
                    color: .red
                )
                DebtSummaryCard(
                    title: "Должники",
                    progress: debtorsPercentage,
                    amount: Debtors,
                    color: .orange
                )
            }
            .padding(.top, 10)
            .padding(.bottom, 120)
        }
    }
}
