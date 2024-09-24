//
//  AddExpenseView.swift
//  MyExpenses
//
//  Created by Rock on 9/24/2024.
//

//
//  AddExpenseView.swift
//  MyExpenses
//
//  Created by Rock on 9/24/2024.
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    
    @State private var merchant: String = ""
    @State private var amount: String = ""
    @State private var category: Category = Category.categories.first!
    @State private var date: Date = Date()
    @State private var type: TransactionType = .debit
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Expense Details")) {
                    TextField("Merchant", text: $merchant)
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                    Picker("Category", selection: $category) {
                        ForEach(Category.categories) { category in
                            Text(category.name).tag(category)
                        }
                    }
                    Picker("Type", selection: $type) {
                        Text("Debit").tag(TransactionType.debit)
                        Text("Credit").tag(TransactionType.credit)
                    }
                }
                
                Button(action: saveExpense) {
                    Text("Save Expense")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.4))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("New Expense?💸")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func saveExpense() {
        guard let amount = Double(amount) else { return }
        
        let newTransaction = Transaction(
            id: transactionListVM.transactions.count + 1,
            date: DateFormatter.allNumericUSA.string(from: date),
            institution: "User",
            account: "User Account",
            merchant: merchant,
            amount: amount,
            type: type.rawValue,
            categoryId: category.id,
            category: category.name,
            isPending: false,
            isTransfer: false,
            isExpense: type == .debit,
            isEdited: false
        )
        
        transactionListVM.addTransaction(newTransaction)
        transactionListVM.saveTransactions() // Save transactions to UserDefaults
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
            .environmentObject(TransactionListViewModel())
            .preferredColorScheme(.dark)
    }
}
