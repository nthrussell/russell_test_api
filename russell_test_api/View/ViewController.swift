//
//  ViewController.swift
//  russell_test_api
//
//  Created by russell on 13/12/18.
//  Copyright © 2018 Oceanize. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        return view
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .custom)
        let btnImage = UIImage(named: "addIcon")
        button.setImage(btnImage, for: .normal)
        button.imageView?.clipsToBounds = true
        button.addTarget(self, action: #selector(addBtnPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    var tableView = UITableView()
    var realmModelData: Results<realmModel>!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(containerView)
        addConstraints()
        self.createTableView()
        fetchApiList()
        
        let realm = realmServices.shared.realm
        realmModelData = realm.objects(realmModel.self)
    }


    func fetchApiList() {
        apiManager.sharedInstance.fetchApi { (result) in
            
            guard result.error == nil else {
                print("api result.error:\(String(describing: result.error))")
                return
            }
            
            self.tableView.reloadData()
        }
        
    }
    
    @objc func addBtnPressed() {
        print("Add button pressed")
        
        AlertService.addAlert(in: self) { (name, desc) in
            let newData = realmModel(name: name, descriptionOfPlace: desc ?? "")
            realmServices.shared.create(newData)
        }
        self.tableView.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.realmModelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style:.subtitle, reuseIdentifier:"searchCell")
        
        let data = self.realmModelData[indexPath.row]
        cell.textLabel?.text = data.name
        cell.detailTextLabel?.text = data.descriptionOfPlace
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell selected")
        let data = realmModelData[indexPath.row]
        
        AlertService.updateAlert(in: self, model: data) { (name, desc) in
            let dict: [String: Any?] = [ "name": name,
                                         "descriptionOfPlace": desc ]
            realmServices.shared.update(data, with: dict)
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let data = realmModelData[indexPath.row]
        
        realmServices.shared.delete(data)
    }

    
    private func createTableView() {
        
        
        tableView.frame = CGRect(x: 0, y: 150, width: view.frame.width, height: view.frame.height)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "searchCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
            
    }

    
    func addConstraints() {
        // need x, y, width & height constraints
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25.0).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 145).isActive = true
        
        containerView.addSubview(addButton)
        
        // need x, y, width & height constraints
        addButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        addButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 50).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
    }
    
    
}

