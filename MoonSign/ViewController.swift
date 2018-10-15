//
//  ViewController.swift
//  MoonSign
//
//  Created by Mac on 9/6/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Cosmos

class ViewController: JSQMessagesViewController,GetTemplateText {
    func getText(text: String) {
//       self.sendQuestions(text: text)
        self.inputToolbar.contentView.textView.text = text
        self.inputToolbar.toggleSendButtonEnabled()
    }
    

    private var messages = [JSQMessage]()
    
    let receiverMessages = ["Hello","August 25 is the best day"]
    
    var conversation = [String:String]()
    var conversations = [[String:String]]()
    
    var incomingBubble: JSQMessagesBubbleImage!
    var outgoingBubble: JSQMessagesBubbleImage!
    
    var senderAvatarImage : JSQMessagesAvatarImage!
    var receiverAvatarImage : JSQMessagesAvatarImage!
    
    var loveTitles = [String]()
    var career = [String]()
    var remedies = [String]()
    var others = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchTemplateMessages()
//        Utility.ENABLE_IQKEYBOARD()
        
        self.inputToolbar.contentView.textView.placeHolder = "Send New Message"
        
        self.senderId = SaveData.getCustomerID()
        self.senderDisplayName = "Test"
        
        // Do any additional setup after loading the view, typically from a nib.
        
        incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
        outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
        
        self.senderAvatarImage = JSQMessagesAvatarImageFactory.avatarImage(with: #imageLiteral(resourceName: "profiledefault"), diameter: 30)
        self.receiverAvatarImage = JSQMessagesAvatarImageFactory.avatarImage(with: #imageLiteral(resourceName: "profiledefault"), diameter: 30)
        
        self.collectionView.backgroundColor = UIColor.white
        
//        for message in receiverMessages{
//            self.messages.append(JSQMessage(senderId: "low", displayName: "Low", text: message))
//        }
//        self.collectionView.reloadData()
        
        if SaveData.isLoggedIn(){
            self.fetchChats()
        }
        else{
            
        }
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
         finishSendingMessage()
        self.sendQuestions(text: text)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.row]
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        return messages[indexPath.item].senderId == self.senderId ? outgoingBubble : incomingBubble
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
         return messages[indexPath.item].senderId == self.senderId ? senderAvatarImage : receiverAvatarImage
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "MessageTemplatesViewController") as! MessageTemplatesViewController
        
        controller.loveTitles = self.loveTitles
        controller.career = self.career
        controller.remedies = self.remedies
        controller.others = self.others
        
        controller.delegate = self
        
        controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        controller.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(controller, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        cell.cellBottomLabel.textColor = UIColor(red: 80.0/255.0, green: 15.0/255.0, blue: 159.0/255.0, alpha: 1.0)
        cell.cellBottomLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        
//        let message = self.conversations[indexPath.row]
//        if message["qa"] == "a"{
//            let tapGesture = UITapGestureRecognizer(target: self, action: messageTapped(i: indexPath.row) )
//            cell.addGestureRecognizer(tapGesture)
//        }
//
        return cell
    }
   
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        print("message tapped")
        let message = self.conversations[indexPath.row]
        if message["qa"] == "a"{
            let alert = UIAlertController(title: "Rate Now", message: "Please select your rating star", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "★", style: .default, handler: { _ in
                
            }))
            
            alert.addAction(UIAlertAction(title: "★★", style: .default, handler: { _ in
                
            }))
            alert.addAction(UIAlertAction(title: "★★★", style: .default, handler: { _ in
                
            }))
            
            alert.addAction(UIAlertAction(title: "★★★★", style: .default, handler: { _ in
                
            }))
            alert.addAction(UIAlertAction(title: "★★★★★", style: .default, handler: { _ in
                
            }))
            
            
            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
            
            //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                alert.popoverPresentationController?.sourceView = self.collectionView
                alert.popoverPresentationController?.sourceRect = self.collectionView.bounds
                alert.popoverPresentationController?.permittedArrowDirections = .up
            default:
                break
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellBottomLabelAt indexPath: IndexPath!) -> CGFloat {
        
        let messages = self.conversations[indexPath.row]
        
        if messages["qa"] == "a"{
            return 40
        }
        else{
            return 0
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForCellBottomLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let message = self.conversations[indexPath.row]
        if message["qa"] == "a"{
            let r = Int(message["rating"]!)
            var stars = ""
//            for _ in 0...r!{
//                stars = stars + "★"
//            }
            switch r {
            case 0:
                stars = ""
                break
            case 1:
                stars = "Rating: ★"
                break
            case 2:
                stars = "Rating: ★★"
                break
            case 3:
                stars = "Rating: ★★★"
                break
            case 4:
                stars = "Rating: ★★★★"
                break
            case 5:
                stars = "Rating: ★★★★★"
                break
            default:
                break
            }
            return NSAttributedString(string: stars)
        }
        else{
            return NSAttributedString(string: "")
        }
    }
    func rateMessage(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchChats(){
        self.conversations.removeAll()
        self.messages.removeAll()
        self.conversation.removeAll()
        
        let stringURL : String = HTTPConstants.baseURl + "/api/question/GetConvo/" + SaveData.getCustomerID()
        HTTPRequests.HTTPGetRequestData(stringURL, withSuccess: {(response,statusFlag) in
            if statusFlag{
                do{
                    let root = try JSONDecoder().decode(GetConversationRoot.self, from: response!)
                    if root.meta?.status == "Ok"{
                        for datas in root.data!{
                            if datas.questions == nil{
                                if datas.answer != nil{
                                    self.conversation.updateValue("\(datas.answer?.id! ?? 0)", forKey: "answerId")
                                    self.conversation.updateValue(datas.answer?.answers! ?? "a", forKey: "answer")
                                    self.conversation.updateValue("\(datas.answer?.rating! ?? 0)", forKey: "rating")
                                    self.conversation.updateValue("a", forKey: "qa")
                                    self.conversations.append(self.conversation)
                                }
                            }
                            else{
                                self.conversation.updateValue(datas.customerDto ?? "", forKey: "customerDto")
                                self.conversation.updateValue(datas.questions!, forKey: "questions")
                                self.conversation.updateValue("\(datas.id!)", forKey: "id")
                                self.conversation.updateValue("\(datas.customerId!)", forKey: "customerId")
                                self.conversation.updateValue(datas.moderatorDataId ?? "", forKey: "moderatorDataId")
                                self.conversation.updateValue("q", forKey: "qa")
                                self.conversations.append(self.conversation)
                                
                                if datas.answer != nil{
                                    self.conversation.updateValue("\(datas.answer?.id! ?? 0)", forKey: "answerId")
                                    self.conversation.updateValue(datas.answer?.answers! ?? "a", forKey: "answer")
                                    self.conversation.updateValue("\(datas.answer?.rating! ?? 0)", forKey: "rating")
                                    self.conversation.updateValue("a", forKey: "qa")
                                    self.conversations.append(self.conversation)
                                }
                            }
                        }
                        self.setUpMessages()
                    }
                    
                }
                catch let jsonerror{
                    print(jsonerror as Any)
                }
            }
            else{
                let ac = UIAlertController(title: "Sorry", message: "Please check your internet connection", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(ac, animated: true)
            }
        })
    }
    
    func setUpMessages(){
        for conversations in self.conversations{
            if conversations["qa"] == "q"{
                self.messages.append(JSQMessage(senderId: conversations["customerId"], displayName: "Test", text: conversations["questions"]))
                
            }
            else{
                self.messages.append(JSQMessage(senderId: conversations["answerId"], displayName: "Test", text: conversations["answer"]))
            }
        }
        self.collectionView.reloadData()
    }
    
    func sendQuestions(text: String){
        let stringURL : String = HTTPConstants.baseURl + "api/question/CreateQuestion"
        let parameters = [
            "Questions": text as AnyObject,
            "CustomerId": SaveData.getCustomerID() as AnyObject
        ] as [String:AnyObject]
        
        HTTPRequests.HTTPPostRequest(stringURL, parameters: parameters, withSuccess: ({ (responce, statusFlag) in
            if statusFlag{
                self.fetchChats()
//                self.messages.append(JSQMessage(senderId: SaveData.getCustomerID(), displayName: "Test", text: text))
//                self.collectionView.reloadData()
            }
        }))
    }
    
    func fetchTemplateMessages(){
        let stringURL: String = HTTPConstants.baseURl + "api/questiontemplate/GetTemplate"
        HTTPRequests.HTTPGetRequestData(stringURL, withSuccess: {(response,statusFlag) in
            if statusFlag{
                do{
                    let root = try JSONDecoder().decode(GetTemplateRoot.self, from: response!)
                    print(root as Any)
                    for datas in root.data!{
                        switch datas.name!{
                        case "Love":
                            for questions in datas.questionList!{
                                self.loveTitles.append(questions.questionExample!)
                            }
                            break
                        case "Career":
                            for questions in datas.questionList!{
                                self.career.append(questions.questionExample!)
                            }
                            break
                        case "Remedies":
                            for questions in datas.questionList!{
                                self.remedies.append(questions.questionExample!)
                            }
                            break
                        case "Other":
                            for questions in datas.questionList!{
                                self.others.append(questions.questionExample!)
                            }
                            break
                        default:
                            break
                        }
                    }
                }
                catch let jsonerror{
                    print(jsonerror as Any)
                }
            }
        })
    }


}

