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

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var gmsMapView: GMSMapView?
    let locationManager = CLLocationManager()
    var userLocation : CLLocationCoordinate2D?
    var addressLocation: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(seguesToAddAddressController))
        GMSServices.provideAPIKey("AIzaSyAOhiBw8mSPBmmAJQ_fjM79x7ruvMxFmxQ")
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        setupGMSMapView()

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let center = location.coordinate
        userLocation = center
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 18)
        gmsMapView?.animate(to: camera)
        gmsMapView?.isMyLocationEnabled = true

        //DO NOT USE THIS, INSTEAD MAKE A STATIC MAP
//        gmsMapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        view = gmsMapView
        
        if addressLocation != "" || addressLocation != nil {
            if let address = addressLocation {
                var coordinates = CLLocationCoordinate2D()
                let geocoder = CLGeocoder()
                
                geocoder.geocodeAddressString(address) { (placemarks, error) in
                    if error != nil {
                        //put an alert here for no placemarks found
                        print("GEOCODER: No Placemarks Found!")
                    } else {
                        guard let unwrappedCoord = placemarks?.first?.location?.coordinate else {return}
                        coordinates = unwrappedCoord
                        let userPoint = MKMapPointForCoordinate(center)
                        let addressPoint = MKMapPointForCoordinate(coordinates)
                        let distance = MKMetersBetweenMapPoints(userPoint, addressPoint)
                        if distance < 100000 {
                            let newMarker = GMSMarker(position: coordinates)
                            newMarker.title = address
                            newMarker.map = self.gmsMapView
                            self.gmsMapView?.animate(toLocation: coordinates)
                            self.gmsMapView?.isMyLocationEnabled = true
                        }
                    }
                }
                addressLocation = nil
            }
        }
    }
    
    private func setupGMSMapView() {
        
        //make the map static
        //do not use view = googlemap
        
        gmsMapView = GMSMapView()
        gmsMapView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gmsMapView!)
        gmsMapView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        gmsMapView?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        gmsMapView?.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        gmsMapView?.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true

    }
    
    @objc func seguesToAddAddressController() {
        let addAddress = AddAddressController()
        let addAddressNav = UINavigationController(rootViewController: addAddress)
        self.present(addAddressNav, animated: true) {
        }
    }

}

