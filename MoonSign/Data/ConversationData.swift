//
//  ConversationData.swift
//  MoonSign
//
//  Created by Mac on 12/5/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class ConversationData{
    var appDelegate: AppDelegate?
    init(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
    }
    
    public func saveData(id: String, name: String, qa: String, rating: String,message: String){
        //deleteAllRecords()
        let context = appDelegate?.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Conversation", in: context!)
        let conversation = NSManagedObject(entity: entity!, insertInto: context)
        conversation.setValue(id, forKey: "id")
        conversation.setValue(name, forKey: "name")
        conversation.setValue(qa, forKey: "qa")
        conversation.setValue(rating, forKey: "rating")
        conversation.setValue(message, forKey: "message")
        do {
            try context?.save()
        } catch {
            print("Failed saving")
        }
    }
    public func getAllConversations()-> [Conversation]?{
        
        let context = appDelegate?.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Conversation")
        fetchRequest.returnsObjectsAsFaults = false
        do{
            let conversation = try context!.fetch(fetchRequest) as! [Conversation]
            return conversation
        }catch{
            return nil
        }
        
    }
    public func deleteAllRecords()
    {
        
        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Conversation")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch
        {
            print ("There was an error")
        }
    }
    
    
}
