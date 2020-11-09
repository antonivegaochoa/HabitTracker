//
//  ContentView.swift
//  HabitTracker
//
//  Created by Antonio Vega on 11/6/20.
//

import SwiftUI

struct Activity: Identifiable, Codable {
    var id = UUID()
    let title: String
    let description: String
    var streak: Int
}

class Activities: ObservableObject {
    @Published var items = [Activity]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Habits") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var habits = Activities()
    
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits.items) { item in
                    NavigationLink(destination: HabitView(habits: self.habits, habit: item)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.headline)
                                //Text(item.description)
                            }
                            
                            Spacer()
                            
                            Text("\(item.streak) days")
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddHabit = true
                }) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $showingAddHabit) {
            AddHabit(habits: habits)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
