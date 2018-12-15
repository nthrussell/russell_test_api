//
//  AlertService.swift
//  russell_test_api
//
//  Created by russell on 15/12/18.
//  Copyright © 2018 Oceanize. All rights reserved.
//

import Foundation
import UIKit

class AlertService {
    
    private init() {}
    
    static func addAlert(in vc: UIViewController,
                         completion: @escaping (String, String?) -> Void) {
        
        let alert = UIAlertController(title: "Add Name & Description", message: nil, preferredStyle: .alert)
        alert.addTextField { (name) in
            name.placeholder = "Enter Name of Place"
        }
      
        alert.addTextField { (description) in
            description.placeholder = "Enter Description"
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let line = alert.textFields?.first?.text,
                let descriptionString = alert.textFields?.last?.text
                else { return }
            
            let description = descriptionString == "" ? nil : descriptionString
            
            completion(line, description)
        }
        
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    
    
    // Update action
    static func updateAlert(in vc: UIViewController,
                            model: realmModel,
                            completion: @escaping (String, String) -> Void) {
        
        let alert = UIAlertController(title: "Update Name", message: nil, preferredStyle: .alert)
        alert.addTextField { (name) in
            name.placeholder = "Enter Name"
            name.text = model.name
        }
        alert.addTextField { (desc) in
            desc.placeholder = "Enter Email"
            desc.text = model.descriptionOfPlace
        }
        
        let action = UIAlertAction(title: "Update", style: .default) { (_) in
            guard let name = alert.textFields?.first?.text,
                let desc = alert.textFields?.last?.text
                else { return }
            
            let description = desc == "" ? nil : desc
            
            completion(name, description ?? "")
        }
        
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
    
}








