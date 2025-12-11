import SwiftUI

struct BudgetView: View {
    @State private var TotalExpense = 188000
    @State private var FoodExpense = 130000
    @State private var TransportExpense = 30000
    @State private var CommunalExpense = 28000
    
    @State private var TotalIncome = 160000
    @State private var SalaryIncome = 130000
    @State private var BusinessIncome = 30000
    @State private var InvestmentIncome = 28000
    
    @State private var TotalAccount = 450000
    @State private var CashAccount = 200000
    @State private var BankAccount = 250000
    
    @State private var selectedTab = 0
    @State private var selectedBottomTab: String = "Бюджет"
    @State private var showAddExpense = false
    @State private var showAddIncome = false
    
    @State private var activeSheet: AddSheetType? = nil
    
    @Binding var showSignInView: Bool
    
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
                        
                        Text("Бюджет")
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
                                    TabItem(title: "Расходы", selected: selectedTab == 0) { selectedTab = 0 }
                                    TabItem(title: "Доходы", selected: selectedTab == 1) { selectedTab = 1 }
                                    TabItem(title: "Счета", selected: selectedTab == 2) { selectedTab = 2 }
                                }
                                .padding(8)
                                .background(Color(red: 0.82, green: 0.93, blue: 0.98))
                                .cornerRadius(25)
                                .padding(.top, 10)
                                .padding(.bottom, 20)

                                Group {
                                    switch selectedTab {
                                    case 0:
                                        ExpensesView(
                                            totalExpense: $TotalExpense,
                                            foodExpense: $FoodExpense,
                                            transportExpense: $TransportExpense,
                                            communalExpense: $CommunalExpense
                                        )

                                    case 1:
                                        EarningsView(
                                            totalIncome: $TotalIncome, salaryIncome: $SalaryIncome, businessIncome: $BusinessIncome, investmentIncome: $InvestmentIncome
                                        )

                                    case 2:
                                        AccountsView(
                                            totalAccount: $TotalAccount, cashAccount: $CashAccount, bankAccount: $BankAccount
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

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            switch selectedTab {
                            case 0: activeSheet = .expense
                            case 1: activeSheet = .income
                            case 2: activeSheet = .account
                            default:
                                break
                            }
                        }
                        ) {
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
                case .expense:
                    AddExpenseView(
                        foodExpense: $FoodExpense,
                        transportExpense: $TransportExpense,
                        communalExpense: $CommunalExpense,
                        totalExpense: $TotalExpense
                    )
                case .income:
                    AddIncomeView(
                        salaryIncome: $SalaryIncome,
                        businessIncome: $BusinessIncome,
                        investmentIncome: $InvestmentIncome,
                        totalIncome: $TotalIncome
                    )
                case .account:
                    AddAccountsView(
                        cashAccount: $CashAccount,
                        bankAccount: $BankAccount,
                        totalAccount: $TotalAccount
                    )
                }
            }
        }
    }
}

struct BudgetView_Previews: PreviewProvider {
    @State static var showSignInView = false
    
    static var previews: some View {
        BudgetView(showSignInView: $showSignInView)
    }
}
