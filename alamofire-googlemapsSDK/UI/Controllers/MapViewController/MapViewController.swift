//
//  MapViewController.swift
//  alamofire-googlemapsSDK
//
//  Created by Oleksiy Humenyuk on 24.06.2022.
//

import Foundation
import UIKit
import Alamofire
import GoogleMaps


protocol PostcodesDelegation {
    func setPostcodes(postcodes: [Postcode])
}

class MapViewController: UIViewController, PostcodesDelegation {
    
    private var postcodes: [Postcode] = []
    private var camera = GMSCameraPosition()
    private var mapView = GMSMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postcodes = PostcodesService.shared.getPostcodes()
        setMarkers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.postcodes = PostcodesService.shared.getPostcodes()
        let postcodes = PostcodesService.shared.getAddedPostcodesFromStorage()
        if !postcodes.isEmpty {
            for i in postcodes{
                self.postcodes.append(i)
            }
        }
        setMarkers()
        reloadMarker()
    }
    
    func setPostcodes(postcodes: [Postcode]) {
        self.postcodes = postcodes
        self.setMarkers()
    }
    
    private func setMarkers() {
        self.camera = GMSCameraPosition(latitude: CLLocationDegrees(postcodes[1].latitude), longitude: CLLocationDegrees(postcodes[1].longitude), zoom: 15)
        self.mapView = GMSMapView(frame: .zero, camera: camera)
        self.view = mapView
        
        for postcodeNum in 0 ..< postcodes.count {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(postcodes[postcodeNum].latitude), longitude:CLLocationDegrees(postcodes[postcodeNum].longitude))
            marker.map = self.mapView
        }
    }
    
    private func reloadMarker() {
        let favoriteMarkers = PostcodesService.shared.getFavoritePostcodes()
        for markerNum in 0 ..< favoriteMarkers.count {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(favoriteMarkers[markerNum].latitude), longitude:CLLocationDegrees(favoriteMarkers[markerNum].longitude))
            marker.icon = GMSMarker.markerImage(with: .black)
            marker.map = self.mapView
        }
    }
    

}
