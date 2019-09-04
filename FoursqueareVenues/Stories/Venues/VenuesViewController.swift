//
//  VenuesViewController.swift
//  FoursqueareVenues
//
//  Created by Miguel Orjuela on 9/3/19.
//  Copyright © 2019 Miguel Orjuela. All rights reserved.
//

import UIKit
import Pulley

class VenuesViewController: UIViewController {
    
    @IBOutlet weak var venuesTableView: UITableView!
    
    var presenter: VenuesPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        venuesTableView.register(UINib(nibName: "VenueTableViewCell", bundle: nil), forCellReuseIdentifier: "venueCell")
        venuesTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: venuesTableView.frame.width, height: 30))
        
        presenter?.getVenues {
            
            DispatchQueue.main.async {
                self.venuesTableView.dataSource = self
                self.venuesTableView.delegate = self
                self.venuesTableView.reloadData()
            }
        }
    }
}

extension VenuesViewController: PulleyDrawerViewControllerDelegate {
    
    func supportedDrawerPositions() -> [PulleyPosition] {
        
        return [PulleyPosition.collapsed, PulleyPosition.open]
    }
    
    func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat {
        
        return 120
    }
}

extension VenuesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter == nil ? 0 : presenter!.venues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "venueCell", for: indexPath) as! VenueTableViewCell
        
        if let venue = presenter?.venues[indexPath.row] {
            cell.configure(venue: venue)
        }
        
        return cell
    }
}

extension VenuesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let venue = presenter?.venues[indexPath.row] {
            presenter?.selectVenue(venue)
        }
    }
}
