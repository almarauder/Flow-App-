//
//  summaryCard.swift
//  Flow
//
//  Created by Adilet Toktarbay on 12.12.2025.
//


import SwiftUI

struct SummaryCard: View {
    let title: String
    let percent: Double
    let amount: Double
    let progressBorderColor: Color
    let currency: AppCurrency // Currency enum должен быть доступен
    
    var percentString: String {
        String(format: "%.0f%%", percent * 100)
    }
    
    var amountString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.maximumFractionDigits = 0
        let amountFormatted = formatter.string(from: NSNumber(value: amount)) ?? "0"
        return "\(amountFormatted) \(currency.suffix)"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                Spacer()
                Text(percentString)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
            }
            Text(amountString)
                .font(.system(size: 14))
                .foregroundColor(.black)
            
            ProgressBar(progress: percent, borderColor: progressBorderColor)
                .frame(height: 10)
        }
        .padding(16)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(progressBorderColor, lineWidth: 2)
        )
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

struct ProgressBar: View {
    let progress: Double
    let borderColor: Color
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(borderColor, lineWidth: 2)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.white)
                    )
                RoundedRectangle(cornerRadius: 5)
                    .fill(borderColor.opacity(0.8))
                    .frame(width: max(CGFloat(progress) * geo.size.width, 0))
            }
        }
    }
}

