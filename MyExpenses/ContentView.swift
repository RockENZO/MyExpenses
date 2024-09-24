//
//  ContentView.swift
//  MyExpenses
//
//  Created by Rock on 9/23/2024.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    @State private var showingAddExpenseView = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment:.leading,spacing: 24){
                    //Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    //Chart
                    let data = transactionListVM.accumulateTransactions()
                    if !data.isEmpty {
                        let totalExpenses = data.last?.1 ?? 0
                        
                        CardView {
                            VStack(alignment: .leading){
                                ChartLabel(totalExpenses.formatted(.currency(code: "AUD")),type:.title, format: "$%.02f")
                                LineChart()
                            }
                            .background(Color.systemBackground)
                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: Color.systemBackground,foregroundColor: ColorGradient(Color.icon.opacity(0.4),Color.icon)))
                        .frame(height: 200)
                    }
                    
                    //Transaction list
                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                //Notification Icon
                ToolbarItem{
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon)
                }
            }
            .overlay(
                Button(action: {
                    showingAddExpenseView.toggle()
                }) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
                .padding()
                .position(x: UIScreen.main.bounds.width - 50, y: UIScreen.main.bounds.height - 150)
            )
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
        .sheet(isPresented: $showingAddExpenseView) {
            AddExpenseView()
                .environmentObject(transactionListVM)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View{
        ContentView()
            .environmentObject(transactionListVM)
            .preferredColorScheme(.dark)
    }
}
