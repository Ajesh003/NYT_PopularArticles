
import UIKit


class MPAService {
    
    
    /**
     Fetch the Most Viewed Items from the API.
     
     - parameter completionHandler: Callback with optional object MostViewedResponse and Error.
     
     This function utilises the network controller to get the JSON and transforms them into the MostViewedResponse Model.
     */
    
    
    
    enum JSONError: String, Error {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }
    
 
    

    static func getMostPopularArticles(completionHandler: @escaping (MPABaseResponse?, Error?) -> Void) {
        
        
         var apiKey: String {
         get {
           // 1
           guard let filePath = Bundle.main.path(forResource: "keys", ofType: "plist") else {
             fatalError("Couldn't find file 'keys.plist'.")
           }
           // 2
           let plist = NSDictionary(contentsOfFile: filePath)
           guard let value = plist?.object(forKey: "API_KEY") as? String else {
             fatalError("Couldn't find key 'API_KEY' in 'keys.plist'.")
           }
           return value
         }
       }
       
    
        
        let baseURL = "https://api.nytimes.com/svc"
        let section = "all-sections"
        let period = "7"
        let apiMostPopularArticles = "/mostpopular/v2/mostviewed/\(section)/\(period).json"
        
        let urlPath = baseURL + apiMostPopularArticles + "?api-key=\(apiKey)"
        
        guard let endpoint = URL(string: urlPath) else {
            print("Error creating endpoint")
            return
        }
        URLSession.shared.dataTask(with: endpoint) { (data, response, error) in
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                    throw JSONError.ConversionFailed
                }
                print(json)
                
                let responseModel = MPABaseResponse(dictionary: json)
                completionHandler(responseModel, error)
                
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }
        }.resume()
    }
    
    
    
    
    /**
     Downloads the first available image from given MostViewedResults object.

     - parameter object: given MostViewedResults object.
     - parameter completionHandler: Callback with optional UIImage and Error.
     */
    static func getImage(object : MPAModel, completionHandler: @escaping (UIImage?, Error?) -> Void) {
    
        if let media = object.media?.first {
            if  let metadata = media.media_metadata?.last {
                
                let url: String = metadata.url!
                
                
                
                if let url = URL(string: url) {
                    let task = URLSession.shared.dataTask(with: url) { data, response, error in
                        guard let data = data, error == nil else { return }
                        
                        DispatchQueue.main.async { /// execute on main thread
                            
                            completionHandler(UIImage(data: data), error)
                        }
                    }
                    
                    task.resume()
                }
                

            }
        }
    }
    
    
   public  func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}

