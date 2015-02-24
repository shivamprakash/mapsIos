//
//  ViewController.swift
//  map
//
//  Created by student on 2/3/15.
//  Copyright (c) 2015 student. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController{

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        println("Insid super load")
        
        DataManger.getDataFromURLWithSuccess{(apiData) -> Void in
            let json = JSON(data: apiData)
            if let stopArray = json["stops"].array{
                var stops = [AppModel]()
                for stopDict in stopArray{
                    var stopId: Int32? = stopDict["id"].int32Value
                    var stopName: String? = stopDict["name"].stringValue
                    var stopLat: CLLocationDegrees? = stopDict["lat"].doubleValue
                    var stopLong: CLLocationDegrees? = stopDict["lng"].doubleValue
                    var stop = AppModel(id: stopId!,name: stopName!, latitude: stopLat!, longitude: stopLong!)
                    stops.append(stop)
                    println(stopDict["latitude"].doubleValue)
                    
                }
                self.plotStops(stops)
                println(stops.count)
            }
        }
        
           }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        println("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == .Authorized || status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
            println("Auth")
        }
    }
    func plotStops(stops: Array<AppModel>) -> Void{
        let manager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
        }
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            manager.requestWhenInUseAuthorization()
        }
        var annotationArray = [MKPointAnnotation]()
        var currentLatitude = 33.4500
        var currentLongitude =  -112.0667
        
        var latDelta = 0.25
        var longDelta = 0.25
        
        var currentLocationSpan: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(currentLatitude, currentLongitude)
        var currentRegion: MKCoordinateRegion = MKCoordinateRegionMake(currentLocation, currentLocationSpan)
        self.mapView.setRegion(currentRegion, animated: true)
        for stop in stops{
        var singleAnnotation = MKPointAnnotation()
        var stopLoc: CLLocationCoordinate2D = CLLocationCoordinate2DMake(stop.latitude, stop.longitude)
        println("Latitude: \(stop.latitude)  Longitude: \(stop.longitude)")
        singleAnnotation.coordinate = stopLoc
        singleAnnotation.title = stop.name
        annotationArray.append(singleAnnotation)
        }
        self.mapView.addAnnotations(annotationArray)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

