//
//  DebtView.swift
//  Flow
//
//  Created by Darking Almas on 17.12.2025.
//

import SwiftUI

struct DebtsPageView: View {
    var totalDebts: Int {
        debts.reduce(0) { $0 + $1.totalAmount}
    }
    
    var totalDebtors: Int {
        debtors.reduce(0) { $0 + $1.remainingAmount}
    }
    
    @State private var debts: [Debt] = [ Debt(name: "Манси", totalAmount: 100_000, remainingAmount: 100_000, color: .red), Debt(name: "Вася", totalAmount: 30_000, remainingAmount: 30_000, color: .orange)
    ]
    
    @State private var debtors: [Debt] = [ Debt(name: "Сайка" , totalAmount: 50_000 , remainingAmount: 50_000 , color: .red)
    ]
    
    @State private var selectedTab = 0
    @Binding var selectedBottomTab: String
    
    @State private var activeSheet: DebtSheetType? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("MainMobileColor")
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    ZStack {
                        HStack {
                            Image("MobileIcon")
                                .resizable()
                                .renderingMode(.template)
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        
                        Text("Долги")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .padding(.bottom, 20)


                    ZStack {
                        Color.white
                            .cornerRadius(35, corners: [.topLeft, .topRight])
                            .ignoresSafeArea(edges: .bottom)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 0) {
                                HStack(spacing: 0) {
                                    TabItem(title: "Все", selected: selectedTab == 0) { selectedTab = 0 }
                                    TabItem(title: "Долги", selected: selectedTab == 1) { selectedTab = 1 }
                                    TabItem(title: "Должники", selected: selectedTab == 2) { selectedTab = 2 }
                                }
                                .padding(8)
                                .background(Color(red: 0.82, green: 0.93, blue: 0.98))
                                .cornerRadius(25)
                                .padding(.top, 10)
                                .padding(.bottom, 20)

                                Group {
                                    switch selectedTab {
                                    case 0:
                                        GeneralDebtView(
                                            Debts: .constant(totalDebts),
                                            Debtors: .constant(totalDebtors)
                                        )

                                    case 1:
                                        DebtView(
                                            debts: $debts
                                        )

                                    case 2:
                                        DebtorsView(
                                            debts: $debtors
                                        )
                                    default:
                                        EmptyView()
                                    }
                                }
                                .padding(.bottom, 20)
                            }
                        }
                    }
                }

                if selectedTab != 0 {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                switch selectedTab {
                                case 1:
                                    activeSheet = .debts
                                case 2:
                                    activeSheet = .debtors
                                default:
                                    break
                                }
                            } label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 60, height: 60)
                                    .background(Color("MainMobileColor"))
                                    .clipShape(Circle())
                            }
                            .padding(.bottom, 110)
                            .padding(.trailing, 30)
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    HStack(spacing: 0) {
                        BottomTab(icon: "Budget", label: "Бюджет", isSelected: selectedBottomTab == "Бюджет") {
                            selectedBottomTab = "Бюджет"
                        }
                        BottomTab(icon: "Debts", label: "Долги", isSelected: selectedBottomTab == "Долги") {
                            selectedBottomTab = "Долги"
                        }
                        BottomTab(icon: "Investment", label: "Инвестиции", isSelected: selectedBottomTab == "Инвестиции") {
                            selectedBottomTab = "Инвестиции"
                        }
                        BottomTab(icon: "Profile", label: "Профиль", isSelected: selectedBottomTab == "Профиль") {
                            selectedBottomTab = "Профиль"
                        }
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 35)
                            .fill(Color(red: 0.82, green: 0.93, blue: 0.98))
                    )
                    .padding(.horizontal, 30)
                }
            }
            .sheet(item: $activeSheet) { sheet in
                switch sheet {
                case .debts:
                    AddDebtsView(
                        debts: $debts
                    )
                case .debtors:
                    AddDebtorsView(
                        debts: $debtors)
                }
            }
        }
    }
}

struct DebtPageView_Previews: PreviewProvider {
    @State static var selectedTab = "Долги"
    
    static var previews: some View {
        DebtsPageView(selectedBottomTab: $selectedTab)
    }
}
