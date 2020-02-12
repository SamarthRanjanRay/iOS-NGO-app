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
    var currentCoordinates : CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var userFriendlyText : String? = String()
    var update : Bool = true
   // var viewControllerName : String = ""
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if update == true {
            if eventLocation.cordinates.latitude == 0 && eventLocation.cordinates.longitude == 0 {
                currentCoordinates = (locations.last?.coordinate)!
            }
            else {
                currentCoordinates = eventLocation.cordinates
            }
            createAnno()
            update = false
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print(error)
    }
    
    @IBAction func submitLocation(_ sender: Any) {
        
        let geoCoder = CLGeocoder()
        let searchedLocation = CLLocation(latitude: currentCoordinates.latitude, longitude: currentCoordinates.longitude)
        geoCoder.reverseGeocodeLocation(searchedLocation) { [weak self] (placemark, error) in
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
            self.userFriendlyText = name + ", " + subloc
            guard let uf = self.userFriendlyText else {
                let alert = UIAlertController(title: "Location Name Error", message: "The Requested place cannot be converted into text for everyone's use, try shifting the annoation a bit.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
            
            eventLocation.cordinates = self.currentCoordinates
            eventLocation.name = uf
            
            eventLocation.save()
            
        }
        perform(#selector(callSegue), with: nil, afterDelay: 5)
        
    }
    
    @objc func callSegue() {
        performSegue(withIdentifier: "tryTUC", sender: self)
    }

    
    
    @IBAction func handle(_ sender: Any) {
        guard let gestureRecognizer = sender as? UILongPressGestureRecognizer else {
            return
        }
        let locate = gestureRecognizer.location(in: mapView)
        currentCoordinates = mapView.convert(locate, toCoordinateFrom: mapView)
        createAnno()
    }
    
    @IBAction func searchPlace(_ sender: Any) {
        let searchRequest = MKLocalSearch.Request()
        
        searchRequest.naturalLanguageQuery = searchField.text
        
        let active = MKLocalSearch(request: searchRequest)
        active.start { (response, error) in
            guard let res = response else {
                let alert = UIAlertController(title: "Location Search Error", message: "The Requested place cannot be searched, try using some other keywords of the same place. Or you can always scroll the map if you want.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
            self.currentCoordinates = CLLocationCoordinate2DMake(res.boundingRegion.center.latitude, res.boundingRegion.center.longitude)
            self.createAnno()
        }
    }
    
    
    func createAnno() {
        if mapView.annotations.count != 0 {
            mapView.removeAnnotations(mapView.annotations)
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentCoordinates
        annotation.title = "Selected Location"
        annotation.subtitle = "This will be saved for future references"
        mapView.addAnnotation(annotation)
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region : MKCoordinateRegion = MKCoordinateRegion(center: currentCoordinates, span: span)
        mapView.setRegion(region, animated: true)
    }
}
