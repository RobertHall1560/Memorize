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
    
    var halloweenTheme: some View {
        cardThemeAdjuster(theme: "halloween", symbol: "👻")
    }
    
    var animalTheme: some View {
        cardThemeAdjuster(theme: "animal", symbol: "🐅")
    }
    
    var foodTheme: some View {
        cardThemeAdjuster(theme: "food", symbol: "🥙")
    }
    
    func cardThemeAdjuster(theme: String, symbol: String) -> some View {
        return VStack {
            Button(action: {
                cardTheme = theme
                var fullEmojis: Array<String> = []
                if theme == "halloween" {
                    fullEmojis = ["👻", "🎃", "🕷", "😈", "💀", "🧙", "🙀", "🦁", "😱", "☠️", "🍭"]
                    cardCount = 12
                } else if theme == "animal" {
                    fullEmojis = ["🐶", "🐰", "🐸", "🦆", "🐒", "🦅", "🐢", "🦞", "🐆", "🦧", "🦩"]
                    cardCount = 14
                } else if theme == "food" {
                    fullEmojis = ["🍏", "🍇", "🥥", "🌽", "🧀", "🥦", "🍔", "🍕", "🌮", "🧁", "🍪"]
                    cardCount = 16
                }
            emojis = createCardEmojis(themeEmojis: fullEmojis, count: cardCount)
            }, label: {
                Text(symbol).font(.largeTitle)
            })
            Text(theme)
        }
    }
    
    func createCardEmojis(themeEmojis: Array<String>, count: Int ) -> Array<String> {
        let newEmojis = themeEmojis.shuffled()
        let halfEmojis: ArraySlice<String> = newEmojis[0..<(count / 2)] + newEmojis[0..<(count / 2)]
        return halfEmojis.shuffled()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
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
