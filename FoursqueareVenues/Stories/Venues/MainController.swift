//
//  MainController.swift
//  FoursqueareVenues
//
//  Created by Miguel Orjuela on 9/2/19.
//  Copyright © 2019 Miguel Orjuela. All rights reserved.
//

import UIKit
import Pulley

class MainController: PulleyViewController {
    
    private let presenter = VenuesPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animationDuration = 0.8
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueToList" {
            if let viewController = segue.destination as? VenuesViewController {
                viewController.presenter = self.presenter
            }
        } else if segue.identifier == "segueToMap" {
            if let viewController = segue.destination as? MapViewController {
                viewController.presenter = self.presenter
            }
        }
    }
}

