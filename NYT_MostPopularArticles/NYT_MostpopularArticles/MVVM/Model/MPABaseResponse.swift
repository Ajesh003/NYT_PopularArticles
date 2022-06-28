

import Foundation
 
public class MPABaseResponse {
    public var status : String?
    public var copyright : String?
    public var num_results : Int?
    public var results : Array<MPAModel>?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let  MostPopularArticleBaseResponse_list = MostPopularArticleBaseResponse.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of MostPopularArticleBaseResponse Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [MPABaseResponse]
    {
        var models:[MPABaseResponse] = []
        for item in array
        {
            models.append(MPABaseResponse(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let json4Swift_Base = Json4Swift_Base(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Json4Swift_Base Instance.
*/
    required public init?(dictionary: NSDictionary) {

        status = dictionary["status"] as? String
        copyright = dictionary["copyright"] as? String
        num_results = dictionary["num_results"] as? Int
        if (dictionary["results"] != nil) { results = MPAModel.modelsFromDictionaryArray(array: dictionary["results"] as! NSArray) }
    }

        
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
    public func dictionaryRepresentation() -> NSDictionary {

        let dictionary = NSMutableDictionary()

        dictionary.setValue(self.status, forKey: "status")
        dictionary.setValue(self.copyright, forKey: "copyright")
        dictionary.setValue(self.num_results, forKey: "num_results")

        return dictionary
    }

}
