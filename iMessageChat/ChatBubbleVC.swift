//
//  ChatBubbleVCViewController.swift
//  ChatBubble
//
//  Created by UGO MARINELLI on 21/11/2016.
//  Copyright © 2016 UGO MARINELLI. All rights reserved.
//

import UIKit

class ChatBubbleVC : UIViewController {
    @IBOutlet var viewContainerBottom: UIView!

    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var chatScrollView: UIScrollView!
    
    var lastChatBubbleY: CGFloat = 10.0
    var internalPadding: CGFloat = 8.0
    var lastMessageType : BubbleDataType?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Setting up chat Scroll View
        self.chatScrollView.contentSize = CGSize(width : chatScrollView.frame.width, height: lastChatBubbleY + internalPadding)
        self.chatScrollView.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).cgColor
        self.chatScrollView.layer.borderWidth = 0.5
        messageTextField.autocorrectionType = UITextAutocorrectionType.no
        
        
        }

    //Send Msg
    @IBAction func sendMsg(_ sender: Any) {
        addMessage(msg: messageTextField.text!)
    }
    
    func addMessage(msg: String) {
        let msg = ChatBubbleData(text: msg, image: nil, date: nil)
        displayMessage(msgArray: [msg])
    }
 
    
    func displayMessage(msgArray : [ChatBubbleData])
    {
        for message in msgArray
        {
            let bubbleType = self.returnBubbleDataType(message: message)
            let chatBubbleData = ChatBubbleData(text: message.text, image: nil, date: message.date, type: bubbleType)
                addChatBubble(data: chatBubbleData)
        }
    }
    
    // Checking if the message was sent by the user or not
    func returnBubbleDataType(message : ChatBubbleData) -> BubbleDataType {
        let typeToReturn : BubbleDataType = BubbleDataType.Mine
        return typeToReturn
    }
    
    //Method that adds the bubble in the conversation, and create a new bubble view
    func addChatBubble(data: ChatBubbleData) {
        let padding:CGFloat = lastMessageType == data.type ? internalPadding/3.0 :  internalPadding
        let chatBubble = ChatBubble(data: data, startY:lastChatBubbleY + padding)
        self.chatScrollView.addSubview(chatBubble)
        chatBubble.frame.origin.y += 8
        lastChatBubbleY = chatBubble.frame.maxY
        self.chatScrollView.contentSize = CGSize(width : chatScrollView.frame.width, height : lastChatBubbleY + internalPadding)
        self.moveToLastMessage()
        lastMessageType = data.type
        messageTextField.text = ""
    }
    
    //will move the scroll view to the last message
    func moveToLastMessage() {
        if chatScrollView.contentSize.height > chatScrollView.frame.height {
            let contentOffSet = CGPoint(x : 0.0, y: chatScrollView.contentSize.height - chatScrollView.frame.height)
            self.chatScrollView.setContentOffset(contentOffSet, animated: true)
        }
    }
    
    func adjustingHeight(show:Bool, notification:NSNotification) {
        // 1
        var userInfo = notification.userInfo!
        // 2
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        // 3
        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        // 4
        let changeInHeight = (keyboardFrame.height + 10) * (show ? 1 : -1)
        //5
        if keyboardFrame.contains(CGPoint(x : viewContainerBottom.frame.origin.x, y :viewContainerBottom.frame.origin.y))
        {
            UIView.animate(withDuration: animationDurarion, animations: { () -> Void in
                self.bottomConstraint.constant += changeInHeight
            })
        }
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(notification:NSNotification) {
        adjustingHeight(show: true, notification: notification)

          }
    
    func keyboardWillHide(notification:NSNotification) {
        adjustingHeight(show: false, notification: notification)
    }


}
