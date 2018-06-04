//
//  ServiceClass.swift
//  IndusBus
//
//  Created by Opiant on 29/01/18.
//  Copyright © 2018 Opiant. All rights reserved.
// http://indusbus.opiant.online/api/osrtc/getavailableservices

import Foundation
import Alamofire
import SwiftyJSON


let baseURL = "http://13.232.31.142/api/"

class ServiceClass: NSObject {
    
    typealias dictionaryBlock = (_ error: Error?, _ response: [String:Any]) -> Void
    typealias arrayBlock = (_ error: Error?, _ response: [Any]) -> Void
    

    
    var headers: [String: String] = [:]
    var body: String?
    var elapsedTime: TimeInterval?
    var arrIteam : Array<Any> = []
    
    
    var request: Alamofire.Request? {
        didSet {
            oldValue?.cancel()
            headers.removeAll()
            body = nil
            elapsedTime = nil
            
        }
    }
    
    
    
    
    
    public func postAnsForQue(strUrl:String,param:[String:Any],header:String,completion:@escaping (arrayBlock)){
        
        print(param)
        
        print(param)
        print(baseURL+strUrl)
        
        let headersValue: HTTPHeaders = [
            "Authorization": "Bearer \(header)",
            
        ]
        
        requestPOSTURL(baseURL+strUrl, params: param as [String : AnyObject], headers: headersValue, success: {
            (JSONResponse) -> Void in
            print(JSONResponse)
            
            
            let dicData = JSONResponse.dictionaryObject!
            
            if dicData["status"] as! Int == 200 {
                for rootDic in JSONResponse["data"]["questions"].array!{
                    
                 
                        let obj = Question(fromJson: rootDic)
                        self.arrIteam.append(obj)
                    
                   
                    print(rootDic)
                    
                }
                let msg = dicData["userMessage"] as! String
                self.arrIteam.insert(msg, at: 1)
                
                
                completion(nil,self.arrIteam)
            }
            
            else{
                let msg = dicData["userMessage"] as! String
                
                let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: msg])
                
                completion(error as Error,[])
            }
            
            
           
            
            
            
        }) {
            (error) -> Void in
            
            completion(error,[])
            
        }
    }
    
    
    
    public func getProfileEventDetails(strUrl:String,param:[String:Any],header:String,completion:@escaping (dictionaryBlock)){
        
        print(param)
        
        
        print(baseURL+strUrl)
        
        let headersValue = [
            "Authorization": "Bearer \(header)",
            
        ]
        print(headersValue)
        
        requestPUTURL(baseURL+strUrl, params: param as [String : AnyObject], headers: headersValue , success: {
            (JSONResponse) -> Void in
            print(JSONResponse)
            
             let dicData = JSONResponse.dictionaryObject!
            
            if dicData["status"] as! Int == 200 {
               let jsonData = JSONResponse["data"].dictionaryObject
                completion(nil,jsonData!)
            }
            else{
                let msg = dicData["userMessage"] as! String
                
                let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: msg])
                
                completion(error as Error,[:])
            }
            
            
            
            
            
        }) {
            (error) -> Void in
            
            completion(error,[:])
            
        }
    }
    
    
    
    
    
    
    
    public func getLoginDetails(strUrl:String,param:[String:Any],completion:@escaping (dictionaryBlock)){
        
        print(param)
        
        requestPOSTURL(baseURL+strUrl, params: param as [String : AnyObject], headers: nil, success: {
            (JSONResponse) -> Void in
            print(JSONResponse)
            
            
           
        
            
            
            completion(nil,JSONResponse.dictionaryObject!)
            
            
            
        }) {
            (error) -> Void in
            
            completion(error,[:])
            
        }
    }
    
    
    
    public func otpVerification(strUrl:String,param:[String:Any],completion:@escaping (dictionaryBlock)){
        
        print(param)
        
        
        let headersValue: HTTPHeaders = [
            "": "",
            
        ]
        
        requestPUTURL(baseURL+strUrl, params: param as [String : AnyObject], headers: headersValue, success: {
            (JSONResponse) -> Void in
            print(JSONResponse)
            
            
            
            
            
            
            completion(nil,JSONResponse.dictionaryObject!)
            
            
            
        }) {
            (error) -> Void in
            
            completion(error,[:])
            
        }
    }
    
    
    
    public func getContact(strUrl:String,param:[String:Any],header:String,completion:@escaping (arrayBlock)){
        
        print(param)
        print(baseURL+strUrl)
        
        let headersValue: HTTPHeaders = [
            "Authorization": "Bearer \(header)",
            
        ]
        
        Alamofire.request(baseURL+strUrl, headers: headersValue).responseJSON { response in
            debugPrint(response)
            
            if response.result.isSuccess {
                let resJson = JSON(response.result.value!)
                
                let dicData = resJson.dictionaryObject!
                
                if dicData["status"] as! Int == 200 {
                    for rootDic in resJson["data"].array!{
                        let obj = ContactList(fromJson: rootDic)
                        self.arrIteam.append(obj)
                    }
                    completion(nil,self.arrIteam)
                }
                else{
                    let msg = dicData["userMessage"] as! String
                    
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: msg])
                    
                    completion(error as Error,[])
                }
                
                
                
                
            }
            if response.result.isFailure {
                let error : Error = response.result.error!
                completion(error,[])
            }
            
            
        }


    }
    
    
    
    
    
    public func ContactsSend(strUrl:String,param:[String:Any],header:String,completion:@escaping (dictionaryBlock)){
        
        print(param)
        print(baseURL+strUrl)
        
        let headersValue: HTTPHeaders = [
            "Authorization": "Bearer \(header)",
            
        ]
        
        requestPOSTURL(baseURL+strUrl, params: param as [String : AnyObject], headers: headersValue, success: {
            (JSONResponse) -> Void in
            print(JSONResponse)
            
            
            
            
            
            
            completion(nil,JSONResponse.dictionaryObject!)
            
            
            
        }) {
            (error) -> Void in
            
            completion(error,[:])
            
        }
    }
    
    
    
    
    public func homeScreenData(strUrl:String,header:String,completion:@escaping (arrayBlock)){
        
        let headersValue: HTTPHeaders = [
            "Authorization": "Bearer \(header)",
            
        ]
        
        print("~~~~~~~~~~~~~~~~~~~~~~\(headersValue)~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        
        
        
      
        
     
        
        Alamofire.request(baseURL+strUrl, headers: headersValue).responseJSON { response in
            debugPrint(response)
            
            if response.result.isSuccess {
                let resJson = JSON(response.result.value!)
                
                let dicData = resJson.dictionaryObject!
                
                if dicData["status"] as! Int == 200 {
                    for rootDic in resJson["data"].array!{
                        let obj = HomeScreenData(fromJson: rootDic)
                       self.arrIteam.append(obj)
                    }
                    completion(nil,self.arrIteam)
                }
                else{
                    let msg = dicData["userMessage"] as! String
                    
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: msg])
                    
                    completion(error as Error,[])
                }
        
                
                
                
            }
            if response.result.isFailure {
                let error : Error = response.result.error!
                completion(error,[])
            }
            
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    

    
    

    

    


    private func requestPUTURL(_ strURL : String, params : [String : AnyObject]?, headers :[String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        
        print(headers ?? "")
        Alamofire.request(strURL, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    
    
    
    
    private  func requestGETURL(_ strURL : String, params : [String : AnyObject]?, headers : HTTPHeaders, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    
    private func requestPOSTURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
}
