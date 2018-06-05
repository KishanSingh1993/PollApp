//
//	Member.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Member : NSObject, NSCoding{

	var v : Int!
	var id : String!
	var avatar : String!
	var country : String!
	var createdAt : String!
	var deviceId : String!
	var email : String!
	var gender : String!
	var mobileNumber : String!
	var name : String!
	var otp : String!
	var password : String!
	var profile : Profile!
	var profileSetup : Bool!
	var profileType : Int!
	var pushToken : String!
	var source : String!
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
		avatar = json["avatar"].stringValue
		country = json["country"].stringValue
		createdAt = json["createdAt"].stringValue
		deviceId = json["deviceId"].stringValue
		email = json["email"].stringValue
		gender = json["gender"].stringValue
		mobileNumber = json["mobileNumber"].stringValue
		name = json["name"].stringValue
		otp = json["otp"].stringValue
		password = json["password"].stringValue
		let profileJson = json["profile"]
		if !profileJson.isEmpty{
			profile = Profile(fromJson: profileJson)
		}
		profileSetup = json["profileSetup"].boolValue
		profileType = json["profileType"].intValue
		pushToken = json["pushToken"].stringValue
		source = json["source"].stringValue
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
		if avatar != nil{
			dictionary["avatar"] = avatar
		}
		if country != nil{
			dictionary["country"] = country
		}
		if createdAt != nil{
			dictionary["createdAt"] = createdAt
		}
		if deviceId != nil{
			dictionary["deviceId"] = deviceId
		}
		if email != nil{
			dictionary["email"] = email
		}
		if gender != nil{
			dictionary["gender"] = gender
		}
		if mobileNumber != nil{
			dictionary["mobileNumber"] = mobileNumber
		}
		if name != nil{
			dictionary["name"] = name
		}
		if otp != nil{
			dictionary["otp"] = otp
		}
		if password != nil{
			dictionary["password"] = password
		}
		if profile != nil{
			dictionary["profile"] = profile.toDictionary()
		}
		if profileSetup != nil{
			dictionary["profileSetup"] = profileSetup
		}
		if profileType != nil{
			dictionary["profileType"] = profileType
		}
		if pushToken != nil{
			dictionary["pushToken"] = pushToken
		}
		if source != nil{
			dictionary["source"] = source
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
         avatar = aDecoder.decodeObject(forKey: "avatar") as? String
         country = aDecoder.decodeObject(forKey: "country") as? String
         createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
         deviceId = aDecoder.decodeObject(forKey: "deviceId") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         gender = aDecoder.decodeObject(forKey: "gender") as? String
         mobileNumber = aDecoder.decodeObject(forKey: "mobileNumber") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         otp = aDecoder.decodeObject(forKey: "otp") as? String
         password = aDecoder.decodeObject(forKey: "password") as? String
         profile = aDecoder.decodeObject(forKey: "profile") as? Profile
         profileSetup = aDecoder.decodeObject(forKey: "profileSetup") as? Bool
         profileType = aDecoder.decodeObject(forKey: "profileType") as? Int
         pushToken = aDecoder.decodeObject(forKey: "pushToken") as? String
         source = aDecoder.decodeObject(forKey: "source") as? String
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
		if avatar != nil{
			aCoder.encode(avatar, forKey: "avatar")
		}
		if country != nil{
			aCoder.encode(country, forKey: "country")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "createdAt")
		}
		if deviceId != nil{
			aCoder.encode(deviceId, forKey: "deviceId")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if gender != nil{
			aCoder.encode(gender, forKey: "gender")
		}
		if mobileNumber != nil{
			aCoder.encode(mobileNumber, forKey: "mobileNumber")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if otp != nil{
			aCoder.encode(otp, forKey: "otp")
		}
		if password != nil{
			aCoder.encode(password, forKey: "password")
		}
		if profile != nil{
			aCoder.encode(profile, forKey: "profile")
		}
		if profileSetup != nil{
			aCoder.encode(profileSetup, forKey: "profileSetup")
		}
		if profileType != nil{
			aCoder.encode(profileType, forKey: "profileType")
		}
		if pushToken != nil{
			aCoder.encode(pushToken, forKey: "pushToken")
		}
		if source != nil{
			aCoder.encode(source, forKey: "source")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "userId")
		}

	}

}
