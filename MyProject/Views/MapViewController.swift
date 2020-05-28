//
//  MapViewController.swift
//  MyProject
//
//  Created by Dev on 27.05.2020.
//  Copyright © 2020 Dev. All rights reserved.
//

import UIKit
import MapKit
import RxCocoa

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var mapViewModel: MapViewModel!

    @IBOutlet weak var userImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem(
            title: "text",
            style: .plain,
            target: nil,
            action: nil
        );

        self.navigationItem.backBarButtonItem = backButton
//        self.navigationItem.setLeftBarButton(backButton, animated: true)

        mapViewModel.bindBackButton(backTap: backButton.rx.tap)
        let annotation: MKPointAnnotation = MKPointAnnotation()

        let location = mapViewModel.user.location

        let lat = ((location?.coordinates.latitude!)! as NSString).doubleValue
        let lon = ((location?.coordinates.longitude!)! as NSString).doubleValue

        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: lat)!, longitude: CLLocationDegrees(exactly: lon)!)
        self.mapView.addAnnotation(annotation)
        self.mapView.camera.centerCoordinate = annotation.coordinate
        userImage.load(url: URL(string: mapViewModel.user.picture.large!)!)
    }


     
}
