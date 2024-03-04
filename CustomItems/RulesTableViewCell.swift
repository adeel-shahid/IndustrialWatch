//
//  RulesTableViewCell.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/02/2024.
//

import UIKit

class RulesTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFine: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblRuleName: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
