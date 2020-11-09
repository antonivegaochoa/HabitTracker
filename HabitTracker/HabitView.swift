//
//  HabitView.swift
//  HabitTracker
//
//  Created by Antonio Vega on 11/9/20.
//

import SwiftUI

struct HabitView: View {
    @ObservedObject var habits: Activities
    @State var habit: Activity
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Description")
                    .font(.title)
                    .padding()
                
                Text(habit.description)
                
                Stepper(value: $habit.streak, in: 0...1000, step: 1) {
                    Text("\(habit.streak) days")
                }
                .padding()
                
                Spacer()
                
            }
            .navigationBarTitle(Text(habit.title))
        }
        .navigationBarItems(trailing: Button("Save") {
            if let i = habits.items.firstIndex(where: {$0.id == habit.id}) {
                habits.items[i].streak = habit.streak
            }
        })
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(habits: Activities(), habit: Activity(title: "NoFap", description: "Don't fap", streak: 3))
    }
}
