//
//  MapViewController.swift
//  Navigation
//
//  Created by Shom on 22.08.2022.
//

import UIKit
import MapKit
import CoreLocation
import Contacts

class MapViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var locationManager = CLLocationManager()
    let largeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .light, scale: .small)


    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle", withConfiguration: largeConfig), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleTapButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView: MKMapView!
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        self.mapView.mapType = .standard
        self.mapView.isZoomEnabled = true
        self.mapView.isScrollEnabled = true
        self.mapView.showsCompass = true
        self.mapView.showsUserLocation = true
        return self.mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView = MKMapView()
        self.mapView.delegate = self
        self.view.addSubview(self.mapView)
        self.view.addSubview(self.button)
        self.mapView.showsUserLocation = true
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        //getDirection()
        initialLayout()
        
        let myLongPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer()
        myLongPress.addTarget(self, action: #selector(self.handleTap(_:)))
        mapView.addGestureRecognizer(myLongPress)
        
        let bigTeatr = MKPointAnnotation()
        bigTeatr.coordinate = CLLocationCoordinate2D(latitude: 55.7602196, longitude: 37.6186409)
        //mapView.showAnnotations([bigTeatr], animated: true)
        bigTeatr.title = "Teatr"
        
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
    }
    
    private func initialLayout() {
        NSLayoutConstraint.activate([
            self.button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard self.mapView == self.mapView else { return }
        mapView.frame = view.bounds
    }
    
    //Добавление точек
    @objc func handleTap(_ gestureReconizer: UILongPressGestureRecognizer) {
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        
        let locations = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        locations.fetchCityAndCountry{ city, country, error in //Страна и город
            guard let city = city, let country = country, error == nil else { return }
            
            //адреса и точные данные
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            location.placemark { placemark, error in
                guard let placemark = placemark else {
                    print("Error:", error ?? "nil")
                    return
                }
                
                DispatchQueue.main.async {
                    annotation.coordinate = coordinate
                    self.mapView.addAnnotation(annotation)
                    self.mapView.isZoomEnabled = true
                    self.mapView.isScrollEnabled = true
                    annotation.title = "\(placemark.streetName ?? "address not found") \(placemark.streetNumber ?? "")"
                    annotation.subtitle = "\(country) - \(city)"
                }
            }
        }
    }
    
    //Удаление точек и маршрута, кроме точки пользователя!
    @objc func handleTapButton(_ sender: UIButton) {
        self.mapView.annotations.forEach {
            if !($0 is MKUserLocation) {
                self.mapView.removeAnnotation($0)
                self.mapView.removeOverlays(mapView.overlays)
            }
        }
        print("Your annotations deleting")
    }
    
    
    //Построение маршрута
    //    func getDirection() {
    //        let annotationSPB = MKPointAnnotation()
    //        annotationSPB.coordinate = CLLocationCoordinate2D(latitude: 59.9339, longitude: 30.3061)
    //
    //        let annotationUser = MKPointAnnotation()//местоположение пользователя работает некорректно с симулятора, поэтому создал дефолтную точку чтобы не было ошибки! с реального устроиства все работает корректно!
    //        annotationUser.coordinate = locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 59.7234, longitude: 30.3271)
    //
    //        mapView.showAnnotations([annotationSPB, annotationUser], animated: true)
    //        let sourceItem  = MKMapItem(placemark: MKPlacemark(coordinate: annotationSPB.coordinate))
    //        let destItem = MKMapItem(placemark: MKPlacemark(coordinate: annotationUser.coordinate))
    //        let request = MKDirections.Request()
    //        request.source = sourceItem
    //        request.destination = destItem
    //        request.transportType = .walking
    //        let directions = MKDirections(request: request)
    //
    //        directions.calculate { responce, error in
    //            guard let responce = responce else { return }
    //            if responce.routes.count > 0 {
    //                let route = responce.routes.first!
    //                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
    //                let rect = route.polyline.boundingMapRect
    //                self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
    //            }
    //        }
    //    }
}

//Местоположение пользователя
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        mapView.mapType = MKMapType.standard
        mapView.showsCompass = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        //annotation.coordinate = locValue
        annotation.title = "Мое местоположение"
        annotation.subtitle = "iPhone"
        mapView.addAnnotation(annotation)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 3
        renderer.strokeColor = .systemBlue
        return renderer
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MKPointAnnotation else { return nil }
        
        var viewMaker: MKMarkerAnnotationView
        let idView = "marker"
        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: idView) as? MKMarkerAnnotationView {
            view.annotation = annotation
            viewMaker = view
        } else {
            viewMaker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: idView)
            viewMaker.canShowCallout = true
            viewMaker.calloutOffset = CGPoint(x: 0, y: 6)
            viewMaker.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return viewMaker
    }
    
    //изменение цвета булавки при выборе
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let view = view as? MKMarkerAnnotationView {
            view.markerTintColor = mapView.tintColor
        }
    }
    
    //возвращение цета булавки
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if let view = view as? MKMarkerAnnotationView {
            view.markerTintColor = UIColor.systemRed
        }
    }
}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
    
    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
}

extension CLPlacemark {
    var streetName: String? { thoroughfare }
    var streetNumber: String? { subThoroughfare }
    var city: String? { locality }
    var neighborhood: String? { subLocality }
    var state: String? { administrativeArea }
    var county: String? { subAdministrativeArea }
    var zipCode: String? { postalCode }
    
    @available(iOS 11.0, *)
    
    var postalAddressFormatted: String? {
        guard let postalAddress = postalCode else { return nil }
        return postalAddress
    }
    
    var streetNameFormatted: String? {
        guard let streetName = streetName else { return nil }
        return streetName
    }
    
    var streetNumberForamttes: String? {
        guard let streetNumber = streetNumber else { return nil}
        return streetNumber
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
