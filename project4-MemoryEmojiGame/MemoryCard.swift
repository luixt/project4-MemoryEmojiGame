//
//  MemoryCard.swift
//  project4-MemoryEmojiGame
//
//  Created by Luis Delgado on 3/28/26.
//

import Foundation

struct MemoryCard: Identifiable {
    let id = UUID()
    let content: String
    var isFaceUp = false
    var isMatched = false
}
