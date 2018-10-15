//
//  HTTPRequests.swift
//  Prabhu Pay
//
//  Created by QPay on 6/4/18.
//  Copyright © 2018 Qpay. All rights reserved.
//

import Foundation
import Alamofire



class HTTPRequests {
    
    //MARK:-  HTTPGetRequest
    
    /**************************************   Get Request ********************************/
    
    class func HTTPGetRequest (_ urlString:String, withSuccess:@escaping (NSDictionary?,Bool)->()) {
        /*
         Alamofire.request(urlString).response { response in // method defaults to `.get`
         debugPrint(response)
         }*/
        
        print("urlString  =",urlString)
        
        Alamofire.request(urlString).responseJSON { response in
            /*
             print(response.request)  // original URL request
             print(response.response) // HTTP URL response
             print(response.data)     // server data
             print(response.result)   // result of response serialization
             */
            
            //debugPrint(response)
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                withSuccess(JSON as? NSDictionary , true)
            }else{
                debugPrint(response)
                withSuccess(nil , false)
                
            }
            
            
        }
        
        
    }
    
    class func HTTPGetRequestData (_ urlString:String, withSuccess:@escaping (Data?,Bool)->()) {
        /*
         Alamofire.request(urlString).response { response in // method defaults to `.get`
         debugPrint(response)
         }*/
        
        print("urlString  =",urlString)
        Utility.ShowSVProgressHUD_White_With_IgnoringInteraction()
        Alamofire.request(urlString).responseJSON { response in
            /*
             print(response.request)  // original URL request
             print(response.response) // HTTP URL response
             print(response.data)     // server data
             print(response.result)   // result of response serialization
             */
            
            //debugPrint(response)
            Utility.DismissSVProgressHUD_With_endIgnoringInteraction()
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                withSuccess(response.data , true)
            }else{
                debugPrint(response)
                withSuccess(nil , false)
                
            }
            
            
        }
        
        
    }
    
    
    
    //MARK:-  HTTPGetRequest WITH PARAM
    
    
    
    /**************************************   GET Request ********************************/
    
    class func HTTPGetRequestParam (_ urlString:String, parameters:[String : AnyObject], withSuccess:@escaping (NSDictionary?,Bool)->()) {
        
        print("urlString  =",urlString)
        print("parameters  =",parameters)
        
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                // print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                // debugPrint(response)
                //withSuccess(nil , false)
                return .success
            }
            .responseJSON { response in
                
                /*
                 print(response.request)  // original URL request
                 print(response.response) // HTTP URL response
                 print(response.data)     // server data
                 print(response.result)   // result of response serialization
                 */
                //debugPrint(response)
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    withSuccess(JSON as? NSDictionary , true)
                }else{
                    debugPrint(response)
                    withSuccess(nil , false)
                }
                
                
        }
        
    }
    
    
    
    
    
    //MARK:-  HTTPPostRequest
    
    
    
    /**************************************   Post Request ********************************/
    
    class func HTTPPostRequest (_ urlString:String, parameters:[String : AnyObject], withSuccess:@escaping (NSDictionary?,Bool)->(), showLoading:Bool = true) {
       
        print("urlString  =",urlString)
        print("parameters  =",parameters)
        if showLoading {
            Utility.ShowSVProgressHUD_White_With_IgnoringInteraction()
        }
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                // print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                if showLoading {
                    Utility.DismissSVProgressHUD_With_endIgnoringInteraction()
                }
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    withSuccess(JSON as? NSDictionary , true)
                }else{
                    debugPrint(response)
                    withSuccess(nil , false)
                    
                }
                
                
        }
        
    }
    
    class func HTTPPostRequestNoLoading (_ urlString:String, parameters:[String : AnyObject], withSuccess:@escaping (NSDictionary?,Bool)->()) {
        
        print("urlString  =",urlString)
        print("parameters  =",parameters)

        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                // print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    withSuccess(JSON as? NSDictionary , true)
                }else{
                    debugPrint(response)
                    withSuccess(nil , false)
                    
                }
                
                
        }
        
    }
    class func HTTPPostRequestData (_ urlString:String, parameters:[String : AnyObject], withSuccess:@escaping (Data?,Bool)->(), showLoading:Bool = true) {
        
        print("urlString  =",urlString)
        print("parameters  =",parameters)
        if showLoading {
            Utility.ShowSVProgressHUD_White_With_IgnoringInteraction()
        }
        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                // print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                if showLoading {
                    Utility.DismissSVProgressHUD_With_endIgnoringInteraction()
                }
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    withSuccess(response.data , true)
                }else{
                    debugPrint(response)
                    withSuccess(nil , false)
                    
                }
                
                
        }
        
    }
    class func HTTPPutRequestData (_ urlString:String, parameters:[String : AnyObject], withSuccess:@escaping (Data?,Bool)->(), showLoading:Bool = true) {
        
        print("urlString  =",urlString)
        print("parameters  =",parameters)
        if showLoading {
            Utility.ShowSVProgressHUD_White_With_IgnoringInteraction()
        }
        Alamofire.request(urlString, method: .put, parameters: parameters, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                // print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                if showLoading {
                    Utility.DismissSVProgressHUD_With_endIgnoringInteraction()
                }
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    withSuccess(response.data , true)
                }else{
                    debugPrint(response)
                    withSuccess(nil , false)
                    
                }
                
                
        }
        
    }
    
//    class func DownloadFile(parameters:[String : AnyObject]){
//        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
//        Utility.ShowSVProgressHUD_White_With_IgnoringInteraction()
//
//        Alamofire.download(
//            HTTPConstants.TICKET_DOWNLOAD,
//            method: .get,
//            parameters: parameters,
//            encoding: JSONEncoding.default,
//            headers: nil,
//            to: destination).downloadProgress(closure: { (progress) in
//                print(progress)
//            }).response(completionHandler: { (DefaultDownloadResponse) in
//                Utility.DismissSVProgressHUD_With_endIgnoringInteraction()
//            })
//    }
    
    
    
    
    
    //    class func HTTPPostRequestData (_ stringURL:String, parameters:[String : AnyObject], withSuccess:@escaping (NSDictionary?,Bool)->()) {
    //
    //
    //
    //    }
}
