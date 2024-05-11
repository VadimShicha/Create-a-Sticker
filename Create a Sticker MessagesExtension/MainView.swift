//
//  MainView.swift
//  Create a Sticker MessagesExtension
//
//  Created by Vadim Shicha on 5/8/24.
//

import SwiftUI

protocol ConversationDelegate {
    func sendMessage(text: String)
    func setEmojiSize(size: CGFloat)
}

enum EmojiStickerSize: CGFloat {
    case Small = 1.5
    case Medium = 2
    case Large = 3
    case ExtraLarge = 4
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
    
    @State var selectedEmojiIndex: Int = 0
    
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
                            selectedEmojiIndex = index
                        }
                        .font(.system(size: 40))
                        .padding(5)
                        .background(selectedEmojiIndex == index ? Color("EmojiSelectedBackgroundColor") : Color("EmojiBackgroundColor"))
                        .cornerRadius(7)
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
    
    @State var selectedSizeIndex: Int = 1
    
    var body: some View {
        ZStack {
            Image("BackgroundTexture")
                .resizable(resizingMode: .tile)
            
            //Color("BackgroundColor").ignoresSafeArea()
            VStack {
                ScrollView(.vertical) {
                    Text("Select an Emoji")
                        .font(.system(size: 30).bold())
                    EmojiView(delegate: delegate)
                }
                HStack {
                    Spacer()
                    Text("Select Size:")
                        .font(.system(size: 26).bold())
                    Spacer()
                    Button("x1.5") {selectedSizeIndex = 0; delegate?.setEmojiSize(size: 1.5)}
                        .font(.system(size: selectedSizeIndex == 0 ? 33 : 24).bold())
                    Spacer()
                    Button("x2") {selectedSizeIndex = 1; delegate?.setEmojiSize(size: 2)}
                        .font(.system(size: selectedSizeIndex == 1 ? 33 : 24).bold())
                    Spacer()
                    Button("x3") {selectedSizeIndex = 2; delegate?.setEmojiSize(size: 3)}
                        .font(.system(size: selectedSizeIndex == 2 ? 33 : 24).bold())
                    Spacer()
                    Button("x4") {selectedSizeIndex = 3; delegate?.setEmojiSize(size: 4)}
                        .font(.system(size: selectedSizeIndex == 3 ? 33 : 24).bold())
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
