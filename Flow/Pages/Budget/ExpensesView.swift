//
//  ExpensesView.swift
//  Flow
//
//  Created by Darking Almas on 09.12.2025.
//

import SwiftUI

struct ExpensesView: View {
    @Binding var totalExpense: Int
    @Binding var foodExpense: Int
    @Binding var transportExpense: Int
    @Binding var communalExpense: Int
    
    @State private var editingItem: CategoryItem?
    @State private var showEditView = false
    
    enum ExpenseType {
        case food
        case transport
        case rent
    }
    
    func recalcTotal() {
        totalExpense = foodExpense + transportExpense + communalExpense
    }
    
    var foodPercentage: Double {
        guard totalExpense > 0 else { return 0 }
        return Double(foodExpense) / Double(totalExpense)
    }
    
    var transportPercentage: Double {
        guard totalExpense > 0 else { return 0 }
        return Double(transportExpense) / Double(totalExpense)
    }
    
    var communalPercentage: Double {
        guard totalExpense > 0 else { return 0 }
        return Double(communalExpense) / Double(totalExpense)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                DonutChart(segments: [
                    ChartSegment(color: Color(red: 1.0, green: 0.75, blue: 0.0), percentage: foodPercentage),
                    ChartSegment(color: Color(red: 0.47, green: 0.40, blue: 0.73), percentage: transportPercentage),
                    ChartSegment(color: Color(red: 0.54, green: 0.46, blue: 0.22), percentage: communalPercentage)
                ])
                .frame(width: 230, height: 230)
                
                Text("\(totalExpense) тг")
                    .font(.system(size: 24, weight: .semibold))
            }
            .padding(.bottom, 20)

            HStack(spacing: 30) {
                LegendItem(color: Color(red: 1.0, green: 0.75, blue: 0.0), text: "Еда")
                LegendItem(color: Color(red: 0.47, green: 0.40, blue: 0.73), text: "Транспорт")
                LegendItem(color: Color(red: 0.54, green: 0.46, blue: 0.22), text: "Комуналка")
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
                    icon: "Food",
                    color: Color(red: 1.0, green: 0.75, blue: 0.0),
                    value: "\(foodExpense) тг"
                )

                CategoryCard(
                    icon: "Transport",
                    color: Color(red: 0.47, green: 0.40, blue: 0.73),
                    value: "\(transportExpense) тг"
                )

                CategoryCard(
                    icon: "Rent",
                    color: Color(red: 0.54, green: 0.46, blue: 0.22),
                    value: "\(communalExpense) тг"
                )
            }
            .padding(.top, 10)
            .padding(.bottom, 120)
        }
    }
}
