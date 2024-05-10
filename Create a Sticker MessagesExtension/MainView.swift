//
//  MainView.swift
//  Create a Sticker MessagesExtension
//
//  Created by Vadim Shicha on 5/8/24.
//

import SwiftUI

protocol ConversationDelegate {
    func sendMessage(text: String)
    func setEmojiSize(size: EmojiStickerSize)
}

enum EmojiStickerSize {
    case Small
    case Medium
    case Large
    case ExtraLarge
}

let emojiImages = [
    "grinning-face",
    "face-with-tears-of-joy",
    "man-facepalming",
    "prince"
]

let emojiList = [
    "😀", "😂", "🤦‍♂️", "🤴"
]

struct EmojiView: View {
    var delegate: ConversationDelegate?

    var itemsPerRow: Int = 5
    
    var body: some View {
        VStack {
            
            let emojiListCountDivided = emojiList.count / itemsPerRow
            let emojiListRowAmount = Int(round(Double(emojiListCountDivided) + 0.499))
            
            ForEach(0..<emojiListRowAmount + 1) { i in
                HStack {
                    let rowStartIndex = i * itemsPerRow
                    var rowSize = itemsPerRow
                    
                    if i == emojiListRowAmount {
                        let _ = (rowSize = emojiList.count - rowStartIndex)
                    }
                        
                        
                    Spacer()
                    ForEach(0..<rowSize) { j in
                        let index = rowStartIndex + j
                        
                        Button(emojiList[index]) {
                            //delegate?.sendMessage(text: emojiList[index])
                            delegate?.sendMessage(text: emojiImages[index])
                        }
                        .font(.system(size: 40))
                        Spacer()
                    }
                }
            }
        }
    }
}

struct MainView: View {

    var delegate: ConversationDelegate?
    
    let brownColor = Color(UIColor(red: 212, green: 147, blue: 57, alpha: 1))
    let darkerBrownColor = Color(UIColor(red: 199, green: 136, blue: 48, alpha: 1))
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack {
                ScrollView(.vertical) {
                    EmojiView(delegate: delegate)
                }
                HStack {
                    Spacer()
                    Text("Select Size:")
                        .font(.system(size: 26).bold())
                    Spacer()
                    Button("x1.5") {delegate?.setEmojiSize(size: EmojiStickerSize.Small)}
                    Spacer()
                    Button("x2") {delegate?.setEmojiSize(size: EmojiStickerSize.Medium)}
                    Spacer()
                    Button("x3") {delegate?.setEmojiSize(size: EmojiStickerSize.Large)}
                    Spacer()
                    Button("x4") {delegate?.setEmojiSize(size: EmojiStickerSize.ExtraLarge)}
                    Spacer()
                }
                .background(Color("DarkBackgroundColor"))
            }
        }
    }
}

#Preview {
    MainView()
}
