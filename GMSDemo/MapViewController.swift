//
//  ViewController.swift
//  GMSDemo
//
//  Created by Rey Cerio on 2018-06-13.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var gmsMapView : GMSMapView?
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyAOhiBw8mSPBmmAJQ_fjM79x7ruvMxFmxQ")
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
//        let camera = GMSCameraPosition.camera(withLatitude: 37.621262, longitude: -122.378945, zoom: 12)
//        gmsMapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        view = gmsMapView
        
//        let currentLocation = CLLocationCoordinate2D(latitude: 37.621262, longitude: -122.378945)
//        let marker = GMSMarker(position: currentLocation)
//        marker.title = "SFO Airport"
//        marker.map = gmsMapView
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        let center = location.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: center, span: span)
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 18)
        gmsMapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = gmsMapView
        
        let marker = GMSMarker(position: location.coordinate)
        marker.title = "Me!"
        marker.map = gmsMapView
    }

}

