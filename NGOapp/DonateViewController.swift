//
//  DonateViewController.swift
//  NGOapp
//
//  Created by Apple on 23/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class DonateViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var peopleTextField: UITextField!
    @IBOutlet weak var peoplePicker: UIPickerView!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var reqLoc: UIButton!
    
    var peopleRange = ["10-20","20-30","30-40","40-50","50-60","60-70","70-80","80-90","90-100",">100"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var titleRow = String()
        if pickerView == peoplePicker {
            titleRow = peopleRange[row]
            return titleRow
        }
        return "" 
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countRows: Int = peopleRange.count
        if pickerView == peoplePicker {
            countRows = peopleRange.count
        }
        return countRows
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == peoplePicker {
            self.peopleTextField.text = self.peopleRange[row]
            self.peoplePicker.isHidden = true
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == self.peopleTextField){
            self.peoplePicker.isHidden = false
            
        }
        
    }
    override func viewDidLoad() {
        nameTextField.text = userLoggedIn.username
        phoneNumTextField.text = userLoggedIn.number
        reqLoc.setTitle(eventLocation.name, for: .normal)

        super.viewDidLoad()
    }
    @IBAction func register(_ sender: Any) {
        
        if nameTextField.text == nil || phoneNumTextField.text == nil || peopleTextField.text == nil {
            let alert = UIAlertController(title: "Form Incomplete Error", message: "We would request you to fill all the fields of the form as it will help us know more about you and provide you our quality service.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else {
            userLoggedIn.username = nameTextField.text!
            userLoggedIn.number = phoneNumTextField.text!
            userLoggedIn.pro = ""
            userLoggedIn.save()
            
            performSegue(withIdentifier: "dTm", sender: self)
        }
    }
    @IBAction func fetchNewLocation(_ sender: Any) {
        performSegue(withIdentifier: "donateToMap", sender: self)
    }
    
    @IBAction func unwindFromMap(_ unwindSegue: UIStoryboardSegue) {
    }

    override func viewDidAppear(_ animated: Bool) {
        reqLoc.setTitle(eventLocation.name, for: .normal)
    }
}
