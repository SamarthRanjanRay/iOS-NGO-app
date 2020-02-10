//
//  VolunteerViewController.swift
//  NGOapp
//
//  Created by Apple on 23/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

class VolunteerViewController: UIViewController {
    
    @IBOutlet weak var daysVolunteer: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
  
    @IBOutlet weak var professionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        daysVolunteer.delegate = self
        ageTextField.delegate = self
        professionTextField.delegate = self
    }
    
    
    @IBAction func receiveCall(_ sender: Any) {
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
