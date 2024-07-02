//
//  ContentView.swift
//  Memorize
//
//  Created by Robert Hall on 6/20/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var cardCount: Int = 8
    @State var cardTheme: String = "halloween"
    @State var emojis: Array<String> = ["👻", "🎃", "🕷", "😈", "💀", "🧙", "🙀", "🦁", "😱", "☠️", "🍭"]
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.title)
                .fontWeight(.semibold)
            ScrollView {
                cards
            }
            Spacer()
            cardThemeAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
            .foregroundColor(.orange)
        }
    }
    
    var cardThemeAdjusters: some View {
        HStack {
            halloweenTheme
            Spacer()
            animalTheme
            Spacer()
            foodTheme
        }
        .padding(20)
    }
    
    func cardThemeAdjuster(theme: String, symbol: String) -> some View {
        return VStack {
            Button(action: {
                cardTheme = theme
                if theme == "halloween" {
                    var halloweenEmojis: Array<String> = ["👻", "🎃", "🕷", "😈", "💀", "🧙", "🙀", "🦁", "😱", "☠️", "🍭"]
                    halloweenEmojis.shuffle()
                    cardCount = 12
                    let halfEmojis: ArraySlice<String> = halloweenEmojis[0..<(cardCount / 2)] + halloweenEmojis[0..<(cardCount / 2)]
                    emojis = halfEmojis.shuffled()
                } else if theme == "animal" {
                    var animalEmojis: Array<String> = ["🐶", "🐰", "🐸", "🦆", "🐒", "🦅", "🐢", "🦞", "🐆", "🦧", "🦩"]
                    animalEmojis.shuffle()
                    cardCount = 14
                    let halfEmojis: ArraySlice<String> = animalEmojis[0..<(cardCount / 2)] + animalEmojis[0..<(cardCount / 2)]
                    emojis = halfEmojis.shuffled()
                } else if theme == "food" {
                    var foodEmojis: Array<String> = ["🍏", "🍇", "🥥", "🌽", "🧀", "🥦", "🍔", "🍕", "🌮", "🧁", "🍪"]
                    foodEmojis.shuffle()
                    cardCount = 16
                    let halfEmojis: ArraySlice<String> = foodEmojis[0..<(cardCount / 2)] + foodEmojis[0..<(cardCount / 2)]
                    emojis = halfEmojis.shuffled()
                }
            }, label: {
                Text(symbol).font(.largeTitle)
            })
            Text(theme)
        }
    }
        
    var halloweenTheme: some View {
        cardThemeAdjuster(theme: "halloween", symbol: "👻")
    }
    
    var animalTheme: some View {
        cardThemeAdjuster(theme: "animal", symbol: "🐅")
    }
    
    var foodTheme: some View {
        cardThemeAdjuster(theme: "food", symbol: "🥙")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
