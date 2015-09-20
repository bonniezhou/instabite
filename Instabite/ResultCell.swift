//
//  ResultCell.swift
//  Instabite
//
//  Created by Bonnie Zhou on 9/19/15.
//  Copyright (c) 2015 Bonnie Zhou. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var topLeft: UIImageView!
    @IBOutlet weak var topRight: UIImageView!
    @IBOutlet weak var bottomLeft: UIImageView!
    @IBOutlet weak var bottomRight: UIImageView!
    @IBOutlet weak var directionsButton: UIButton!
    
    func configure(text text: String?) {
        title?.text = text
    }
}
