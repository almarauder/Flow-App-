//
//  DebtsSummaryCard.swift
//  Flow
//
//  Created by Darking Almas on 17.12.2025.
//

import SwiftUI


struct DebtSummaryCard: View {
    let title: String
    let progress: Double
    let amount: Int
    let color: Color

    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        let formatted = formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
        return "\(formatted) тг"
    }

    var clampedProgress: Double {
        min(max(progress, 0), 1)
    }

    var body: some View {
        VStack(spacing: 14) {
            HStack {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))

                Spacer()

                Text(formattedAmount)
                    .font(.system(size: 22, weight: .bold))
            }
            .overlay(
                Text("\(Int(clampedProgress * 100))%")
                    .font(.system(size: 16, weight: .medium)),
                alignment: .center
            )

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(color.opacity(0.25))
                        .frame(height: 10)

                    Capsule()
                        .fill(color)
                        .frame(
                            width: geo.size.width * clampedProgress,
                            height: 10
                        )
                }
            }
            .frame(height: 10)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .stroke(color, lineWidth: 2)
                .background(
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.white)
                )
        )
        .padding(.horizontal)
    }
}
