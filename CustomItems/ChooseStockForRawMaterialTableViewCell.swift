//
//  ChooseStockForRawMaterialTableViewCell.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 17/04/2024.
//

import UIKit

class ChooseStockForRawMaterialTableViewCell: UITableViewCell {

    @IBOutlet weak var btnCheckBoxOutlet: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblStockNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func btnCheckBox(_ sender: Any) {
        btnCheckBoxOutlet.isSelected = !btnCheckBoxOutlet.isSelected
    }
}
