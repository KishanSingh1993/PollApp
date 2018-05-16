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
        
        requestPUTURL(baseURL+strUrl, params: param as [String : AnyObject], headers: nil, success: {
            (JSONResponse) -> Void in
            print(JSONResponse)
            
            
            
            
            
            
            completion(nil,JSONResponse.dictionaryObject!)
            
            
            
        }) {
            (error) -> Void in
            
            completion(error,[:])
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    public func getDataForSearchCity(strUrl:String,prama:[String:String],completion: @escaping (arrayBlock)){
      
        
        requestGETURL(baseURL+strUrl, params: nil, headers: nil, success: {
                    (JSONResponse) -> Void in
                    print(JSONResponse)
  
   
//
//            for rootdic  in JSONResponse.arrayObject! {
//                if let obj = rootdic as? [String: Any] {
//                   // let object = PlaceObject(JSON: obj)
//                  //  self.arrIteam.append(object)
//                }
//
//            }
//
          
            completion(nil,self.arrIteam)
           
     
            
            }){
            (error) -> Void in
                
                completion(error,[])
                       
        }
        
        //            for responseDic  in    JSONResponse["wsResponse"]{
        //                print(responseDic)
        //                if "0" == (responseDic.0){
        //                    for rootdic  in JSONResponse.dictionaryObject! {
        //                        print(rootdic)
        //                        if rootdic is [String: Any] {
        //
        //                              print(rootdic)
        //
        //                        }
        //
        //                    }
        //
        //
        //
        //                completion(nil,self.arrIteam)
        //            }
        //
        //
        //            }
        //

       
        
        
    }
    
    
    

    

    


    private func requestPUTURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
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
    
    
    
    
    
    private  func requestGETURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
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
