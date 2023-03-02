//
//  ContentView.swift
//  puzzles
//
//  Created by Jahaan Rawat on 2023-02-28.
//
import SwiftUI

struct ColorMemoryGameView: View {
    let colors: [Color] = [.red, .green, .blue, .yellow, .orange]
    let colorSequenceLength = 2
    @State var currentSequenceIndex = 0
    @State var currentSequence = [Color]()
    @State var userSequence = [Color]()
    @State var isGameOver = false
    @State var score = 0
    @State var sequenceLength = 1
    
    var body: some View {
        VStack {
            Text("Score: \(score)")
                .font(.title)
                .padding()
            
            if !isGameOver {
                // Show the color sequence
                ForEach(0..<currentSequence.count, id: \.self) { index in
                    Circle()
                        .fill(currentSequence[index])
                        .frame(width: 50, height: 50)
                        .padding()
                }

                
                // Show the color buttons
                HStack {
                    ForEach(colors, id: \.self) { color in
                        Button(action: {
                            userSequence.append(color)
                            checkUserSequence()
                        }, label: {
                            Circle()
                                .fill(color)
                                .frame(width: 50, height: 50)
                                .padding()
                        })
                    }
                }
                .padding()
            } else {
                // Show game over screen
                Text("Game Over!")
                    .font(.largeTitle)
                    .padding()
                Button("Play Again", action: {
                    resetGame()
                })
                .padding()
            }
        }
    }
    
    func startNewSequence() {
        currentSequence = []
        for _ in 1...sequenceLength {
            let randomIndex = Int.random(in: 0..<colors.count)
            currentSequence.append(colors[randomIndex])
        }
        currentSequenceIndex = 0
    }
    
    func checkUserSequence() {
        if userSequence.count == currentSequence.count {
            if userSequence == currentSequence {
                score += 1
                sequenceLength += 1
                startNewSequence()
            } else {
                isGameOver = true
            }
            userSequence = []
        } else if userSequence[currentSequenceIndex] != currentSequence[currentSequenceIndex] {
            isGameOver = true
        } else {
            currentSequenceIndex += 1
        }
    }
    
    func resetGame() {
        currentSequenceIndex = 0
        currentSequence = []
        userSequence = []
        isGameOver = false
        score = 0
        sequenceLength = 1
        startNewSequence()
    }
}

struct ColorMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        ColorMemoryGameView()
    }
}

