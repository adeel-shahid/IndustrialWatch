//
//  RulesAddorEditTableViewCell.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/02/2024.
//

import UIKit

class RulesAddorEditTableViewCell: UITableViewCell {

    @IBOutlet weak var lblRuleName: UILabel!
    @IBOutlet weak var btnCheckBoxOutlet: UIButton!
    @IBOutlet weak var txtTime: UITexfield_Additions!
    @IBOutlet weak var txtFine: UITexfield_Additions!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        txtFine.layer.cornerRadius = 10
        txtTime.layer.cornerRadius = 10
    }

    @IBAction func btnCheckBox(_ sender: Any) {
        btnCheckBoxOutlet.isSelected = !btnCheckBoxOutlet.isSelected
    }
}
