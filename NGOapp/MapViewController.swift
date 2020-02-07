//
//  MapViewController.swift
//  NGOapp
//
//  Created by Apple on 23/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        longpresss.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longpresss)
    }

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var searchField: UITextField!


    @IBOutlet var longpresss: UILongPressGestureRecognizer!
    
    let locationManager : CLLocationManager = CLLocationManager()
    var coord : CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var userFriendly : String? = String()
    var update : Bool = true
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if update == true {
            coord = (locations.last?.coordinate)!
            createAnno()
            update = false
        } else {
            return
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print(error)
    }
    
    @IBAction func submitLocation(_ sender: Any) {
        
        let geoCoder = CLGeocoder()
        let loc = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
        geoCoder.reverseGeocodeLocation(loc) { [weak self] (placemark, error) in
            guard let self = self else {
                return
            }
            
            guard let placemark = placemark?.last else {
                let alert = UIAlertController(title: "Location Search Error", message: "The Requested place cannot be searched, try using some other keywords of the same place. Or you can always scroll the map if you want.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
            guard let name = placemark.name else {
                return
            }
            guard let subloc = placemark.subLocality else {
                return
            }
            self.userFriendly = name + subloc
            guard let uf = self.userFriendly else {
                print("string hi ni bana")
                return
            }
            print("string bann gaya:",uf)
            
            
            
            
        }
        perform(#selector(callSegue), with: nil, afterDelay: 5)
        
    }
    
    @objc func callSegue() {
        performSegue(withIdentifier: "back", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController
            vc.loc.cordinates = coord
            guard let uf = userFriendly else {
                print("nil aarha hai")
                return
            }
            vc.loc.name = uf

    }
    
    
    @IBAction func handle(_ sender: Any) {
        guard let gestureRecognizer = sender as? UILongPressGestureRecognizer else {
            return
        }
        let locate = gestureRecognizer.location(in: mapView)
        coord = mapView.convert(locate, toCoordinateFrom: mapView)
        createAnno()
    }
    
    @IBAction func searchPlace(_ sender: Any) {
        let req = MKLocalSearch.Request()
        
        req.naturalLanguageQuery = searchField.text
        
        let active = MKLocalSearch(request: req)
        active.start { (response, error) in
            guard let res = response else {
                let alert = UIAlertController(title: "Location Search Error", message: "The Requested place cannot be searched, try using some other keywords of the same place. Or you can always scroll the map if you want.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
            self.coord = CLLocationCoordinate2DMake(res.boundingRegion.center.latitude, res.boundingRegion.center.longitude)
            self.createAnno()
        }
    }
    
    
    func createAnno() {
        if mapView.annotations.count != 0 {
            mapView.removeAnnotations(mapView.annotations)
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = coord
        annotation.title = "YOU"
        annotation.subtitle = "event location"
        mapView.addAnnotation(annotation)
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region : MKCoordinateRegion = MKCoordinateRegion(center: coord, span: span)
        mapView.setRegion(region, animated: true)
    }
}
