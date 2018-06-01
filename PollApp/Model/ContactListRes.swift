//
//	RootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class RootClass : NSObject, NSCoding{

	var data : [ContactList]!
	var error : Bool!
	var errors : AnyObject!
	var status : Int!
	var userMessage : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		data = [ContactList]()
		let dataArray = json["data"].arrayValue
		for dataJson in dataArray{
			let value = ContactList(fromJson: dataJson)
			data.append(value)
		}
		error = json["error"].boolValue
        errors = json["errors"].stringValue as AnyObject
		status = json["status"].intValue
		userMessage = json["userMessage"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if data != nil{
			var dictionaryElements = [[String:Any]]()
			for dataElement in data {
				dictionaryElements.append(dataElement.toDictionary())
			}
			dictionary["data"] = dictionaryElements
		}
		if error != nil{
			dictionary["error"] = error
		}
		if errors != nil{
			dictionary["errors"] = errors
		}
		if status != nil{
			dictionary["status"] = status
		}
		if userMessage != nil{
			dictionary["userMessage"] = userMessage
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         data = aDecoder.decodeObject(forKey: "data") as? [ContactList]
         error = aDecoder.decodeObject(forKey: "error") as? Bool
         errors = aDecoder.decodeObject(forKey: "errors") as? AnyObject
         status = aDecoder.decodeObject(forKey: "status") as? Int
         userMessage = aDecoder.decodeObject(forKey: "userMessage") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if data != nil{
			aCoder.encode(data, forKey: "data")
		}
		if error != nil{
			aCoder.encode(error, forKey: "error")
		}
		if errors != nil{
			aCoder.encode(errors, forKey: "errors")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if userMessage != nil{
			aCoder.encode(userMessage, forKey: "userMessage")
		}

	}

}
