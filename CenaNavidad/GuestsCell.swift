//
//  GuestsCell.swift
//  CenaNavidad
//
//  Created by PABLO GUARDADO ALVAREZ on 10/1/19.
//  Copyright © 2019 PABLO GUARDADO ALVAREZ. All rights reserved.
//

import UIKit

class GuestsCell: UITableViewCell {

    @IBOutlet weak var imgGuest: UIImageView!
    @IBOutlet weak var lblGuestsName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
