//
//  DebtCard.swift
//  Flow
//
//  Created by Darking Almas on 17.12.2025.
//

import SwiftUI

struct DebtCard: View {
    let name: String
    let totalAmount: Int
    let remainingAmount: Int
    let color: Color

    var onEdit: (() -> Void)?
    var onDelete: (() -> Void)?

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            Circle()
                .fill(color)
                .frame(width: 16, height: 16)
                .padding(.top, 6)

            VStack(alignment: .leading, spacing: 10) {
                Text(name)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)

                HStack {
                    Text("Сумма долга:")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(totalAmount) тг")
                        .fontWeight(.semibold)
                }

                HStack {
                    Text("Остаток долга:")
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(remainingAmount) тг")
                        .fontWeight(.semibold)
                }
            }

            Spacer()

            Menu {
                Button("Редактировать") { onEdit?() }
                Button("Удалить", role: .destructive) { onDelete?() }
            } label: {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .foregroundColor(.black)
                    .padding(.top, 4)
            }
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
