//
//  apiModel.swift
//  russell_test_api
//
//  Created by russell on 14/12/18.
//  Copyright © 2018 Oceanize. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class apiModel {
    
    var name: String?
    var description: String?
    
    required init(name: String, description: String) {
        self.name = name
        self.description = description
    }
    
    convenience init?(json: JSON) {
        
        //print("API Model JSON Is : \(json)")
        
        guard let lang = json["lang"].string,
              let langname = json["langname"].string
                 else {
                print("Model Error")
                return nil
        }
                
        self.init(name: lang, description: langname)
        
        // insert into realm
        let realmCreate = realmModel(name: lang, descriptionOfPlace: langname)
        realmServices.shared.create(realmCreate)
    }

    
}
