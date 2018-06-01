//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class ContactList : NSObject, NSCoding{

	var v : Int!
	var id : String!
	var contactId : AnyObject!
	var createdAt : String!
	var mobileNumber : String!
	var name : String!
	var registered : Int!
	var uniqueId : String!
	var userId : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		v = json["__v"].intValue
		id = json["_id"].stringValue
        contactId = json["contactId"].stringValue as AnyObject
		createdAt = json["createdAt"].stringValue
		mobileNumber = json["mobileNumber"].stringValue
		name = json["name"].stringValue
		registered = json["registered"].intValue
		uniqueId = json["uniqueId"].stringValue
		userId = json["userId"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if v != nil{
			dictionary["__v"] = v
		}
		if id != nil{
			dictionary["_id"] = id
		}
		if contactId != nil{
			dictionary["contactId"] = contactId
		}
		if createdAt != nil{
			dictionary["createdAt"] = createdAt
		}
		if mobileNumber != nil{
			dictionary["mobileNumber"] = mobileNumber
		}
		if name != nil{
			dictionary["name"] = name
		}
		if registered != nil{
			dictionary["registered"] = registered
		}
		if uniqueId != nil{
			dictionary["uniqueId"] = uniqueId
		}
		if userId != nil{
			dictionary["userId"] = userId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         v = aDecoder.decodeObject(forKey: "__v") as? Int
         id = aDecoder.decodeObject(forKey: "_id") as? String
         contactId = aDecoder.decodeObject(forKey: "contactId") as? AnyObject
         createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
         mobileNumber = aDecoder.decodeObject(forKey: "mobileNumber") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         registered = aDecoder.decodeObject(forKey: "registered") as? Int
         uniqueId = aDecoder.decodeObject(forKey: "uniqueId") as? String
         userId = aDecoder.decodeObject(forKey: "userId") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if v != nil{
			aCoder.encode(v, forKey: "__v")
		}
		if id != nil{
			aCoder.encode(id, forKey: "_id")
		}
		if contactId != nil{
			aCoder.encode(contactId, forKey: "contactId")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "createdAt")
		}
		if mobileNumber != nil{
			aCoder.encode(mobileNumber, forKey: "mobileNumber")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if registered != nil{
			aCoder.encode(registered, forKey: "registered")
		}
		if uniqueId != nil{
			aCoder.encode(uniqueId, forKey: "uniqueId")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "userId")
		}

	}

}
