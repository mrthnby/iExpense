//
//  AddExpenseView.swift
//  iExpense
//
//  Created by Mert Ali Hanbay on 20.08.2023.
//

import SwiftUI

struct AddExpenseView: View {

    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0

    let types: Array<String> = ["Personal", "Business"]

    var body: some View {
        NavigationView {
            VStack{
                Form {
                    TextField("Name", text: $name)
                    
                    Picker("Type", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad)
                    
                    Section {
                        Button {
                            let item = ExpenseItem(name: name, type: type, amount: amount)
                            expenses.items.append(item)
                            dismiss()
                        } label: {
                            Text("Save")
                        }
                            .frame(maxWidth:.infinity)
                    }

                }
                
            }.navigationTitle("Add new expense")
            
        }
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView(expenses: Expenses())
    }
}
