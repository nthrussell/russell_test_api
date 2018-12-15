//
//  realmServices.swift
//  russell_test_api
//
//  Created by russell on 14/12/18.
//  Copyright © 2018 Oceanize. All rights reserved.
//

import Foundation
import RealmSwift

class realmServices {
    
    private init() {}
    static let shared = realmServices()
    
    var realm = try! Realm()
    
    // Realm create
    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("realm create error: \(error)")
        }
    }
    
    
    // Realm update
    func update<T: Object>(_ object: T, with dictionary: [String : Any?] ) {
        do {
            try realm.write {
                for(key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            print("realm update error: \(error)")
        }
    }
    
    
    //Realm delete
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("realm delete error: \(error)")
        }
    }
    
    
}
