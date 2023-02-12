//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Danis Harmandic on 25. 1. 2023..
//

import SwiftUI

struct ContentView: View {
    let possibleMoves = ["✌️", "🖐️", "✊"]
    
    @State private var appChoice = Int.random(in: 0 ..< 3)
    @State private var playerShouldWin = Bool.random()
    @State private var playerScore = 0
    @State private var playCount = 1
    @State private var gameOver = false
    
    var winOrLoseText: String {
        if playerShouldWin {
            return "WIN"
        } else {
            return "LOSE"
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color(red: 0.05, green: 0.1, blue: 0.7)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 50) {
                VStack {
                    Text("Round \(playCount) of 10")
                        .foregroundColor(.white)
                }
                .padding(.top, 50)
                
                VStack {
                    Text("Rock, paper, scissors")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.bottom, 50)
                    
                    Text("\(possibleMoves[appChoice])")
                        .font(.system(size: 70))
                    
                    HStack {
                        Text("\(winOrLoseText)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(playerShouldWin ? Color.green : Color.red)
                        Text("this game!")
                            .font(.title)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    
                    VStack(spacing: 5) {
                        HStack(spacing: 60) {
                            ForEach(0..<3) { item in
                                Button(action: {
                                    self.playerChoice(item)
                                }) {
                                    if item == 0 {
                                        Text("✌️")
                                            .font(.system(size: 70))
                                    } else if item == 1 {
                                        Text("🖐️")
                                            .font(.system(size: 70))
                                    } else if item == 2 {
                                        Text("✊")
                                            .font(.system(size: 70))
                                    }
                                }
                            }
                        }
                        VStack {
                            Spacer()
                            Text("Score: \(playerScore)")
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, 50)
                    }
                }
            }
            .alert(isPresented: $gameOver) {
                Alert(title: Text("Game over!"), message: Text("Your final score was \(playerScore)/10"), dismissButton: .default(Text("Play again")) {
                    self.restartGame()
                })
            }
        }
    }
    
    func playerChoice(_ item: Int) {
        let choices = ["🖐️", "✌️", "✊"]
        let appChoice = choices.randomElement()!
        print("App chose: \(appChoice)")

        switch (choices[item], appChoice) {
            case ("🖐️", "✊"):
                print("You win! 🖐️ beats ✊")
                playerScore += 1
            case ("✌️", "🖐️"):
                print("You win! ✌️ beats 🖐️")
                playerScore += 1
            case ("✊", "✌️"):
                print("You win! ✊ beats ✌️")
                playerScore += 1
            case (let playerChoice, let appChoice) where playerChoice == appChoice:
                print("It's a draw.")
            default:
                print("You lose.")
        }
        print("Score: \(playerScore)")
        continueGame()
    }

        
        func continueGame() {
            if playCount == 10 {
                gameOver = true
            } else {
                playCount += 1
                appChoice = Int.random(in: 0..<3)
                playerShouldWin = Bool.random()
            }
        }
        
        func restartGame() {
            playCount = 1
            appChoice = Int.random(in: 0..<3)
            playerShouldWin = Bool.random()
            playerScore = 0
            gameOver = false
        }
    }
                    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

