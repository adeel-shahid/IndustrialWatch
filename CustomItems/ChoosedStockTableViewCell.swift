//
//  ChoosedStockTableViewCell.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 17/04/2024.
//

import UIKit

class ChoosedStockTableViewCell: UITableViewCell {

    @IBOutlet weak var btnChooseStock: UIButton!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSerial: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func btnChooseStockAction(_ sender: Any) {
        
    }
}
