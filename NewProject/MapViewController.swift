//
//  MapViewController.swift
//  NewProject
//
//  Created by Monkeyli on 6/9/2017.
//  Copyright © 2017年 monkey. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var bt_move: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 22.3380838, longitude: 114.18186)
        
        let regionRadius: CLLocationDistance = 300
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(
            initialLocation.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        
        mapView.setRegion(coordinateRegion, animated: true)
        // Do any additional setup after loading the view.
        
        
        let waiHang = MKPointAnnotation()
        
        waiHang.coordinate = CLLocationCoordinate2D(latitude: 22.3380838, longitude: 114.18186)
        waiHang.title = "Wai Hang"
        waiHang.subtitle = "Sports Center"
        
        mapView.addAnnotation(waiHang)
        mapView.showsUserLocation = true
        mapView.delegate = self
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
    
    @IBAction func bt_click(_ sender: Any) {
       bt_move.setTitle("Done", for: .normal)
        
        let nextLocation = CLLocation(latitude: 22.339468, longitude: 114.181879)
        
        let regionRadius: CLLocationDistance = 300
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(
            nextLocation.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        
        let identifier = "pin"
        
        var view: MKPinAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            
            dequeuedView.annotation = annotation
            view = dequeuedView
            
        } else {
            
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        self.performSegue(withIdentifier: "showLogin", sender: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    /*
     @IBAction func bt_click(_ sender: Any) {
     //   bt_move.setTitle("Done", for: .normal)
     
     let nextLocation = CLLocation(latitude: 22.339468, longitude: 114.181879)
     
     let regionRadius: CLLocationDistance = 300
     
     let coordinateRegion = MKCoordinateRegionMakeWithDistance(
     nextLocation.coordinate, regionRadius * 2.0, regionRadius * 2.0)
     
     mapView.setRegion(coordinateRegion, animated: true)
     }
     */
    
}

