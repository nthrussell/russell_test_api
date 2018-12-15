//
//  apiManager.swift
//  russell_test_api
//
//  Created by russell on 14/12/18.
//  Copyright © 2018 Oceanize. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


//Error could happen for these reason
enum APIManagerError: Error {
    case network(error: Error)
    case apiProvidedError(reason: String)
    case objectSerialization(reason: String)
}

// APIManager Class
class apiManager {
    
    static let sharedInstance = apiManager()
    
    // Applied promo details
    func fetchApi(completionHandler: @escaping (Result<[apiModel]>) -> Void) {
        
        let endPoint: String = "https://en.wikipedia.org/w/api.php?action=parse&page=test&format=json"

        Alamofire.request(endPoint).responseJSON { (response) in
            
            let result = self.checkForError(response: response)
            completionHandler(result)
        }
    }
    
    // Check for any error
    private func checkForError(response: DataResponse<Any>) -> Result<[apiModel]> {
        
        // For Network Error
        guard response.result.error == nil else {
            print("response.result.error is:")
            print(response.result.error!)
            return .failure(APIManagerError.network(error: response.result.error!))
        }
        
        // JSON Serialization Error, make sure we got JSON and it's an array
        guard let json = response.result.value else {
            print("did not get tripHistory object as JSON from API")
            return .failure(APIManagerError.objectSerialization(reason: "Did not get JSON in response"))
        }
        
        var apiModelArray = [apiModel]()
        
        let myValue = JSON(json)
        let mainContent = myValue["parse"].dictionary
        //print("Parse content:\(String(describing: mainContent))")
        let arrayContent = mainContent?["langlinks"]?.array
        //print("arrayContent:\(arrayContent)")
        for item in arrayContent! {
            apiModelArray.append(apiModel(json: item)!)
        }
        
        return .success(apiModelArray)
        
    }
    
    
}
