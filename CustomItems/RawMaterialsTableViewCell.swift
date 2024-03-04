//
//  RawMaterialsTableViewCell.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 01/03/2024.
//

import UIKit

class RawMaterialsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQuantityPerItem: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
