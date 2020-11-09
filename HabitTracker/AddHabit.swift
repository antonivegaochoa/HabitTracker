//
//  AddHabit.swift
//  HabitTracker
//
//  Created by Antonio Vega on 11/6/20.
//

import SwiftUI

struct AddHabit: View {
    @ObservedObject var habits: Activities
    
    @State private var title = ""
    @State private var description = ""
    @State private var streak = ""
    
    @State private var showError = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                
                TextField("Description", text: $description)
                
                TextField("Streak", text: $streak)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Adding New Habit")
            .navigationBarItems(trailing: Button("Save") {
                if let actualStreak = Int(self.streak) {
                    let habit = Activity(title: self.title, description: self.description, streak: actualStreak)
                    self.habits.items.append(habit)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showError = true
                }
            })
        }
        .alert(isPresented: $showError, content: {
            Alert(title: Text("Error"), message: Text("\(streak) is not a valid value"), dismissButton: .default(Text("Ok")))
        })
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabit(habits: Activities())
    }
}
