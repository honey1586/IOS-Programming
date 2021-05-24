//
//  NearTourSearchViewController.swift
//  IOSProject
//
//  Created by KPUGAME on 2021/05/24.
//

import UIKit
import CoreLocation

class NearTourSearchViewController: UIViewController , CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    var lati : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.startUpdatingLocation()
        
        let coor = locationManager.location?.coordinate
        lati = coor?.latitude
    }
    
    @IBAction func test(_ sender: Any) {
        
        print("lati : \(lati)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
