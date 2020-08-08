//
//  MapViewController.swift
//  AnimeShopsTravel
//
//  Created by 矢田　悠馬 on 2020/07/19.
//  Copyright © 2020 yuma yada. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    private var isFirst = false
    private let myView = MapView()
    private let customColor = CustomColor.mainColor
    
    override func loadView() {
        super.loadView()
        view = myView
        view.sendSubviewToBack(myView.mapView)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        if !isFirst {
            isFirst = true
            initMap()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        myView.mapView.delegate = self
        //initMap()
        setupLocationManager()
        settingShopPins()
        trackingButtonActionSet()
    }
    
}


extension MapViewController: MKMapViewDelegate {
    
    private func initMap() {
        var region: MKCoordinateRegion = myView.mapView.region
        region.span.latitudeDelta = 0.04
        region.span.longitudeDelta = 0.04
        myView.mapView.setRegion(region, animated: true)
        myView.mapView.showsUserLocation = true
        myView.mapView.userTrackingMode = .follow
    }
    
    
    private func trackingButtonActionSet() {
        myView.trackingButton.addTarget(self, action: #selector(trackingButtonTaped), for: .touchUpInside)
    }
    
    
    @objc func trackingButtonTaped() {
        switch myView.mapView.userTrackingMode{
            case .follow:
                myView.mapView.userTrackingMode = .followWithHeading
                let ImageHeadingUp = UIImage(named: "ImageHeadingUp")
                myView.trackingButton.setImage(ImageHeadingUp, for: .normal)
                break
            case.followWithHeading:
                myView.mapView.userTrackingMode = .none
                let ImageScrollMode = UIImage(named: "ImageScrollMode")
                myView.trackingButton.setImage(ImageScrollMode, for: .normal)
                break
            default:
                myView.mapView.userTrackingMode = .follow
                let ImageNorthUp = UIImage(named: "ImageNorthUp")
                myView.trackingButton.setImage(ImageNorthUp, for: .normal)
                break
        }
    }
    
    
     func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pinView.canShowCallout = true
        pinView.rightCalloutAccessoryView = myView.pinButton
        return pinView
    }
    
    
    private func settingShopPins() {
        for i in 0...ShopPinsData.nameDataArray.count - 1 {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(ShopPinsData.latitudeArray[i], ShopPinsData.longtudeArray[i])
            annotation.title = ShopPinsData.nameDataArray[i]
            annotation.subtitle = ShopPinsData.addressArray[i]
            myView.mapView.addAnnotation(annotation)
            myView.mapView.delegate = self
        }
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let title = view.annotation?.title else { return }
        if control != view.rightCalloutAccessoryView {
            return
        }
        for i in 0...ShopPinsData.nameDataArray.count - 1 {
            if title == ShopPinsData.nameDataArray[i] {
                let webVC = self.storyboard?.instantiateViewController(withIdentifier: "web")as! WebViewController
                webVC.shopUrl = ShopPinsData.urlArray[i]
                self.present(webVC, animated: true, completion: nil)
            }
        }
    }
    
    
}


extension MapViewController: CLLocationManagerDelegate {
    
    private func setupLocationManager() {
        let locManager = CLLocationManager()
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            let staus = CLLocationManager.authorizationStatus()
            if staus == .authorizedAlways || staus == .authorizedWhenInUse {
                locManager.startUpdatingLocation()
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if myView.mapView.userTrackingMode == .none{
            myView.trackingButton.setImage(UIImage(named: "ImageScrollMode"), for: .normal)
        }
        switch myView.mapView.userTrackingMode {
        case .followWithHeading:
            myView.mapView.userTrackingMode = .followWithHeading
            break
        case .follow:
            myView.mapView.userTrackingMode = .follow
            break
        default:
            break
        }
    }

}
