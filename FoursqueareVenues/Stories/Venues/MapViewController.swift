//
//  MapViewController.swift
//  FoursqueareVenues
//
//  Created by Miguel Orjuela on 9/3/19.
//  Copyright © 2019 Miguel Orjuela. All rights reserved.
//

import UIKit
import Pulley
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!

    var presenter: VenuesPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.mapViewController = self
        
        presenter?.getInitialLocalization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.pulleyViewController?.displayMode = .drawer
    }
    
    func centerMap() {
        guard let region = presenter?.currentRegion else { return }
        
        DispatchQueue.main.async {
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    func showVenues() {
        
        guard let presenter = presenter else { return }
        
        DispatchQueue.main.async {
            self.mapView.addAnnotations(presenter.venuesAnnotations)
        }
    }
    
    func showSelectedAnnotation(_ annotation: Annotation) {
        DispatchQueue.main.async {
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
}
