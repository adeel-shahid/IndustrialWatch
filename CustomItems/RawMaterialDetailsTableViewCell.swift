//
//  RawMaterialDetailsTableViewCell.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 05/04/2024.
//

import UIKit

class RawMaterialDetailsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblSerial: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
