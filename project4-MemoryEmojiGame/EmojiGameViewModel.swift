//
//  EmojiGameViewModel.swift
//  project4-MemoryEmojiGame
//
//  Created by Luis Delgado on 3/28/26.
//

import SwiftUI

@Observable
class EmojiGameViewModel {
    var cards: [MemoryCard] = []
    
    private var indexOfSelectedCard: Int?
    private let emojis = ["👻", "🎃", "🧙‍♀️", "🧛‍♂️", "🧟", "💀"]

    init() {
        resetGame()
    }

    func resetGame() {
        cards = []
        for emoji in emojis {
            cards.append(MemoryCard(content: emoji))
            cards.append(MemoryCard(content: emoji))
        }
        cards.shuffle()
    }

    func choose(_ card: MemoryCard) {
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
              !cards[chosenIndex].isFaceUp,
              !cards[chosenIndex].isMatched else { return }

        if let potentialMatchIndex = indexOfSelectedCard {
            cards[chosenIndex].isFaceUp = true
            
            if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                cards[chosenIndex].isMatched = true
                cards[potentialMatchIndex].isMatched = true
            }
            indexOfSelectedCard = nil
        } else {
            for index in cards.indices {
                cards[index].isFaceUp = false
            }
            indexOfSelectedCard = chosenIndex
            cards[chosenIndex].isFaceUp = true
        }
    }
}
