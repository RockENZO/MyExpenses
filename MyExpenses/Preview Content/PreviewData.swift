//
//  PreviewData.swift
//  MyExpenses
//
//  Created by Rock on 9/23/2024.
//

import Foundation

var transactionPreviewData = Transaction(id: 1, date:"01/24/2022", institution:"Bank of America",account: "Visa Rock", merchant: "Apple",amount:1234,type:"Debit", categoryId:801,category:"Software", isPending: false,isTransfer: false, isExpense: true, isEdited: false  )

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
