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
import RxSwift
class MapViewController: UIViewController {


    // MARK: Coordinator

    weak var coordinator: MapCoordinator?

    @IBOutlet weak var mapView: MKMapView!
    var mapViewModel: MapViewModel!

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var segmentControl: UISegmentedControl!

    let disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        );

        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.setBackgroundImage(UIImage(named: "arrow-left"), for: .normal, style: .plain, barMetrics: .default)

//        self.navigationItem.setLeftBarButton(backButton, animated: true)

        mapViewModel.bindBackButton(backTap: backButton.rx.tap) {
            index in
            self.coordinator?.showMain(selectedIndex: index)
        }
        let annotation: MKPointAnnotation = MKPointAnnotation()

        let location = mapViewModel.user.location

        let lat = ((location?.coordinates.latitude!)! as NSString).doubleValue
        let lon = ((location?.coordinates.longitude!)! as NSString).doubleValue

        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: lat)!, longitude: CLLocationDegrees(exactly: lon)!)
        self.mapView.addAnnotation(annotation)
        self.mapView.camera.centerCoordinate = annotation.coordinate
        userImage.load(url: URL(string: mapViewModel.user.picture.large!)!)
        mapViewModel.delegate = self
        segmentControl
            .rx
            .selectedSegmentIndex
            .subscribe(onNext: { (value) in
                self.setIndex(index: value)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)

    }

}

extension MapViewController: MapViewModelDelegate {
    func setIndex(index: Int) {
        mapViewModel.setSegmentIndex(index)
    }
}

extension MapViewController: Storyboarded {
    
}
