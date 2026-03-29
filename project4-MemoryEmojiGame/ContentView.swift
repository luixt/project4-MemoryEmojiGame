//
//  ContentView.swift
//  project4-MemoryEmojiGame
//
//  Created by Luis Delgado on 3/28/26.
//

import SwiftUI

struct ContentView: View {
    @State var game = EmojiGameViewModel()

    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]

    var body: some View {
        VStack {
            Text("Memory Match")
                .font(.largeTitle)
                .fontWeight(.bold)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    game.choose(card)
                                }
                            }
                    }
                }
                .padding()
            }

            Button("Reset Game") {
                withAnimation {
                    game.resetGame()
                }
            }
            .font(.headline)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

struct CardView: View {
    let card: MemoryCard

    var body: some View {
        ZStack {
            // The Front of the Card
            Group {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .strokeBorder(.blue, lineWidth: 3)
                Text(card.content)
                    .font(.system(size: 40))
            }
            .opacity(card.isFaceUp ? 1 : 0) // Only visible when face up

            // The Back of the Card
            RoundedRectangle(cornerRadius: 12)
                .fill(.blue)
                .opacity(card.isFaceUp ? 0 : 1) // Only visible when face down
        }
        // This creates the 3D flip effect
        .rotation3DEffect(
            .degrees(card.isFaceUp ? 0 : 180),
            axis: (x: 0, y: 1, z: 0) // Rotates around the Y-axis (vertical)
        )
        .opacity(card.isMatched ? 0 : 1)
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: card.isFaceUp)
    }
}

#Preview {
    ContentView()
}
