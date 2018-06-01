//
//	Question.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class QuestionselfSurvey : NSObject, NSCoding{

	var id : String!
	var givenAnswer : String!
	var questionId : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		id = json["_id"].stringValue
		givenAnswer = json["givenAnswer"].stringValue
		questionId = json["questionId"].stringValue
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
		if givenAnswer != nil{
			dictionary["givenAnswer"] = givenAnswer
		}
		if questionId != nil{
			dictionary["questionId"] = questionId
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
         givenAnswer = aDecoder.decodeObject(forKey: "givenAnswer") as? String
         questionId = aDecoder.decodeObject(forKey: "questionId") as? String

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
		if givenAnswer != nil{
			aCoder.encode(givenAnswer, forKey: "givenAnswer")
		}
		if questionId != nil{
			aCoder.encode(questionId, forKey: "questionId")
		}

	}

}
