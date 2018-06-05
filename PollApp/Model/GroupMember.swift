//
//	GroupMember.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class GroupMember : NSObject, NSCoding{

	var v : Int!
	var id : String!
	var createdAt : String!
	var members : [Member]!
	var name : String!
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
		createdAt = json["createdAt"].stringValue
		members = [Member]()
		let membersArray = json["members"].arrayValue
		for membersJson in membersArray{
			let value = Member(fromJson: membersJson)
			members.append(value)
		}
		name = json["name"].stringValue
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
		if createdAt != nil{
			dictionary["createdAt"] = createdAt
		}
		if members != nil{
			var dictionaryElements = [[String:Any]]()
			for membersElement in members {
				dictionaryElements.append(membersElement.toDictionary())
			}
			dictionary["members"] = dictionaryElements
		}
		if name != nil{
			dictionary["name"] = name
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
         createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
         members = aDecoder.decodeObject(forKey: "members") as? [Member]
         name = aDecoder.decodeObject(forKey: "name") as? String
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
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "createdAt")
		}
		if members != nil{
			aCoder.encode(members, forKey: "members")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "userId")
		}

	}

}
