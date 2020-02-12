//
//  User.swift
//  NGOapp
//
//  Created by Apple on 10/02/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct UserL {
    var username : String
    var number : String
    var pro : String
    
    func save() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(self.username, forKey: "name")
        newUser.setValue(self.number, forKey: "num")
        newUser.setValue(self.pro, forKey: "pro")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    mutating func load() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                self.username = data.value(forKey: "name") as! String
                self.pro = data.value(forKey: "pro") as! String
                self.number = data.value(forKey: "num") as! String
                
            }
            
        } catch {
            
            print("Failed")
        }
    }
}

var userLoggedIn = UserL(username: "", number: "", pro: "")
