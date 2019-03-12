//
//  Capital.swift
//  Project19
//
//  Created by Sean Carrington on 12/03/2019.
//  Copyright © 2019 seanzi86. All rights reserved.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title:String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info 
    }
}
