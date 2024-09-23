//
//  MyExpensesApp.swift
//  MyExpenses
//
//  Created by Rock on 9/23/2024.
//

import SwiftUI

@main
struct MyExpensesApp: App {
    
    @StateObject var transactionListVM = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
