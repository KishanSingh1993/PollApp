//
//	HomeScreenData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class HomeScreenData : NSObject, NSCoding{

    var v : Int!
    var id : String!
    var attemptedCount : Int!
    var createdAt : String!
    var expireAt : String!
    var name : String!
    var questions : [Question]!
    var selfSurvey : SelfSurvey!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        v = json["__v"].intValue
        id = json["_id"].stringValue
        attemptedCount = json["attemptedCount"].intValue
        createdAt = json["createdAt"].stringValue
        expireAt = json["expireAt"].stringValue
        name = json["name"].stringValue
        questions = [Question]()
        let questionsArray = json["questions"].arrayValue
        for questionsJson in questionsArray{
            let value = Question(fromJson: questionsJson)
            questions.append(value)
        }
        let selfSurveyJson = json["selfSurvey"]
        if !selfSurveyJson.isEmpty{
            selfSurvey = SelfSurvey(fromJson: selfSurveyJson)
        }
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
        if attemptedCount != nil{
            dictionary["attemptedCount"] = attemptedCount
        }
        if createdAt != nil{
            dictionary["createdAt"] = createdAt
        }
        if expireAt != nil{
            dictionary["expireAt"] = expireAt
        }
        if name != nil{
            dictionary["name"] = name
        }
        if questions != nil{
            var dictionaryElements = [[String:Any]]()
            for questionsElement in questions {
                dictionaryElements.append(questionsElement.toDictionary())
            }
            dictionary["questions"] = dictionaryElements
        }
        if selfSurvey != nil{
            dictionary["selfSurvey"] = selfSurvey.toDictionary()
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
        attemptedCount = aDecoder.decodeObject(forKey: "attemptedCount") as? Int
        createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
        expireAt = aDecoder.decodeObject(forKey: "expireAt") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        questions = aDecoder.decodeObject(forKey: "questions") as? [Question]
        selfSurvey = aDecoder.decodeObject(forKey: "selfSurvey") as? SelfSurvey
        
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
        if attemptedCount != nil{
            aCoder.encode(attemptedCount, forKey: "attemptedCount")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "createdAt")
        }
        if expireAt != nil{
            aCoder.encode(expireAt, forKey: "expireAt")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if questions != nil{
            aCoder.encode(questions, forKey: "questions")
        }
        if selfSurvey != nil{
            aCoder.encode(selfSurvey, forKey: "selfSurvey")
        }
        
    }


}
