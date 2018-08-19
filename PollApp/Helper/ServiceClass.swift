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
let serverPath = "http://13.232.31.142"

class ServiceClass: NSObject {
    typealias stringBlock = (_ error: Error?, _ response: String) -> Void
    typealias dictionaryBlock = (_ error: Error?, _ response: [String:Any]) -> Void
    typealias arrayBlock = (_ error: Error?, _ response: [Any]) -> Void
    typealias jsonBlock = (_ error: Error?, _ response: JSON) -> Void

    
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
    
    
    
    
    public func customSurvey(strUrl:String,param:[String:AnyObject],img : UIImage,header:String,completion:@escaping (dictionaryBlock)){
        
        let headersValue = [
            "Authorization": "Bearer \(header)",
            
        ]
        
        print(param)
        
        Alamofire.upload(multipartFormData:
            {
                (multipartFormData) in
                multipartFormData.append(UIImageJPEGRepresentation(img, 0.1)!, withName: "image", fileName: "file.jpeg", mimeType: "image/jpeg")
                for (key, value) in param
                {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
        }, to:baseURL+strUrl,headers:headersValue)
        { (result) in
            switch result {
            case .success(let upload,_,_ ):
                upload.uploadProgress(closure: { (progress) in
                    
                })
                upload.responseJSON
                    { response in
                        print(response)
                        
                        if response.result.value != nil
                        {
                            let dict :NSDictionary = response.result.value! as! [String : Any] as NSDictionary
                            completion(nil, dict as! [String : Any])
                        }
                        else{
                            let error : Error = response.result.error!
                            completion(error, [:])
                        }
                }
            case .failure(let encodingError):
                
                completion(encodingError, [:])
                break
            }
        }
    }
    
    
    
    
    
    
    
    
   
    public func sharePollInGroup(strUrl:String,param:[String:Any],header:String,completion:@escaping (stringBlock)){
        
        print(param)
        let headersValue = [
            "Authorization": "Bearer \(header)",
            
        ]
        
        
        do {
            let data = try JSONSerialization.data(withJSONObject: param, options: [])
            
            if let utf8 = String(data: data, encoding: .utf8) {
                print("JSON: \(utf8)")
                
                let json = utf8
                
                let url = URL(string: baseURL+strUrl)!
                let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
                
                var request = URLRequest(url: url)
                request.httpMethod = HTTPMethod.post.rawValue
                request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                request.allHTTPHeaderFields = headersValue
                
                Alamofire.request(request).responseJSON {
                    (response) in
                    
                    print(response)
                    
                    if response.result.isSuccess {
                        let resJson = JSON(response.result.value!)
                        
                        let dicData = resJson.dictionaryObject!
                        
                        if dicData["status"] as! Int == 200 {
                            print(dicData["data"])
                            print(dicData["userMessage"])
                            completion(nil,dicData["userMessage"] as! String)
                        }
                        else{
                            let msg = dicData["userMessage"] as! String
                            
                            let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: msg])
                            
                            completion(error as Error,"")
                        }
                        
                        
                        
                        
                    }
                    if response.result.isFailure {
                        let error : Error = response.result.error!
                        completion(error,"")
                    }
                    
                    
                    
                }
                
                
            }
        } catch {
            print(error)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    public func CreateGroup(strUrl:String,param:[String:Any],header:String,completion:@escaping (stringBlock)){
        
        print(param)
        let headersValue = [
            "Authorization": "Bearer \(header)",
            
        ]
       
        
        do {
            let data = try JSONSerialization.data(withJSONObject: param, options: [])
            
            if let utf8 = String(data: data, encoding: .utf8) {
                print("JSON: \(utf8)")
                
                let json = utf8
                
                let url = URL(string: baseURL+strUrl)!
                let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
                
                var request = URLRequest(url: url)
                request.httpMethod = HTTPMethod.post.rawValue
                request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                request.allHTTPHeaderFields = headersValue
                
                Alamofire.request(request).responseJSON {
                    (response) in
                    
                    print(response)
                    
                    if response.result.isSuccess {
                        let resJson = JSON(response.result.value!)
                        
                        let dicData = resJson.dictionaryObject!
                        
                        if dicData["status"] as! Int == 200 {
                            print(dicData["data"])
                              print(dicData["userMessage"])
                            completion(nil,dicData["userMessage"] as! String)
                        }
                        else{
                            let msg = dicData["userMessage"] as! String
                            
                            let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: msg])
                            
                            completion(error as Error,"")
                        }
                        
                        
                        
                        
                    }
                    if response.result.isFailure {
                        let error : Error = response.result.error!
                        completion(error,"")
                    }
                    
                    
                    
                }
                
                
            }
        } catch {
            print(error)
        }
        
        
        
        
        
  
   
        
        
        
        
        
        
        
//      let  value = {param}
//        print(value)
//        print(baseURL+strUrl)
//
//
//        print(headersValue)
//
//        requestPUTURL(baseURL+strUrl, params: param as [String : AnyObject], headers: headersValue , success: {
//            (JSONResponse) -> Void in
//            print(JSONResponse)
//
//            let dicData = JSONResponse.dictionaryObject!
//
//            if dicData["status"] as! Int == 200 {
//                let jsonData = JSONResponse["data"].dictionaryObject
//                completion(nil,jsonData!)
//            }
//            else{
//                let msg = dicData["userMessage"] as! String
//
//                let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: msg])
//
//                completion(error as Error,[:])
//            }
//
//
//
//
//
//        }) {
//            (error) -> Void in
//
//            completion(error,[:])
//
//        }
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
    
    
    
    public func socialLogin(strUrl:String,param:[String:Any],header:String,completion:@escaping (dictionaryBlock)){
        
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
             
                //let msg = dicData["userMessage"] as! String
               
                
                
                completion(nil,dicData["data"] as! [String : Any])
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
                
                print(resJson["data"].array!)
                
                
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
    
    
    public func groupDataSurvay(strUrl:String,header:String,completion:@escaping (arrayBlock)){
        
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
                    let dicSubData = resJson["data"]
                    
                    for rootDic in dicSubData["surveys"].array!{
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
    
    
    
    
    
    
    public func getGroupData(strUrl:String,header:String,completion:@escaping (arrayBlock)){
        
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
                    print(resJson["data"].array!)
                    for rootDic in resJson["data"].array!{
                        let obj = GroupMember(fromJson: rootDic)
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
    
    

    
    public func getSurvayId(strUrl:String,param:[String:Any],header:String,completion:@escaping (jsonBlock)){
        
        print(param)
        print(baseURL+strUrl)
        
        let headersValue: HTTPHeaders = [
            "Authorization": "Bearer \(header)",
            
        ]
        
        Alamofire.request(baseURL+strUrl, headers: headersValue).responseJSON { response in
            debugPrint(response)
            
            if response.result.isSuccess {
                let resJson = JSON(response.result.value!)
                print(resJson)
                let dicData = resJson.dictionaryObject!
                
                if dicData["status"] as! Int == 200 {
                   
                    completion(nil,resJson)
                }
                else{
                    let msg = dicData["userMessage"] as! String
                    
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: msg])
                    
                    completion(error as Error,[:])
                }
                
                
                
                
            }
            if response.result.isFailure {
                let error : Error = response.result.error!
                completion(error,[:])
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
