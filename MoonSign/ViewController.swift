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
import SwiftSoup
import SwiftyStoreKit
class ViewController: JSQMessagesViewController,GetTemplateText,UIGestureRecognizerDelegate, JSQMessagesInputToolbarDelegate {
    override func hideKeyboard() {
        print("tapped")
    }
    
    func messagesInputToolbar(_ toolbar: JSQMessagesInputToolbar!, didPressRightBarButton sender: UIButton!) {
        print("right")
    }
    
    func messagesInputToolbar(_ toolbar: JSQMessagesInputToolbar!, didPressLeftBarButton sender: UIButton!) {
        print("left")

    }
    
    func getText(text: String) {
//      self.sendQuestions(text: text)
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
    
    var isLastQuestion : Bool = true
    var noOfAnswersAfterQuestions: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Device token",SaveData.getDeviceToken())
        fetchTemplateMessages()
        NotificationCenter.default.addObserver(self, selector: #selector(sendMessageNotification(notification:)), name: .messageSendNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(messageBubbleNotification), name: .messageBubbleNotification, object: nil)
        self.automaticallyAdjustsScrollViewInsets = true
        self.inputToolbar.isHidden = true
        self.senderId = SaveData.getCustomerID()
        self.senderDisplayName = "Test"
        
        // Do any additional setup after loading the view, typically from a nib.
//        incomingBubble = JSQMessagesBubbleImageFactory(bubble: UIImage(named: "tailessMessageBubble")
        incomingBubble = JSQMessagesBubbleImageFactory(bubble: UIImage.jsq_bubbleCompactTailless(), capInsets: UIEdgeInsets.zero).incomingMessagesBubbleImage(with: UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0))
        outgoingBubble = JSQMessagesBubbleImageFactory(bubble: UIImage.jsq_bubbleCompactTailless(), capInsets: UIEdgeInsets.zero).outgoingMessagesBubbleImage(with: UIColor(red:0.78, green:0.86, blue:0.95, alpha:1.0))
        
        self.senderAvatarImage = JSQMessagesAvatarImageFactory.avatarImage(with: #imageLiteral(resourceName: "profiledefault"), diameter: 30)
        self.receiverAvatarImage = JSQMessagesAvatarImageFactory.avatarImage(with: #imageLiteral(resourceName: "profiledefault"), diameter: 30)
        JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: ColorConstants.primaryColor)
        
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
    override func viewWillAppear(_ animated: Bool) {
         self.inputToolbar.contentView.textView.placeHolder = "← Ideas what to ask"
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        self.scrollToBottom(animated: true)
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
        cell.cellBottomLabel.textColor = ColorConstants.primaryColor
        cell.cellBottomLabel.font = cell.cellBottomLabel.font.withSize(25)
        
        cell.cellTopLabel.textAlignment = .left
        cell.cellTopLabel.font = cell.cellTopLabel.font.withSize(14)
        
        cell.textView.textColor = UIColor.black
        
        let message = self.conversations[indexPath.row]
        if message["qa"] == "a"{
            
//            let webView = UIWebView(frame: CGRect(x: cell.textView.frame.origin.x, y: cell.textView.frame.origin.y, width: cell.messageBubbleContainerView.frame.width, height: cell.messageBubbleContainerView.frame.height))
//            webView.isOpaque = false
//            webView.backgroundColor = UIColor.clear
//            webView.loadHTMLString(message["answer"]!, baseURL: nil)
//            cell.messageBubbleContainerView.addSubview(webView)
            do {
                let html = message["answer"]
                let doc = try SwiftSoup.parse(html!)
                cell.textView.text = try doc.text()

              //  return try doc.text()
            }  catch {
                print("error")
            }
            cell.avatarImageView.af_setImage(withURL: SaveData.getModeratorImageURL())
            
//            let ratingView = CosmosView(frame: CGRect(x: cell.cellBottomLabel.frame.origin.x, y: cell.cellBottomLabel.frame.origin.y, width: cell.cellBottomLabel.frame.width, height: cell.cellBottomLabel.frame.height))
            
             let ratingView = CosmosView(frame: CGRect(x: 0, y: 10, width: cell.cellBottomLabel.frame.width, height: cell.cellBottomLabel.frame.height-10))
            
//            let ratingView = CosmosView(frame: CGRect(x: 8, y: cell.messageBubbleContainerView.frame.maxY + 30, width: cell.messageBubbleContainerView.frame.width, height: cell.cellBottomLabel.frame.height))
            
            let initialRating = Double(message["rating"] ?? "0.0")
            ratingView.rating = initialRating ?? 1.0
//            ratingView.settings.updateOnTouch = true
            ratingView.settings.fillMode = .half
            ratingView.didTouchCosmos = {rating in
                print("\(rating)"+":\(indexPath.row)")
//                self.rateMessage(id: message["id"] ?? "1",rating: "\(rating)")
            }
            ratingView.didFinishTouchingCosmos = {rating in
                print("\(rating)"+":\(indexPath.row)")
                print(message.description)
                self.rateMessage(id: message["answerId"] ?? "1",rating: "\(rating)")
            }
            ratingView.settings.starSize = 30
            if indexPath.row == 0{
                ratingView.removeFromSuperview()
            }
            else{
//                ratingView.removeFromSuperview()
                cell.cellBottomLabel.addSubview(ratingView)
                cell.cellBottomLabel.bringSubview(toFront: ratingView)
                
                cell.cellBottomLabel.isUserInteractionEnabled = true
                
//                cell.messageBubbleContainerView.addSubview(ratingView)
//                cell.messageBubbleContainerView.bringSubview(toFront: ratingView)
                
//                cell.bringSubview(toFront: cell.messageBubbleContainerView)
            }
        }
        else{
            cell.avatarImageView.af_setImage(withURL: SaveData.getProfileImageURL())
        }
//        let message = self.conversations[indexPath.row]
//        if message["qa"] == "a"{
//            let tapGesture = UITapGestureRecognizer(target: self, action: messageTapped(i: indexPath.row) )
//            cell.addGestureRecognizer(tapGesture)
//        }
//
        let singleTapGestureRecognizer = IndexTapGesture(target: self, action: #selector(didSingleTapOnView))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.delegate = self
        singleTapGestureRecognizer.indexPath = indexPath
        if indexPath.row != 0{
//            cell.textView?.addGestureRecognizer(singleTapGestureRecognizer)
        }
        
        
        return cell
    }
    
    private func didTouchCosmos(_ rating: Double) {
//        self.ratingText.text = self.formatValue(rating)
//        self.rating = self.formatValue(rating)
        
        print(rating)
    }
    
    private func didFinishTouchingCosmos(_ rating: Double) {
//        self.ratingText.text = self.formatValue(rating)
//        self.rating = self.formatValue(rating)
        print(rating)
    }
    @objc func didSingleTapOnView(gesture: IndexTapGesture){
        print("message tapped")
        let indexPath = gesture.indexPath!
        print(indexPath.row)
        let message = self.conversations[indexPath.row]
        if message["qa"] == "a"{
          var  id = message["id"] ?? "1"
            let alert = UIAlertController(title: "Rate Now", message: "Please select your rating star", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "★☆☆☆☆", style: .default, handler: { _ in
                self.rateMessage(id: id, rating: "1")
            }))
            
            alert.addAction(UIAlertAction(title: "★★☆☆☆", style: .default, handler: { _ in
                self.rateMessage(id: id, rating: "2")
            }))
            alert.addAction(UIAlertAction(title: "★★★☆☆", style: .default, handler: { _ in
                self.rateMessage(id: id, rating: "3")
            }))
            
            alert.addAction(UIAlertAction(title: "★★★★☆", style: .default, handler: { _ in
                self.rateMessage(id: id, rating: "4")
            }))
            alert.addAction(UIAlertAction(title: "★★★★★", style: .default, handler: { _ in
                self.rateMessage(id: id, rating: "5")
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
            self.present(alert, animated: true, completion: nil)
        }
    }
   
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.messages.count)
        return self.messages.count
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellBottomLabelAt indexPath: IndexPath!) -> CGFloat {
        
        let messages = self.conversations[indexPath.row]
        
        if messages["qa"] == "a"{
            if indexPath.row == 0{
                return 0
            }
            else{
                if isLastQuestion{
                    if indexPath.row == self.messages.count - 1{
                        return 50
                    }
                    else{
                        return 0
                    }
                }
                else{
                    if indexPath.row == self.messages.count - 1 - noOfAnswersAfterQuestions{
                        return 50
                    }
                    else{
                        return 0
                    }
                }
            }
        }
        else{
            return 0
        }
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAt indexPath: IndexPath!) -> CGFloat {
        let messages = self.conversations[indexPath.row]
        
        if messages["qa"] == "a"{
            return 30
        }
        else{
            return 0
        }
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let message = self.conversations[indexPath.row]
        if message["qa"] == "a"{
             return NSAttributedString(string: SaveData.getModeratorName())
        }
        else{
            return NSAttributedString(string: "")
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
                stars = "☆☆☆☆☆"
                break
            case 1:
                stars = "Rating: ★☆☆☆☆"
                break
            case 2:
                stars = "Rating: ★★☆☆☆"
                break
            case 3:
                stars = "Rating: ★★★☆☆"
                break
            case 4:
                stars = "Rating: ★★★★☆"
                break
            case 5:
                stars = "Rating: ★★★★★"
                break
            default:
                break
            }
//            return NSAttributedString(string: stars)
            return NSAttributedString(string: "")
        }
        else{
            return NSAttributedString(string: "")
        }
    }
    func rateMessage(id: String, rating: String){
        let stringURL : String = HTTPConstants.baseURl + "api/rating/rate"
        let parameters = [
            "Id": id as AnyObject,
            "Rating": Int(Float(rating)!) as AnyObject
            ] as [String:AnyObject]
        
        HTTPRequests.HTTPPostRequest(stringURL, parameters: parameters, withSuccess: ({ (responce, statusFlag) in
            if statusFlag{
                //self.fetchChats()
                let ac = UIAlertController(title: "Success", message: "Your rating has been posted successfully", preferredStyle: .alert)
                
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                    self.navigationController?.popViewController(animated: true)
                    
                }))
                self.present(ac, animated: true)
                //                self.messages.append(JSQMessage(senderId: SaveData.getCustomerID(), displayName: "Test", text: text))
                //                self.collectionView.reloadData()
            }
        }))
    }
    
    @objc func sendMessageNotification(notification: NSNotification){
        finishSendingMessage()
        
        SwiftyStoreKit.purchaseProduct("net.blackspring.moonshine.question", quantity: 1, atomically: false) { result in
            switch result {
            case .success(let product):
                // fetch content from your server, then:
                self.sendQuestions(text: notification.object as! String)

                if product.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(product.transaction)
                }
                print("Purchase Success: \(product.productId)")
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                default: print((error as NSError).localizedDescription)
                }
            }
        }
        
    }
    @objc func messageBubbleNotification(){
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchChats(){
        self.conversations.removeAll()
        self.messages.removeAll()
        self.conversation.removeAll()
//        self.messages.append(JSQMessage(senderId: SaveData.getWelcomeMessage()["answerId"]!, displayName: SaveData.getModeratorName(), text: SaveData.getWelcomeMessage()["answer"]!))
        
        self.conversation.updateValue(SaveData.getWelcomeMessage()["answerId"]!, forKey: "answerId")
        self.conversation.updateValue(SaveData.getWelcomeMessage()["answer"]!, forKey: "answer")
        self.conversation.updateValue(SaveData.getWelcomeMessage()["rating"]!, forKey: "rating")
        self.conversation.updateValue("a", forKey: "qa")
        self.conversations.append(conversation)
        
        setupCacheMessages()
        
        let stringURL : String = HTTPConstants.baseURl + "api/question/GetConvo/" + SaveData.getCustomerID()!
        HTTPRequests.HTTPGetRequestData(stringURL, withSuccess: {(response,statusFlag) in
            if statusFlag{
                do{
                    let root = try JSONDecoder().decode(GetConversationRoot.self, from: response!)
                    if root.meta?.status == "Ok"{
                        self.conversations.removeAll()
                        self.messages.removeAll()
                        self.conversation.removeAll()
                        SaveData.setFreeQuestions(value: root.freeQuestions ?? 0)
                        self.conversation.updateValue(SaveData.getWelcomeMessage()["answerId"]!, forKey: "answerId")
                        self.conversation.updateValue(SaveData.getWelcomeMessage()["answer"]!, forKey: "answer")
                        self.conversation.updateValue(SaveData.getWelcomeMessage()["rating"]!, forKey: "rating")
                        self.conversation.updateValue("a", forKey: "qa")
                        let convData = ConversationData();
                        convData.deleteAllRecords()
                        self.conversations.append(self.conversation)
                        convData.saveData(id: SaveData.getWelcomeMessage()["answerId"]!, name: SaveData.getModeratorName(), qa: "a", rating: SaveData.getWelcomeMessage()["rating"]!, message: SaveData.getWelcomeMessage()["answer"]!)
                        for datas in root.data!{
                            if datas.questions == nil{
                                if datas.answer != nil{
                                    self.conversation.updateValue("\(datas.answer?.id! ?? 0)", forKey: "answerId")
                                    self.conversation.updateValue(datas.answer?.answers! ?? "a", forKey: "answer")
                                    self.conversation.updateValue("\(datas.answer?.rating! ?? 0)", forKey: "rating")
                                    self.conversation.updateValue("a", forKey: "qa")
                                    if datas.answer?.answers! == SaveData.getWelcomeMessage()["answer"]!{
                                        
                                    }
                                    else
                                    {
                                        convData.saveData(id: "\(datas.answer?.id! ?? 0)", name: SaveData.getModeratorName(), qa: "a", rating: "\(datas.answer?.rating! ?? 0)", message: datas.answer?.answers! ?? "a")
                                        self.conversations.append(self.conversation)
                                        self.conversation.removeAll()
                                    }
                                    
                                }
                            }
                            else{
                                self.conversation.updateValue(datas.customerDto ?? "", forKey: "customerDto")
                                self.conversation.updateValue(datas.questions!, forKey: "questions")
                                self.conversation.updateValue("\(datas.id!)", forKey: "id")
                                self.conversation.updateValue("\(datas.customerId!)", forKey: "customerId")
                                self.conversation.updateValue(datas.moderatorDataId ?? "", forKey: "moderatorDataId")
                                self.conversation.updateValue("q", forKey: "qa")
                                
                                convData.saveData(id: "\(datas.customerId!)", name: self.senderDisplayName, qa: "q", rating: "0", message: datas.questions!)
                                
                                self.conversations.append(self.conversation)
                                
                                if datas.answer != nil{
                                    self.conversation.updateValue("\(datas.answer?.id! ?? 0)", forKey: "answerId")
                                    self.conversation.updateValue(datas.answer?.answers! ?? "a", forKey: "answer")
                                    self.conversation.updateValue("\(datas.answer?.rating! ?? 0)", forKey: "rating")
                                    self.conversation.updateValue("a", forKey: "qa")
                                    convData.saveData(id: "\(datas.answer?.id! ?? 0)", name: SaveData.getModeratorName(), qa: "a", rating: "\(datas.answer?.rating! ?? 0)", message: datas.answer?.answers! ?? "a")
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
    func setupCacheMessages(){
        let convDatas = ConversationData()
        self.conversation.removeAll()
        self.conversations.removeAll()
        self.messages.removeAll()
        guard let datas = convDatas.getAllConversations() else {
            return
        }
        print(datas.count)
        for data in datas{
            if data.qa! == "a"{
                self.conversation.updateValue(data.id!, forKey: "answerId")
                self.conversation.updateValue(data.message!, forKey: "answer")
                self.conversation.updateValue(data.rating!, forKey: "rating")
                self.conversation.updateValue(data.name!, forKey: "name")
                self.conversation.updateValue("a", forKey: "qa")
            }
            else{
                self.conversation.updateValue(data.id!, forKey: "customerId")
                self.conversation.updateValue(data.message!, forKey: "questions")
                self.conversation.updateValue(data.rating!, forKey: "rating")
                self.conversation.updateValue(data.name!, forKey: "name")
                self.conversation.updateValue("q", forKey: "qa")
            }
            self.conversations.append(conversation)
        }
         self.setUpMessages()
    }
    func setUpMessages(){
        for conversations in self.conversations{
            if conversations["qa"] == "q"{
                self.messages.append(JSQMessage(senderId: conversations["customerId"], displayName: "Test", text: conversations["questions"]))
                self.isLastQuestion = false
                self.noOfAnswersAfterQuestions += 1
            }
            else{
                self.messages.append(JSQMessage(senderId: conversations["answerId"], displayName: "Test", text: conversations["answer"]))
                
                self.isLastQuestion = true
                self.noOfAnswersAfterQuestions = 0
            }
        }
        self.collectionView.reloadData()
         self.scrollToBottom(animated: true)
    }
    
    func sendQuestions(text: String){
        let stringURL : String = HTTPConstants.baseURl + "api/question/CreateQuestion"
        let parameters = [
            "Questions": text as AnyObject,
            "IsLatestVersion": true as AnyObject,
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

class IndexTapGesture: UITapGestureRecognizer {
    var indexPath : IndexPath?
}

//class CustomJSQMEssageCell: JSQMessagesCollectionViewCell{
//    let ratingView = CosmosView(frame: CGRect(x: 0, y: 0, width: cellBottomLabel.frame.width, height: cellBottomLabel.frame.height))
//
//    func update(_ rating: Double) {
//
//    }
//
//    override public func prepareForReuse() {
//        // Ensures the reused cosmos view is as good as new
//    }
//}
//extension String {
//    func htmlAttributedString(fontSize: CGFloat = 17.0) -> NSAttributedString? {
//        let fontName = UIFont.systemFont(ofSize: fontSize).fontName
//        let string = self.appending(String(format: "<style>body{font-family: '%@'; font-size:%fpx;}</style>", fontName, fontSize))
//        guard let data = string.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
//
//        guard let html = try? NSMutableAttributedString (
//            data: data,
//            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
//            documentAttributes: nil) else { return nil }
//        return html
//    }
//}

