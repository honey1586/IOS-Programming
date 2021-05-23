//
//  MapMarker.swift
//  IOSProject
//
//  Created by Jaeyeong on 2021/05/23.
//

import Foundation
import MapKit

class MapMarker: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }
    
}
