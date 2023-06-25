//
//  BMMapView.swift
//  AppleMapFramework
//
//  Created by Mahmoud Abdulwahab on 22/06/2023.
//

import UIKit
import MapKit

public class BMMapView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak private var mapView: MKMapView!
    
    // MARK: - Properties
    public weak var delegate: BMMapDelegate?
    private var defaultPinIcon: UIImage?
    private var canShowCallout: Bool?
    private var lastSelectedAnnotationView: MKAnnotationView?
    
    // MARK: - Init 
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit() {
        setupUI()
    }
}

// MARK: - Configurations
extension BMMapView {
    
    func setupUI() {
        loadViewFromNib()
        mapView.delegate = self
    }
}


extension BMMapView: MKMapViewDelegate {
   
    // MARK: - MKMapViewDelegate
    
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        let bmAnnotation = BMAnnotation(
            coordinate: annotation.coordinate,
            title: annotation.title ?? nil,
            subtitle: annotation.subtitle ?? nil)
    
        delegate?.didSelectAnnotation(bmAnnotation)
    }
    
    public func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        delegate?.didDrageOnMap()
    }
    
    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if  let annotation = mapView.annotations.first(where: { !($0 is MKUserLocation) }) {
            mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation")

        if let canShowCallout = canShowCallout {
            annotationView.canShowCallout = canShowCallout
        }
        if let defaultPinIcon = defaultPinIcon {
            annotationView.image = defaultPinIcon
        }
        
        let button = AnnotationButton(type: .detailDisclosure)
        button.addTarget(self, action: #selector(pinAction(_:)), for: .touchUpInside)
        annotationView.rightCalloutAccessoryView = button
        if let pointAnnotation = annotation as? MKPointAnnotation {
            button.annotation = pointAnnotation
        }
        return annotationView
    }
    
    @objc private func pinAction(_ pinButton: AnnotationButton) {
        guard let annotationPointModel = pinButton.annotation else { return }
        let annotation = BMAnnotation(coordinate: annotationPointModel.coordinate, title: annotationPointModel.title, subtitle: annotationPointModel.subtitle)
        delegate?.didTapOnCalloutView(annotation)
    }
}


extension BMMapView: BMMapInputType {
    
    public func addAnnotations(_ annotations: [BMAnnotation]) {
        mapView.clearsContextBeforeDrawing = true

        annotations.forEach(addAnnotation)
    }
    
    public func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        print("💥", location, regionRadius)
    }
    
    public func addAnnotation(_ annotation: BMAnnotation) {
        let annotations = MKPointAnnotation()
        mapView.clearsContextBeforeDrawing = true

        annotations.title = annotation.title
        annotations.coordinate = annotation.coordinate
        mapView.addAnnotation(annotations)

        print("💥", annotation)
    }
    
    public func removeAnnotation(_ annotation: BMAnnotation) {
        print("💥", annotation)
    }
    
    public func removeAnnotations(_ annotations: [BMAnnotation]) {
        let annotations = annotations.map { $0.mapToMKAnnotation() }
        mapView.removeAnnotations(mapView.annotations)
        print("💥", annotations)
    }
    
    public func selectMarker(_ marker: BMAnnotation, zoomLevel: Double? = nil) {
       
        func getZoomLevel() -> Double {
            let camera = mapView.camera
            let altitude = camera.altitude
            let zoomLevel = log2(360 * ((Double(mapView.bounds.size.width) / 256) / altitude))
            return zoomLevel
        }
        
        let camera: MKMapCamera
        if let zoomLevel = zoomLevel {
            let currentZoom = getZoomLevel()
            let altitude = pow(2, currentZoom - zoomLevel) * (Double(mapView.bounds.size.width) / 2)
            camera = MKMapCamera(lookingAtCenter: marker.coordinate, fromDistance: altitude, pitch: 0, heading: 0)
        } else {
            camera = MKMapCamera(lookingAtCenter: marker.coordinate, fromDistance: mapView.camera.altitude, pitch: 0, heading: 0)
        }
        mapView.setCamera(camera, animated: true)
        
        // Reset the previous annotation view's scaling
        if let lastAnnotationView = lastSelectedAnnotationView {
            UIView.animate(withDuration: 0.1) {
                lastAnnotationView.transform = CGAffineTransform.identity
            }
        }
        // Scale the selected annotation
        let selectedScale: CGFloat = 1.5
        let anno =  mapView.annotations.first(where: { $0.coordinate.latitude == marker.mapToMKAnnotation().coordinate.latitude && $0.coordinate.longitude == marker.mapToMKAnnotation().coordinate.longitude })!
        
        if  let selectedAnnotationView = mapView.view(for: anno) {
            let transform = CGAffineTransform(scaleX: selectedScale, y: selectedScale)
            selectedAnnotationView.layer.zPosition = .greatestFiniteMagnitude + 10000
            selectedAnnotationView.bringSubviewToFront(self)
            UIView.animate(withDuration: 0.3) {
                selectedAnnotationView.transform = transform
            }
            lastSelectedAnnotationView = selectedAnnotationView
        } else {
            print("💥 -  can't find location")
        }
    }
    
    
    public func animateToCoordinate(_ coordinate: CLLocationCoordinate2D, withZoomLevel zoomLevel: Double) {
        print("💥", coordinate, zoomLevel)
    }
    
    public func drawAnnotations(_ annotations: [BMAnnotation]) {
        mapView.clearsContextBeforeDrawing = true

        let annotations = annotations.map { $0.mapToMKAnnotation() }
        print("💥",annotations)
        mapView.removeAnnotations(mapView.annotations) // Clear existing annotations
        mapView.addAnnotations(annotations) // Add branch annotations
        
        var zoomRect = MKMapRect.null
        
        for branch in annotations {
            let annotationPoint = MKMapPoint(branch.coordinate)
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.1, height: 0.1)
            zoomRect = zoomRect.union(pointRect)
        }
        
        mapView.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 50, left: 16, bottom: 50, right: 16), animated: true)
        
    }
    
    public func fitAnnotationsOnScreen() {
        print("💥")
    }
    
    
    
    public func setDefaultPinIcon(with icon: UIImage) {
        defaultPinIcon = icon
    }
    
    public func shouldShowCalloutView(_ isShown: Bool) {
        canShowCallout = isShown
    }
}


final class AnnotationButton: UIButton {
    var annotation: MKPointAnnotation?
}


