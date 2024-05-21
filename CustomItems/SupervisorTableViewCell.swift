//
//  SupervisorTableViewCell.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 23/02/2024.
//

import UIKit

class SupervisorTableViewCell: UITableViewCell {

    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var lblSections: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
