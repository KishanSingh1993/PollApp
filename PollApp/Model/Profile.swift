//
//	Profile.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Profile : NSObject, NSCoding{

	var companyAddress : String!
	var companyContactPerson : String!
	var companyEmailAddress : String!
	var companyName : String!
	var companyPhoneNumber : String!
	var companyWebsite : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		companyAddress = json["company_address"].stringValue
		companyContactPerson = json["company_contact_person"].stringValue
		companyEmailAddress = json["company_email_address"].stringValue
		companyName = json["company_name"].stringValue
		companyPhoneNumber = json["company_phone_number"].stringValue
		companyWebsite = json["company_website"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if companyAddress != nil{
			dictionary["company_address"] = companyAddress
		}
		if companyContactPerson != nil{
			dictionary["company_contact_person"] = companyContactPerson
		}
		if companyEmailAddress != nil{
			dictionary["company_email_address"] = companyEmailAddress
		}
		if companyName != nil{
			dictionary["company_name"] = companyName
		}
		if companyPhoneNumber != nil{
			dictionary["company_phone_number"] = companyPhoneNumber
		}
		if companyWebsite != nil{
			dictionary["company_website"] = companyWebsite
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         companyAddress = aDecoder.decodeObject(forKey: "company_address") as? String
         companyContactPerson = aDecoder.decodeObject(forKey: "company_contact_person") as? String
         companyEmailAddress = aDecoder.decodeObject(forKey: "company_email_address") as? String
         companyName = aDecoder.decodeObject(forKey: "company_name") as? String
         companyPhoneNumber = aDecoder.decodeObject(forKey: "company_phone_number") as? String
         companyWebsite = aDecoder.decodeObject(forKey: "company_website") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if companyAddress != nil{
			aCoder.encode(companyAddress, forKey: "company_address")
		}
		if companyContactPerson != nil{
			aCoder.encode(companyContactPerson, forKey: "company_contact_person")
		}
		if companyEmailAddress != nil{
			aCoder.encode(companyEmailAddress, forKey: "company_email_address")
		}
		if companyName != nil{
			aCoder.encode(companyName, forKey: "company_name")
		}
		if companyPhoneNumber != nil{
			aCoder.encode(companyPhoneNumber, forKey: "company_phone_number")
		}
		if companyWebsite != nil{
			aCoder.encode(companyWebsite, forKey: "company_website")
		}

	}

}
