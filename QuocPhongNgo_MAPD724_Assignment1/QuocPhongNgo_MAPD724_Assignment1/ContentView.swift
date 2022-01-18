/**
 * MAPD724 - Assignment 1
 * File Name:    ContentView.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   January 18th, 2022
 */

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    private var symbols = ["apple", "cherry", "lemon"]
    @State private var numbers = [0, 1, 2]
    @State private var credits = 1000
    @State private var betAmount: String = ""
    private var jackPot = 5000
    var body: some View {
        ZStack {
            // Background
//            Rectangle()
//                .foregroundColor(Color(red: 255/255,
//                    green: 190/255, blue: 26/255))
//                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .foregroundColor(Color(red: 255/255,
                    green: 250/255, blue: 171/255))
//                .rotationEffect(Angle(degrees: 135))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                HStack {
                    Text("Slot Machine")
                        .bold()
                        .foregroundColor(Color(red: 0/255, green: 106/255, blue: 98/255))
                }.scaleEffect(2)
                HStack {
                    Image("slot-machine").resizable()
                        .frame(width: 95.0, height: 95.0)
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                        .padding(.all, 10)
                }
                // Jackpot
                Text("Jackpot: " + String(jackPot))
                    .bold()
                    .foregroundColor(.blue)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(20)
                // Credits counter
                Text("Player Money: " + String(credits))
                    .foregroundColor(.black)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(20)
                HStack {
                    Text("Bet Amount: ")
                        .foregroundColor(.black)
                        .padding(.all, 10)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                    TextField("Enter Bet", text: $betAmount)
                        .foregroundColor(.red)
                        .padding(.all, 10)
                        .frame(width: 100, height: 35, alignment: .trailing)
                }
                
                //Spacer()
                // Cards
                HStack {
                    Spacer()
                    Image("apple").resizable()
                        .frame(width: 95.0, height: 95.0)
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                        .padding(.all, 10)
                    
                    Image("cherry").resizable()
                        .frame(width: 95.0, height: 95.0)
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                        .padding(.all, 10)
                    
                    Image("lemon").resizable()
                        .frame(width: 95.0, height: 95.0)
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                        .padding(.all, 10)
                    Spacer()
                }
                Spacer()
                // Button
                Button(action: {
                    self.credits += 1
                }) {
                    Text("Spin")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.all, 15)
                        .background(.blue)
                        .cornerRadius(20)
                }
                Spacer()
            }
        }
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
