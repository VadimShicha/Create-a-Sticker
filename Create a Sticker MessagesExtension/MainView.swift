//
//  MainView.swift
//  Create a Sticker MessagesExtension
//
//  Created by Vadim Shicha on 5/8/24.
//

import SwiftUI

protocol ConversationDelegate {
    func sendText(text: String)
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
    "smiling-face-with-heart-eyes",
    "smirking-face",
    "loudly-crying-face",
    "pouting-face",
    "face-with-rolling-eyes",
    "clown-face",
    "man-facepalming",
    "prince"
]

let emojiList = [
    "😀", "😂", "😍", "😏", "😭", "😡", "🙄", "🤡", "🤦‍♂️", "🤴"
]

let symbolArtList = [
    """
    _______@@___@@_________
    _______@@___@@_________
    _______@@___@@_________
    _@____ @@___@@_____@__
    _@____ @@___@@_____@__
    __@_________________@___
    ___@_______________@____
    _____@___________@______
    _______@@@@@@________
    """,
    
    """
    _______§§§§§§§§§§§§§§§§_____
    _____§§§__§§§§__§§§§__§§____
    ___§§§§§§__§§§§__§§§§__§§§__
    _§§§__§§§§__§§§§__§§§§__§§§_
    §§§§§__§§§§__§§§§__§§§§__§§§
    §_§§§§__§§§§__§§§§__§§§§__§§
    §__§§§§__§§§§__§§§§__§§§§__§
    §§__§§§§__§§§§__§§§§__§§§§_§
    §§§__§§§§__§§§§__§§§§__§§§§§
    _§§§__§§§§__§§§§__§§§§__§§§_
    __§§§__§§§§__§§§§__§§§§__§__
    ___§§§__§§§§__§§§§__§§§§§___
    _____§§__§§§§__§§§§__§§§____
    ______§§§§§§§§§§§§§§§§§_____
    _________¶¶__¶¶¶__¶¶________
    __________¶___¶___¶_________
    __________¶___¶___¶_________
    __________¶___¶___¶_________
    ________¶¶¶¶¶¶¶¶¶¶¶¶¶_______
    ________ ¶1111111111¶_______
    ________ ¶1111111111¶_______
    ________¶¶¶¶¶¶¶¶¶¶¶¶¶_______
    """,
    
    """
    ________$$$$_______________
    _______$$__$_______________
    _______$___$$______________
    _______$___$$______________
    _______$$___$$_____________
    ________$____$$____________
    ________$$____$$$__________
    _________$$_____$$_________
    _________$$______$$________
    __________$_______$$_______
    ____$$$$$$$________$$______
    __$$$_______________$$$$$$
    _$$____$$$$____________$$$
    _$___$$$__$$$____________$$
    _$$________$$$____________$
    __$$____$$$$$$____________$
    __$$$$$$$____$$___________$
    __$$_______$$$$___________$
    ___$$$$$$$$$__$$_________$$
    ____$________$$$$_____$$$$
    ____$$____$$$$$$____$$$$$$
    _____$$$$$$____$$__$$
    _______$_____$$$_$$$
    ________$$$$$$$$$$
    """,
    
    """
    +88_________________+880
    _+880_______________++80
    _++88______________+880
    _++88_____________++88
    __+880___________++88
    __+888_________++880
    __++880_______++880
    __++888_____+++880
    __++8888__+++8880++88
    __+++8888+++8880++8888
    ___++888++8888+++8888+80
    ___++88++8888++888888++88
    ___++++++888888fx888888888
    ____++++++8888888888888888
    ____++++++++00088888888888
    _____+++++++00008f8888888
    ______+++++++00088888888
    _______+++++++0888f8888
    """
]

struct NavigationTabView: View {
    
    @Binding var selectedTabIndex: Int
    
    var body: some View {
        HStack {
            Spacer()
            Button("Emojis") {
                selectedTabIndex = 0
            }
            .foregroundColor(selectedTabIndex == 0 ? Color("TextGrayColor"): Color("TextDarkGrayColor"))
            .font(.system(size: selectedTabIndex == 0 ? 30 : 25).bold())
            Spacer()
            
            Button("Symbol Art") {
                selectedTabIndex = 1
            }
            .foregroundColor(selectedTabIndex == 1 ? Color("TextGrayColor"): Color("TextDarkGrayColor"))
            .font(.system(size: selectedTabIndex == 1 ? 30 : 25).bold())
            Spacer()
        }
        .padding(5)
        .background(Color("DarkBackgroundColor"))
    }
}

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
    
    @State var selectedTabIndex: Int = 0
    @State var selectedSizeIndex: Int = 1
    
    var body: some View {
        ZStack {
            Image("BackgroundTexture")
                .resizable(resizingMode: .tile)
            
            //Color("BackgroundColor").ignoresSafeArea()
            VStack {
                NavigationTabView(selectedTabIndex: $selectedTabIndex)
                
                if selectedTabIndex == 0 {
                    ScrollView(.vertical) {
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
                else if selectedTabIndex == 1 {
                    ScrollView(.vertical) {
                        VStack {
                            HStack {
                                Spacer()
                                Button("Smiley") {
                                    delegate?.sendText(text: symbolArtList[0])
                                }
                                .font(.system(size: 28).bold())
                                .foregroundColor(Color("TextRegularColor"))
                                .padding(5)
                                .background(Color("EmojiBackgroundColor"))
                                .cornerRadius(7)
                                Spacer()
                                Button("Hot Air Balloon") {
                                    delegate?.sendText(text: symbolArtList[1])
                                }
                                .font(.system(size: 28).bold())
                                .foregroundColor(Color("TextRegularColor"))
                                .padding(5)
                                .background(Color("EmojiBackgroundColor"))
                                .cornerRadius(7)
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Button("Thumb Hand") {
                                    delegate?.sendText(text: symbolArtList[2])
                                }
                                .font(.system(size: 28).bold())
                                .foregroundColor(Color("TextRegularColor"))
                                .padding(5)
                                .background(Color("EmojiBackgroundColor"))
                                .cornerRadius(7)
                                Spacer()
                                Button("Peace Hand") {
                                    delegate?.sendText(text: symbolArtList[3])
                                }
                                .font(.system(size: 28).bold())
                                .foregroundColor(Color("TextRegularColor"))
                                .padding(5)
                                .background(Color("EmojiBackgroundColor"))
                                .cornerRadius(7)
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
