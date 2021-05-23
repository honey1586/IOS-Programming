//
//  TourInfoLocation.swift
//  IOSProject
//
//  Created by Jaeyeong on 2021/05/23.
//

import UIKit
import MapKit

class TourInfoLocation: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var outlet_mapView: MKMapView!
    let regionRadius: CLLocationDistance = 5000
    
    var locationX: String = ""
    var locationY: String = ""
    var name: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let lati: CLLocationDegrees = (locationY as NSString).doubleValue
        let long: CLLocationDegrees = (locationX as NSString).doubleValue
        let initialLocation = CLLocation(latitude: lati, longitude: long)
        outlet_mapView.centerMapOnLocation(initialLocation)
        
        //outlet_mapView.delegate = self
        //outlet_mapView.addAnnotations(hospitals)
        
        // Do any additional setup after loading the view.
        let mapMarker = MapMarker(title: name, coordinate: CLLocationCoordinate2D(latitude: lati, longitude: long))
        outlet_mapView.addAnnotation(mapMarker)
    }
    
    
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        <#code#>
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


private extension MKMapView {
    func centerMapOnLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            setRegion(coordinateRegion, animated: true)
    }
}
