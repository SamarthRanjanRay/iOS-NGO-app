//
//  Location.swift
//  NGOapp
//
//  Created by Apple on 10/02/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import CoreLocation
import CoreData
import UIKit

struct locationSelected {
    var cordinates: CLLocationCoordinate2D
    var name: String
    
    init() {
        self.cordinates = CLLocationCoordinate2DMake(0, 0)
        self.name = "Enter your location"
    }
    
    func save() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Location", in: context)
        
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(self.cordinates.latitude, forKey: "coordx")
        newUser.setValue(self.cordinates.longitude, forKey: "coordy")
        newUser.setValue(self.name, forKey: "name")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    mutating func load() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                self.name = data.value(forKey: "name") as! String
                self.cordinates.latitude = CLLocationDegrees(data.value(forKey: "coordx") as! Float)
                self.cordinates.longitude = CLLocationDegrees(data.value(forKey: "coordy") as! Float)
                
            }
            
        } catch {
            
            print("Failed")
        }
    }

    
}

var eventLocation = locationSelected()
