//
//	RootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class RootClass : NSObject, NSCoding{

	var v : Int!
	var id : String!
	var questions : [Question]!
	var startedAt : String!
	var submittedAt : String!
	var surveyId : String!
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
		questions = [Question]()
		let questionsArray = json["questions"].arrayValue
		for questionsJson in questionsArray{
			let value = Question(fromJson: questionsJson)
			questions.append(value)
		}
		startedAt = json["startedAt"].stringValue
		submittedAt = json["submittedAt"].stringValue
		surveyId = json["surveyId"].stringValue
		userId = json["userId"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		let dictionary = [String:Any]()
		if v != nil{
			dictionary["__v"] = v
		}
		if id != nil{
			dictionary["_id"] = id
		}
		if questions != nil{
			var dictionaryElements = [[String:Any]]()
			for questionsElement in questions {
				dictionaryElements.append(questionsElement.toDictionary())
			}
			dictionary["questions"] = dictionaryElements
		}
		if startedAt != nil{
			dictionary["startedAt"] = startedAt
		}
		if submittedAt != nil{
			dictionary["submittedAt"] = submittedAt
		}
		if surveyId != nil{
			dictionary["surveyId"] = surveyId
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
         questions = aDecoder.decodeObject(forKey: "questions") as? [Question]
         startedAt = aDecoder.decodeObject(forKey: "startedAt") as? String
         submittedAt = aDecoder.decodeObject(forKey: "submittedAt") as? String
         surveyId = aDecoder.decodeObject(forKey: "surveyId") as? String
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
		if questions != nil{
			aCoder.encode(questions, forKey: "questions")
		}
		if startedAt != nil{
			aCoder.encode(startedAt, forKey: "startedAt")
		}
		if submittedAt != nil{
			aCoder.encode(submittedAt, forKey: "submittedAt")
		}
		if surveyId != nil{
			aCoder.encode(surveyId, forKey: "surveyId")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "userId")
		}

	}

}