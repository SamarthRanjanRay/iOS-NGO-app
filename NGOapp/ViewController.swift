//
//  ViewController.swift
//  NGOapp
//
//  Created by Apple on 22/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData
class ViewController: UIViewController {

    var image1: UIImage!
    var image2: UIImage!
    var image3: UIImage!
    var images: [UIImage]!
    var animatedImage: UIImage!
    @IBOutlet weak var requestLocation: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        image1 = UIImage(named: "image1")
        image2 = UIImage(named: "image2")
        image3 = UIImage(named: "image3")
        images = [image1,image2,image3]
        animatedImage = UIImage.animatedImage(with: images, duration: 5.0)
        imgoutlet.image = animatedImage
        eventLocation.load()
        requestLocation.setTitle(eventLocation.name, for: .normal)

        userLoggedIn.load()
        
    }


    @IBOutlet weak var imgoutlet: UIImageView!
}

