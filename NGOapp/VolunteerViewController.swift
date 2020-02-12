//
//  VolunteerViewController.swift
//  NGOapp
//
//  Created by Apple on 23/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class VolunteerViewController: UIViewController {
    
    @IBOutlet weak var daysVolunteer: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
  
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var professionTextField: UITextField!
    
    @IBOutlet weak var numTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        daysVolunteer.delegate = self
        ageTextField.delegate = self
        professionTextField.delegate = self
        
        nameTextField.text = userLoggedIn.username
        numTextField.text = userLoggedIn.number
        professionTextField.text = userLoggedIn.pro
    }
    
    
    @IBAction func receiveCall(_ sender: Any) {
        
        
        userLoggedIn.number = numTextField.text!
        userLoggedIn.username = nameTextField.text!
        userLoggedIn.pro = professionTextField.text!
        
        userLoggedIn.save()
        performSegue(withIdentifier: "vTm", sender: self)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ageTextField.resignFirstResponder()
    }
}
extension VolunteerViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
        return true
    }
}
