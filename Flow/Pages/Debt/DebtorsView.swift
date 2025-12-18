//
//  DebtorsView.swift
//  Flow
//
//  Created by Darking Almas on 17.12.2025.
//

import SwiftUI

struct DebtorsView: View {
    @Binding var debts: [Debt]

    var totalPersonDebt: Int {
        debts.reduce(0) { $0 + $1.totalAmount }
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                DonutChart(segments: debts.map {
                    let denom = max(totalPersonDebt, 1)
                    return ChartSegment(
                        color: $0.color,
                        percentage: Double($0.remainingAmount) / Double(denom)
                    )
                })
                .frame(width: 230, height: 230)

                Text("\(totalPersonDebt) тг")
                    .font(.system(size: 24, weight: .semibold))
            }
            .padding(.bottom, 20)

            VStack(spacing: 15) {
                ForEach(debts) { debt in
                    DebtCard(
                        name: debt.name,
                        totalAmount: debt.totalAmount,
                        remainingAmount: debt.remainingAmount,
                        color: debt.color
                    ) {
                        // Edit action
                    } onDelete: {
                        debts.removeAll { $0.id == debt.id }
                    }
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 120)
        }
    }
}

