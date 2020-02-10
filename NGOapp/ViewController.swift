//
//  ViewController.swift
//  NGOapp
//
//  Created by Apple on 22/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    var image1: UIImage!
    var image2: UIImage!
    var image3: UIImage!
    var images: [UIImage]!
    var animatedImage: UIImage!
    var loc : locationSelected = locationSelected()
    @IBOutlet weak var locc: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        image1 = UIImage(named: "image1")
        image2 = UIImage(named: "image2")
        image3 = UIImage(named: "image3")
        images = [image1,image2,image3]
        animatedImage = UIImage.animatedImage(with: images, duration: 5.0)
        imgoutlet.image = animatedImage
        locc.setTitle(loc.name, for: .normal)
        
        let barViewControllers = self.tabBarController?.viewControllers
        
        
    }


    @IBOutlet weak var imgoutlet: UIImageView!

    struct locationSelected {
        var cordinates: CLLocationCoordinate2D
        var name: String
        
        init() {
            self.cordinates = CLLocationCoordinate2DMake(0, 0)
            self.name = "Enter your location"
        }
    
    }
}

