//
//  AccountViewController.swift
//  NGOapp
//
//  Created by Apple on 23/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

class AccountViewController: UIViewController {
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var professionField: UILabel!
    @IBOutlet weak var numField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userLoggedIn.username == "" {
            nameField.text = "You haven't signed in yet"
            numField.text = "You can always fill one of the two forms to sign up automatically"
            professionField.isHidden = true
        }
        else {
            nameField.text = userLoggedIn.username
            if userLoggedIn.pro != "" {
                professionField.text = userLoggedIn.pro
            }
            else {
                professionField.isHidden = true
            }
            numField.text = userLoggedIn.number
        }
        
    }
}
