//
//  ContentView.swift
//  iExpense
//
//  Created by Mert Ali Hanbay on 9.08.2023.
//

import SwiftUI

struct ContentView: View {

    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name).font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }.onDelete(perform: removeItem)
            }.navigationBarTitleDisplayMode(.inline)
                .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("iExpense").font(.title.bold()).accessibilityAddTraits(.isHeader).padding(.top)
                }

                ToolbarItem {
                    Button {
                        showingAddExpense = true
                    } label: {
                        Image(systemName: "plus").padding(.top).foregroundColor(.black)
                    }
                }
            }
        }.sheet(isPresented: $showingAddExpense) {
            AddExpenseView(expenses: expenses)
        }
    }

    func removeItem(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
