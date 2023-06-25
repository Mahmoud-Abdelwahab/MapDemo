//
//  ViewController.swift
//  MapDemo
//
//  Created by Mahmoud Abdulwahab on 24/06/2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: BMMapView!
    @IBOutlet weak var branchCardView: BranchCardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        
        //        Lat :   30.0352073
        //        Lng : 31.563370237647135
        
        
        /*
         let annotations = [BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 30.0352073, longitude: 31.563370237647135), title: "Helmy Map! 😂"),BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 30.0473100180001, longitude: 31.254554576), title: "Mahmoud Map! 😎"),BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 30.0347433160001, longitude: 31.236700326000), title: "Helmy Map! 😂"),BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 30.048063332, longitude: 31.2441669310001), title: "Helmy Map! 😂"),BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 30.048063332, longitude: 31.2441669310001), title: "Helmy Map! 😂"),BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 31.240075228, longitude: 29.955911126), title: "Helmy Map! 😂"),BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 31.240075228, longitude: 29.955911126), title: "Helmy Map! 😂"),BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 31.240075228, longitude: 29.955911126), title: "Helmy Map! 😂"),BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 31.0334879, longitude: 30.4520954), title: "Helmy Map! 😂")]
         */
        let annotation = BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 30.0352073, longitude: 31.563370237647135), title: "Helmy Map! 😂")
        let location = CLLocation(latitude: annotation.coordinate.latitude + 0.002, longitude:  annotation.coordinate.longitude)
        
        //   mapView.addAnnotation(annotation)
        mapView.shouldShowCalloutView(true)
        mapView.setDefaultPinIcon(with: UIImage(named: "map-pin-icon")!)
//        mapView.addAnnotations(bmAnnotations)
        mapView.drawAnnotations(bmAnnotations)
      //  mapView.centerToLocation(location, regionRadius: 50_000)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 8) { [weak self] in
//            self?.mapView.removeAnnotations(bmAnnotations)
//        }
        
        branchCardView.didTapOnCard = { [weak self] index in
            let branchAnnotation =  bmAnnotations[index]
            self?.mapView.selectMarker(branchAnnotation)
        }

    }

    @IBAction func addAction(_ sender: Any) {
        let branchAnnotation =  bmAnnotations.randomElement()!
        mapView.selectMarker(branchAnnotation)
    }
}


extension ViewController:  BMMapDelegate{
    
    func didSelectAnnotation(_ annotation: BMAnnotation) {
        print("Movingggggg",annotation)
    }
    
    func didDrageOnMap() {
        print("Movingggggg")
    }
    
    func didTapOnCalloutView(_ annotation: BMAnnotation) {
        print(annotation)
    }
}

let bankBranches: [CLLocationCoordinate2D] = [
    CLLocationCoordinate2D(latitude: 30.0626, longitude: 31.2497),
    CLLocationCoordinate2D(latitude: 30.0762, longitude: 31.3359),
    CLLocationCoordinate2D(latitude: 30.0595, longitude: 31.2345),
    CLLocationCoordinate2D(latitude: 30.0613, longitude: 31.2283),
    CLLocationCoordinate2D(latitude: 30.0573, longitude: 31.2449),
    CLLocationCoordinate2D(latitude: 30.0517, longitude: 31.2351),
    CLLocationCoordinate2D(latitude: 30.0451, longitude: 31.2312),
    CLLocationCoordinate2D(latitude: 30.0489, longitude: 31.2603),
    CLLocationCoordinate2D(latitude: 30.0456, longitude: 31.2427),
    CLLocationCoordinate2D(latitude: 30.0408, longitude: 31.2331),
    CLLocationCoordinate2D(latitude: 30.0435, longitude: 31.2303),
    CLLocationCoordinate2D(latitude: 30.0546, longitude: 31.2289),
    CLLocationCoordinate2D(latitude: 30.0364, longitude: 31.2097),
    CLLocationCoordinate2D(latitude: 30.0442, longitude: 31.2364),
    CLLocationCoordinate2D(latitude: 30.0437, longitude: 31.2141),
    CLLocationCoordinate2D(latitude: 30.0345, longitude: 31.2339),
    CLLocationCoordinate2D(latitude: 30.0301, longitude: 31.2357),
    CLLocationCoordinate2D(latitude: 30.0319, longitude: 31.2237),
    CLLocationCoordinate2D(latitude: 30.0403, longitude: 31.2113),
    CLLocationCoordinate2D(latitude: 30.0369, longitude: 31.2438),
    CLLocationCoordinate2D(latitude: 30.0577, longitude: 31.2485),
    CLLocationCoordinate2D(latitude: 30.0529, longitude: 31.2382),
    CLLocationCoordinate2D(latitude: 30.0400, longitude: 31.2246),
    CLLocationCoordinate2D(latitude: 30.0581, longitude: 31.2440),
    CLLocationCoordinate2D(latitude: 30.0512, longitude: 31.2575),
    CLLocationCoordinate2D(latitude: 30.0621, longitude: 31.1976),
    CLLocationCoordinate2D(latitude: 30.0617, longitude: 31.1962),
    CLLocationCoordinate2D(latitude: 30.0637, longitude: 31.2014),
    CLLocationCoordinate2D(latitude: 30.0583, longitude: 31.2239),
    CLLocationCoordinate2D(latitude: 30.0638, longitude: 31.2022)
]

var bmAnnotations = bankBranches.map( { BMAnnotation(coordinate: $0) } )




