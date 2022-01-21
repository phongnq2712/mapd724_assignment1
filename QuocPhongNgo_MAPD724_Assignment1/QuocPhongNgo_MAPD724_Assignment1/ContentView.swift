/**
 * MAPD724 - Assignment 1
 * File Name:    ContentView.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   January 20th, 2022
 */

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    private var symbols = ["apple", "cherry", "lemon", "orange", "strawberry"]
    @State private var numbers = [0, 1, 2]
    @State private var credits = 1000
    @State private var betAmount: String = ""
    @State private var isDisabledSpinButton = false
    private var jackPot = 5000
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(red: 197/255,
                    green: 231/255, blue: 255/255))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                HStack {
                    Text("Slot Machine")
                        .bold()
                        .foregroundColor(Color(red: 137/255, green: 80/255, blue: 23/255))
                }.scaleEffect(2)
                HStack {
                    // logo
                    Image("slot-machine").resizable()
                        .frame(width: 95.0, height: 95.0)
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                        .padding(.all, 10)
                }.padding(.bottom, 30)
                // Jackpot money
                Text("Jackpot: " + String(jackPot))
                    .bold()
                    .foregroundColor(Color(red: 137/255, green: 80/255, blue: 23/255))
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(20)
                // Credits
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
                    let binding = Binding<String>(get: {
                                self.betAmount
                            }, set: {
                                self.betAmount = $0
                                // enable Spin button
                                if(self.isDisabledSpinButton) {
                                    self.isDisabledSpinButton = false
                                }
                            })
                    TextField("Enter Bet", text: binding)
                        .foregroundColor(.red)
                        .padding(.all, 10)
                        .frame(width: 100, height: 35, alignment: .trailing)
                }
                
                // Cards
                HStack {
                    Spacer()
                    Image(symbols[numbers[0]]).resizable()
                        .frame(width: 95.0, height: 95.0)
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(20)
                        .padding(.all, 10)
                    
                    Image(symbols[numbers[1]]).resizable()
                        .frame(width: 95.0, height: 95.0)
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(20)
                        .padding(.all, 10)
                    
                    Image(symbols[numbers[2]]).resizable()
                        .frame(width: 95.0, height: 95.0)
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(20)
                        .padding(.all, 10)
                    Spacer()
                }
                Spacer()
                // Spin Button
                Button(action: spinPressedButton) {
                    Text("Spin")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.all, 20)
                        .background(self.isDisabledSpinButton == true ? Color.gray : Color.blue)
                        .cornerRadius(20)
                }.padding(.bottom, 30).disabled(self.isDisabledSpinButton)
                
                HStack {
                    // Reset Button
                    Button(action: spinPressedButton) {
                        Text("Reset")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.all, 15)
                            .background(.orange)
                            .cornerRadius(20)
                    }.padding(.bottom, 50)
                    // Quit Button
                    Button(action: spinPressedButton) {
                        Text("Quit")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.all, 15)
                            .background(.orange)
                            .cornerRadius(20)
                    }.padding(.bottom, 50)
                }
            }
        }
    }
    
    /**
     * Event for pressing Spin button
     */
    private func spinPressedButton() {
        // Check whether the user has enough money or not
        let playerMoney = (betAmount as NSString).integerValue
        if(playerMoney > self.credits) {
            // grey out the Spin button
            self.isDisabledSpinButton = true
            
            return
        } else {
            self.isDisabledSpinButton = false
        }
        self.numbers[0] = Int.random(in: 0...self.symbols.count - 1)
        self.numbers[1] = Int.random(in: 0...self.symbols.count - 1)
        self.numbers[2] = Int.random(in: 0...self.symbols.count - 1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
