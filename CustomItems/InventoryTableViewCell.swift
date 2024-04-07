//
//  InventoryTableViewCell.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 05/04/2024.
//

import UIKit

class InventoryTableViewCell: UITableViewCell {

    @IBOutlet weak var btnDetailsOutlet: UIButton!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSerial: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func btnDetails(_ sender: Any) {
    }
    
    
}
