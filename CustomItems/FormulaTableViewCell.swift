//
//  FormulaTableViewCell.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 07/03/2024.
//

import UIKit

class FormulaTableViewCell: UITableViewCell {

    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblMaterial: UILabel!
    @IBOutlet weak var lblserial: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
