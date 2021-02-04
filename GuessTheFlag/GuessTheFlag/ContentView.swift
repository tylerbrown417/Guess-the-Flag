//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tyler Brown on 1/28/21.
//

import SwiftUI




struct FlagVeiws: View {
    var name: String
    
    var body: some View {
        
         Image(name)
            .renderingMode(.original)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.black,lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}



struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"] .shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var incorrectAnswer = ""
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack(spacing: 30) {
            
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagVeiws(name: self.countries[number])
                            
                    }
                }
                
                Spacer()
            }
            
            VStack(alignment: .center, spacing: .some(300), content: {
                Text("")
            
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    . font(.largeTitle)
                    .fontWeight(.black)
                })
            }
    
        
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(userScore)"), dismissButton: .default(Text("Continue")){
                self.askQuestion()
            })
        }
        
    }
    
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            userScore += 10
        }
            else {
                scoreTitle = "Incorrect, you chose the flag of \(countries[number])"
                
            }
        
            showingScore = true
        }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random( in: 0...2)
        
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        }
    }
