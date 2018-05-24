//
//	Question.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Question : NSObject, NSCoding{

	var id : String!
	var options : [Option]!
	var question : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		id = json["_id"].stringValue
		options = [Option]()
		let optionsArray = json["options"].arrayValue
		for optionsJson in optionsArray{
			let value = Option(fromJson: optionsJson)
			options.append(value)
		}
		question = json["question"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if id != nil{
			dictionary["_id"] = id
		}
		if options != nil{
			var dictionaryElements = [[String:Any]]()
			for optionsElement in options {
				dictionaryElements.append(optionsElement.toDictionary())
			}
			dictionary["options"] = dictionaryElements
		}
		if question != nil{
			dictionary["question"] = question
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         options = aDecoder.decodeObject(forKey: "options") as? [Option]
         question = aDecoder.decodeObject(forKey: "question") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "_id")
		}
		if options != nil{
			aCoder.encode(options, forKey: "options")
		}
		if question != nil{
			aCoder.encode(question, forKey: "question")
		}

	}

}
