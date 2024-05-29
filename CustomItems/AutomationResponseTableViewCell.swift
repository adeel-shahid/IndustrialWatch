//
//  AutomationResponseTableViewCell.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 28/05/2024.
//

import UIKit

class AutomationResponseTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTotalTime: UILabel!
    @IBOutlet weak var lblRuleName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
