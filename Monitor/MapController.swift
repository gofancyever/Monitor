//
//  MapController.swift
//  Monitor
//
//  Created by gaof on 2018/5/28.
//  Copyright © 2018年 gaof. All rights reserved.
//

import UIKit

class MapController: UIViewController {
    let pointAnnotation = MAPointAnnotation()
    override func viewDidLoad() {
        super.viewDidLoad()
        let mapView = MAMapView(frame: self.view.bounds)
        mapView.showsCompass = false
        var path = Bundle.main.bundlePath
        path.append("/style.data")
        let jsonData = NSData.init(contentsOfFile: path)
        mapView.setCustomMapStyleWithWebData(jsonData as Data?)
        mapView.customMapStyleEnabled = true;
        mapView.delegate = self
        
        
        pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: 39.979590, longitude: 116.352792)
        pointAnnotation.title = "地块S003-01"
        pointAnnotation.subtitle = "阜通东大街6号"
        mapView.addAnnotation(pointAnnotation)
        self.view.addSubview(mapView)
        
        mapView.showAnnotations([pointAnnotation], animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MapController:MAMapViewDelegate {
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        
        if annotation.isKind(of: MAPointAnnotation.self) {
            let pointReuseIndetifier = "pointReuseIndetifier"
            var annotationView: MAPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier) as! MAPinAnnotationView?
            
            if annotationView == nil {
                annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
            }
            annotationView!.image = UIImage(named: "annotation")
            annotationView!.centerOffset = CGPoint(x:0, y:-18)
            annotationView!.canShowCallout = true
            annotationView!.animatesDrop = true
            annotationView!.isDraggable = true
            annotationView!.rightCalloutAccessoryView = UIButton(type: UIButtonType.detailDisclosure)
            
            
            return annotationView!
        }
        
        return nil
    }
}
