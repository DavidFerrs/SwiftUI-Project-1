//
//  TextFieldView.swift
//  MyApp
//
//  Created by David Ferreira on 26/10/24.
//

import SwiftUI

struct TextFieldView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocus: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var tipValue: Double {
        let tipSelection = Double(tipPercentage)
        
        return checkAmount / 100 * tipSelection
    }
    
    var isTipZero: Bool {
        if tipPercentage == 0 {
            return true
        } else {
            return false
        }
    }
        
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        
        let tipValue = tipValue
        let grandTotal = checkAmount + tipValue
        let amountPerPerson =  grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format:  .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocus)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Total amount plus tip") {
                    Text("\(checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")) + \(tipValue, format: .currency(code: Locale.current.currency?.identifier ?? "USD")) = \(checkAmount + tipValue, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                        .foregroundStyle(isTipZero ? .red : .primary)
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if amountIsFocus {
                    Button("Done"){
                        amountIsFocus = false
                    }
                }
            }
        }
    }
}

#Preview {
    TextFieldView()
}
