//
//  Quiz.swift
//  TravelFocus
//
//  Created by Danis Harmandic on 27. 1. 2023..
//

import SwiftUI

struct QuizView: View {
    @State private var currentQuestion = 0
    @State private var score = 0
    @State private var showAnswer = false
    @State private var message = ""
    @State private var showContinueButton = false
    @State private var selectedOption = ""
    let questions = [
        "Koji je glavni grad Francuske?",
        "Kako se zove najveći ocean na svijetu?",
        "Gdje se nalazi tvrđava Kastel?",
        "Valuta u Japanu zove se?",
        "Najveća planina na svijetu je??"
    ]
    
    let answers = [
        "Pariz",
        "Tihi Ocean",
        "Banja Luka",
        "Yen",
        "Mount Everest"
    ]
    let options = [
        ["Pariz", "Rim","Madrid","Brisel"],
        ["Atlanski Ocean", "Indijski Ocean", "Arktički Ocean", "Tihi Ocean"],
        ["Sarajevo", "Banja Luka", "Beograd","Zagreb"],
        ["Yen", "Yuan", "Rubalj", "Rupee"],
        ["Mount Everest", "K2", "Kangchenjunga", "McKinley"]
    ]
    var body: some View {
        ZStack {
            Color(red: 0.6, green: 0.9, blue: 1.0).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Pitanje \(currentQuestion + 1) od \(questions.count)")
                    .font(.headline)
                Text(questions[currentQuestion])
                    .font(.system(size: 25, weight: .bold))
                    .foregroundColor(Color.black)
                    .padding(.bottom, 20)
                ForEach(options[currentQuestion], id: \.self) { option in
                    Button(action: {
                        self.selectedOption = option
                        if option == self.answers[self.currentQuestion]{
                            self.score += 1
                            self.message = "Točno!"
                        } else {
                            self.message = "Netočno!"
                        }
                        self.showAnswer = true
                    }) {
                        Text(option)
                            .foregroundColor(.black)
                            .padding()
                            .background(self.selectedOption == option ? (option == self.answers[self.currentQuestion] ? Color.green : Color.red) : Color.white)
                            .cornerRadius(20)
                            .padding(.bottom, 20)
                            .animation(.easeInOut(duration: 1.1))
                    }
                }
                if showAnswer {
                    Text(message)
                        .font(.title)
                        .foregroundColor(.black)
                        .padding()
                    if currentQuestion < questions.count - 1 {
                        Button(action: {
                            self.currentQuestion += 1
                            self.showAnswer = false
                            self.message = ""
                            self.selectedOption = ""
                        }) {
                            HStack {
                                Text("Dalje")
                                Image(systemName: "arrowshape.right.fill")
                                    .foregroundColor(Color(red: 0.0, green: 0.0, blue: 0.8))
                                    .padding()
                                    .animation(.spring(blendDuration: 2.1))
                            }
                            
                        }
                    } else {
                        Text("Tvoj konačni rezultat je \(score) od \(questions.count)")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct Quiz_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
