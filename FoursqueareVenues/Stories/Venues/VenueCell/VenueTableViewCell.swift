//
//  VenueTableViewCell.swift
//  FoursqueareVenues
//
//  Created by Miguel Orjuela on 9/3/19.
//  Copyright © 2019 Miguel Orjuela. All rights reserved.
//

import UIKit
import SDWebImage

class VenueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        venueImage.layer.cornerRadius = (venueImage.frame.width / 2)
        venueImage.layer.masksToBounds = true
    }
    
    func configure(venue: Venue) {
        
        if !venue.categories.isEmpty {
            venueImage.sd_setImage(with: URL(string: venue.categories[0].icon.url))
        }
        nameLabel.text = venue.name
        addressLabel.text = venue.location.formattedAddress.count > 0 ? venue.location.formattedAddress[0] : ""
        zipLabel.text = venue.location.formattedAddress.count > 1 ? venue.location.formattedAddress[1] : ""
        distanceLabel.text = "\(String(format: "%.2f", venue.distanceFromOrigin ?? 0)) km."
    }
}
