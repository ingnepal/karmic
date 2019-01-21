//
//  UserDetailsData.swift
//  MoonSign
//
//  Created by utsavstha on 12/8/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit
import CoreData
class UserDetailsData {
    var appDelegate: AppDelegate?
    init(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
    }
    
    public func saveUserData(cityAndState: String, country: String, dob: String,
                             fullName: String, gender: String, isTermsAgreed: Bool,
                             isTimeAccurate: Bool, photoUrl: String, timeOfBirth: String){
        deleteAllRecords()
        let context = appDelegate?.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Profile", in: context!)
        let conversation = NSManagedObject(entity: entity!, insertInto: context)
        conversation.setValue(cityAndState, forKey: "cityAndState")
        conversation.setValue(country, forKey: "country")
        conversation.setValue(dob, forKey: "dateOfBirth")
        conversation.setValue(fullName, forKey: "fullName")
        conversation.setValue(isTermsAgreed, forKey: "isTermsAgreed")
        conversation.setValue(isTimeAccurate, forKey: "isTimeAccurate")
        conversation.setValue(photoUrl, forKey: "photoUrl")
        conversation.setValue(timeOfBirth, forKey: "timeOfBirth")
        conversation.setValue(gender, forKey: "gender")

        

        do {
            try context?.save()
        } catch {
            print("Failed saving")
        }
    }
    public func getUserDetails()-> [Profile]?{
        
        let context = appDelegate?.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        fetchRequest.returnsObjectsAsFaults = false
        do{
            let conversation = try context!.fetch(fetchRequest) as! [Profile]
            return conversation
        }catch{
            return nil
        }
        
    }
    public func deleteAllRecords()
    {
        
        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
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
