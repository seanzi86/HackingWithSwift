//
//  ViewController.swift
//  Project19
//
//  Created by Sean Carrington on 12/03/2019.
//  Copyright © 2019 seanzi86. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "View", style: .plain, target: self, action: #selector(changeViewTapped))
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.", favourite: true)
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.", favourite: false)
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.", favourite: true)
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.", favourite: false)
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.", favourite: false)
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "Capital"
        
        if annotation is Capital {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                
                let capital = annotation as! Capital
                if (capital.favourite) {
                    annotationView!.pinTintColor = MKPinAnnotationView.greenPinColor()
                } else {
                    annotationView!.pinTintColor = MKPinAnnotationView.redPinColor()
                }
                
                let button = UIButton(type: .detailDisclosure)
                annotationView!.rightCalloutAccessoryView = button
            } else {
                annotationView!.annotation = annotation
            }
            
            return annotationView
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let capital = view.annotation as! Capital
        let placeName = capital.title
        let placeInfo = capital.info
        
        let alertController = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }

    @objc func changeViewTapped() {
        let alertController = UIAlertController(title: "Change View", message: "Please select a view.", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Hybrid", style: .default , handler:{ (action) in self.setMapType(type: .hybrid)}))
        alertController.addAction(UIAlertAction(title: "Hybrid Flyover", style: .default , handler:{ (action) in self.setMapType(type: .hybridFlyover)}))
        alertController.addAction(UIAlertAction(title: "Satellite", style: .default , handler:{ (action) in self.setMapType(type: .satellite)}))
        alertController.addAction(UIAlertAction(title: "Satellite Flyover", style: .default , handler:{ (action) in self.setMapType(type: .satelliteFlyover)}))
        alertController.addAction(UIAlertAction(title: "Standard", style: .default , handler:{ (action) in self.setMapType(type: .standard)}))
        present(alertController, animated: true)
     }
    
    func setMapType(type: MKMapType) {
        mapView.mapType = type
    }
}

