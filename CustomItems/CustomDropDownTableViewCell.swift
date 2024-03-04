//
//  CustomDropDownTableViewCell.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 01/03/2024.
//

import UIKit

class CustomDropDownTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCheckbox: UILabel!
    @IBOutlet weak var btnCheckbox: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func btnCheckboxAction(_ sender: Any) {
    }
}
