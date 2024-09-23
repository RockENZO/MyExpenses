//
//  Extensions.swift
//  MyExpenses
//
//  Created by Rock on 9/23/2024.
//

import Foundation
import SwiftUI

extension Color {
    static let appBackground = Color("Background")
    static let appIcon = Color("Icon")
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension DateFormatter{
    static let allNumericUSA: DateFormatter = {
        print("Initializing DateFormatter")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter
    }()
}

extension String{
    func dateParsed() -> Date{
        guard let parsedDate = DateFormatter.allNumericUSA.date(from:self) else {return Date()}
        
        return parsedDate
    }
}
extension Date:Strideable{
    func formatted() -> String{
        return self.formatted(.dateTime.year().month().day())
    }
}

extension Double{
    func roundedTo2Digits() -> Double{
        return (self * 100).rounded() / 100
    }
}
