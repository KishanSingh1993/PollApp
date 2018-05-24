//
//	Option.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Option : NSObject, NSCoding{

	var count : Int!
	var option : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		count = json["count"].intValue
		option = json["option"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if count != nil{
			dictionary["count"] = count
		}
		if option != nil{
			dictionary["option"] = option
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         count = aDecoder.decodeObject(forKey: "count") as? Int
         option = aDecoder.decodeObject(forKey: "option") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if count != nil{
			aCoder.encode(count, forKey: "count")
		}
		if option != nil{
			aCoder.encode(option, forKey: "option")
		}

	}

}
