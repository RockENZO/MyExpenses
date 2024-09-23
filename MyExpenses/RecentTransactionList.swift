//
//  RecentTransactionList.swift
//  MyExpenses
//
//  Created by Rock on 9/23/2024.
//

import SwiftUI

struct RecentTransactionList: View {
    @EnvironmentObject var transactionListVM : TransactionListViewModel
    var body: some View {
        VStack {
            HStack{
                //Header title
                Text("Recent Transactions")
                    .bold()
                
                Spacer()
                
                //Header link
                NavigationLink{
                    
                } label:{
                    HStack(spacing:4){
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }
            }
            .padding(.top)
            
            //Transaction List
            ForEach(Array(transactionListVM.transactions.prefix(5).enumerated()),id:\.element){
                index, transaction in
                TransactionRow(transaction: transaction)
                Divider()
                    .opacity(index == 4 ? 0: 1)
            }
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color:Color.primary.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

struct RecentTransactionList_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View{
        Group {
            RecentTransactionList()
            RecentTransactionList()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
}
