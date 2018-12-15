//
//  realmModel.swift
//  russell_test_api
//
//  Created by russell on 14/12/18.
//  Copyright © 2018 Oceanize. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class realmModel: Object {
    
    dynamic var name: String = ""
    dynamic var descriptionOfPlace: String = ""

    
    convenience init(name: String, descriptionOfPlace: String) {
        self.init()
        self.name = name
        self.descriptionOfPlace = descriptionOfPlace
    }
    
}
