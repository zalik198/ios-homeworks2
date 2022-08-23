//
//  MapViewController.swift
//  Navigation
//
//  Created by Shom on 22.08.2022.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var mapView: MKMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MKMapView()
        self.view.addSubview(self.mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        [self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
         self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
         self.mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
         self.mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
         
        ] .forEach { $0.isActive = true }
        // Do any additional setup after loading the view.
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
    
        getDirection()
        
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsCompass = true
        mapView.showsUserLocation = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
        
        
        //getDirection(mapView.userLocation.coordinate, annotationSPB.coordinate)
        
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let mapView = self.mapView else { return }
        mapView.frame = view.bounds
    }
    
    @objc func handleTap(_ gestureReconizer: UILongPressGestureRecognizer)
    {
        
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        self.mapView.addAnnotation(annotation)
        self.mapView.isZoomEnabled = true
        self.mapView.isScrollEnabled = true
    }
    
    func getDirection() {

        let annotationSPB = MKPointAnnotation()
        annotationSPB.coordinate = CLLocationCoordinate2D(latitude: 59.9339, longitude: 30.3061)
        
        let annotationUser = MKPointAnnotation()
        annotationUser.coordinate = locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 59.7234, longitude: 30.3271)

        mapView.showAnnotations([annotationSPB, annotationUser], animated: true)
        
    
        
        let sourceItem  = MKMapItem(placemark: MKPlacemark(coordinate: annotationSPB.coordinate))
        
        let destItem = MKMapItem(placemark: MKPlacemark(coordinate: annotationUser.coordinate))
        
        let request = MKDirections.Request()
        
        request.source = sourceItem
        request.destination = destItem
        
        request.transportType = .walking
        let directions = MKDirections(request: request)
        
        directions.calculate { responce, error in
            guard let responce = responce else { return }
            if responce.routes.count > 0 {
                let route = responce.routes.first!
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                let rect = route.polyline.boundingMapRect
                self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
            
            
        }
    
  
        
    }
    





extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        mapView.mapType = MKMapType.standard
        mapView.showsCompass = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        
        let span = MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        //annotation.coordinate = locValue
        annotation.title = "Мое местоположение"
        annotation.subtitle = "iPhone"
        mapView.addAnnotation(annotation)
        
        //centerMap(locValue)
    }
    
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 3
        renderer.strokeColor = .systemBlue
        return renderer
    }
}
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        guard annotation is MKPointAnnotation else { print("no mkpointannotaions"); return nil }
//
//        let reuseId = "pin"
//        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
//
//        if pinView == nil {
//            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//            pinView!.canShowCallout = true
//            pinView!.rightCalloutAccessoryView = UIButton(type: .infoDark)
//            pinView!.pinTintColor = UIColor.black
//        }
//        else {
//            pinView!.annotation = annotation
//        }
//        return pinView
//    }
    
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        guard let coordinate = locationManager.location?.coordinate else { return }
//        let destination = view.annotation
//
//        let startPoint = MKPlacemark(coordinate: coordinate)
//        let endPoint = MKPlacemark(coordinate: destination!.coordinate)
//
//        let request = MKDirections.Request()
//        request.source = MKMapItem(placemark: startPoint)
//        request.destination = MKMapItem(placemark: endPoint)
//        request.transportType = .walking
//
//        let direction = MKDirections(request: request)
//        direction.calculate { responce, error in
//            guard let responce = responce else { return }
//            for route in responce.routes {
//                self.mapView.addOverlay(route.polyline)
//            }
//        }
//    }
    
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        let renderer = MKPolylineRenderer(overlay: overlay)
//                // Set the color for the line
//                renderer.strokeColor = .red
//                return renderer
//    }
    
    
    
//}

//extension MKMapView {
//
//  func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
//    let sourcePlacemark = MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil)
//    let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil)
//
//    let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
//    let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
//
//    let sourceAnnotation = MKPointAnnotation()
//
//    if let location = sourcePlacemark.location {
//        sourceAnnotation.coordinate = location.coordinate
//    }
//
//    let destinationAnnotation = MKPointAnnotation()
//
//    if let location = destinationPlacemark.location {
//        destinationAnnotation.coordinate = location.coordinate
//    }
//
//    self.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
//
//    let directionRequest = MKDirections.Request()
//    directionRequest.source = sourceMapItem
//    directionRequest.destination = destinationMapItem
//    directionRequest.transportType = .automobile
//
//    // Calculate the direction
//    let directions = MKDirections(request: directionRequest)
//
//    directions.calculate {
//        (response, error) -> Void in
//
//        guard let response = response else {
//            if let error = error {
//                print("Error: \(error)")
//            }
//
//            return
//        }
//        let route = response.routes[0]
//        self.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
//        let rect = route.polyline.boundingMapRect
//        self.setRegion(MKCoordinateRegion(rect), animated: true)
//    }
//}}
//

/*
 extension MapViewController: MKMapViewDelegate {
 
 
 func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
 guard let annotation = annotation as? MKPointAnnotation else { print("no mkpointannotaions"); return nil }
 
 
 var viewMaker: MKMarkerAnnotationView
 let reuseId = "pin"
 
 if let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKMarkerAnnotationView {
 //pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
 pinView.annotation = annotation
 viewMaker = pinView
 //            pinView!.canShowCallout = true
 //            pinView!.rightCalloutAccessoryView = UIButton(type: .infoDark)
 //            pinView!.pinTintColor = UIColor.black
 } else {
 viewMaker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
 viewMaker.canShowCallout = true
 viewMaker.calloutOffset = CGPoint(x: 0, y: 6)
 viewMaker.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
 }
 return viewMaker
 }
 
 func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
 guard let coordinate = locationManager.location?.coordinate else { return }
 let user = view.annotation
 
 let startPoint = MKPlacemark(coordinate: coordinate)
 let endPoint = MKPlacemark(coordinate: user!.coordinate)
 
 let request = MKDirections.Request()
 request.source = MKMapItem(placemark: startPoint)
 request.destination = MKMapItem(placemark: endPoint)
 request.transportType = .walking
 
 let direction = MKDirections(request: request)
 direction.calculate { responce, error in
 guard let responce = responce else { return }
 for route in responce.routes {
 self.mapView.addOverlay(route.polyline)
 }
 }
 }
 
 func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
 let renderer = MKPolylineRenderer(overlay: overlay)
 renderer.strokeColor = .blue
 renderer.lineWidth = 4
 
 return renderer
 }
 
 
 }
 */
