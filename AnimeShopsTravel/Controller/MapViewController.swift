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
    private let mainColor = CustomColor.mainColor
    private var locManager: CLLocationManager!
    @IBOutlet weak var trackingButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager = CLLocationManager()
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        initMap()
        settingShopPins()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    @IBAction func trackingButtonTaped(_ sender: Any) {
        switch mapView.userTrackingMode{
            case .follow:
                mapView.userTrackingMode = .followWithHeading
                let ImageHeadingUp = UIImage(named: "ImageHeadingUp")
                trackingButton.setImage(ImageHeadingUp, for: .normal)
                break
            case.followWithHeading:
                mapView.userTrackingMode = .none
                let ImageScrollMode = UIImage(named: "ImageScrollMode")
                trackingButton.setImage(ImageScrollMode, for: .normal)
                break
            default:
                mapView.userTrackingMode = .follow
                let ImageNorthUp = UIImage(named: "ImageNorthUp")
                trackingButton.setImage(ImageNorthUp, for: .normal)
                break
        }
    }
    
    
    
}


extension MapViewController: MKMapViewDelegate {
    
    private func initMap() {
        var region: MKCoordinateRegion = mapView.region
        region.span.latitudeDelta = 0.04
        region.span.longitudeDelta = 0.04
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    
     func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pinView.canShowCallout = true
        let pinButton = UIButton()
        pinButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        pinButton.setTitle("詳細", for: .normal)
        pinButton.setTitleColor(UIColor.white, for: .normal)
        pinButton.backgroundColor = mainColor
        pinView.rightCalloutAccessoryView = pinButton
        return pinView
    }
    
    
    private func settingShopPins() {
        for i in 0...ShopPinsData.nameDataArray.count - 1 {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(ShopPinsData.latitudeArray[i], ShopPinsData.longtudeArray[i])
            annotation.title = ShopPinsData.nameDataArray[i]
            annotation.subtitle = ShopPinsData.addressArray[i]
            mapView.addAnnotation(annotation)
            mapView.delegate = self
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
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
            break
        default:
            break
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if mapView.userTrackingMode == .none{
            trackingButton.setImage(UIImage(named: "ImageScrollMode"), for: .normal)
        }
        switch mapView.userTrackingMode {
        case .followWithHeading:
            mapView.userTrackingMode = .followWithHeading
            break
        case .follow:
            mapView.userTrackingMode = .follow
            break
        default:
            break
        }
    }
    
    
    
}
