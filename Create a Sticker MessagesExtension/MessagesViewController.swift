//
//  MessagesViewController.swift
//  Create a Sticker MessagesExtension
//
//  Created by Vadim Shicha on 5/6/24.
//

import UIKit
import Messages
import SwiftUI

extension String {
    
    /// Generates a `UIImage` instance from this string using a specified
    /// attributes and size.
    ///
    /// - Parameters:
    ///     - attributes: to draw this string with. Default is `nil`.
    ///     - size: of the image to return.
    /// - Returns: a `UIImage` instance from this string using a specified
    /// attributes and size, or `nil` if the operation fails.
    func image(withAttributes attributes: [NSAttributedString.Key: Any]? = nil, size: CGSize? = nil) -> UIImage? {
        let size = size ?? (self as NSString).size(withAttributes: attributes)
        return UIGraphicsImageRenderer(size: size).image { _ in
            (self as NSString).draw(in: CGRect(origin: .zero, size: size),
                                    withAttributes: attributes)
        }
    }
    
}

extension CGSize {
    
    typealias ContextClosure = (_ context: CGContext, _ frame: CGRect) -> ()
    func image(withContext context: ContextClosure) -> UIImage? {
        
        UIGraphicsBeginImageContext(self)
        let frame = CGRect(origin: .zero, size: self)
        context(UIGraphicsGetCurrentContext()!, frame)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

@objc(MessagesViewController)
class MessagesViewController: MSMessagesAppViewController, ConversationDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let mainView = MainView(delegate: self)
        
        let child = UIHostingController(rootView: mainView)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(child.view)
        
        NSLayoutConstraint.activate([
            child.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0)
        ])
    }
    
    func imageFromEmoji(emoji: String, size: CGFloat) -> UIImage? {
        return emoji.image(withAttributes: [
            .font: UIFont.systemFont(ofSize: size),
            .backgroundColor: UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        ], size: CGSize(width: size, height: size))
    }
    
    var selectedEmojiText: String = ""
    var emojiImage: UIImage?
    
    func sendMessage(text: String) {
        //print("DELEGATE WORKING")
        //print(self.activeConversation?.)

//        let imagePath = Bundle.main.path(forResource: "strawberry", ofType: ".png")
//        let pathURL = URL(fileURLWithPath: imagePath!)
//        
//        do {
//            var sticker = try MSSticker(contentsOfFileURL: pathURL, localizedDescription: "Strawberry Sticker")
//            //self.activeConversation?.insertText("Text from Code!!!")
//            self.activeConversation?.insert(sticker)
//        }
//        catch {
//            
//        }
        selectedEmojiText = text
        
        let message = MSMessage()
        let layout = MSMessageTemplateLayout()
        
        emojiImage = imageFromEmoji(emoji: selectedEmojiText, size: 20)
        layout.image = emojiImage
        message.summaryText = text
        message.layout = layout
        self.activeConversation?.insert(message)
        
    }
    
    func setEmojiSize(size: CGFloat) {
        
        
        let message = MSMessage()
        let layout = MSMessageTemplateLayout()
        
        var img = imageFromEmoji(emoji: selectedEmojiText, size: 20)
        
        let image = CGSize(width: 10, height: 10).image { context, frame in

            img?.draw(in: frame, blendMode: .luminosity, alpha: 1)
        }
        
        layout.image = image
        
        message.summaryText = selectedEmojiText
        message.layout = layout
        self.activeConversation?.insert(message)
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dismisses the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }

}
