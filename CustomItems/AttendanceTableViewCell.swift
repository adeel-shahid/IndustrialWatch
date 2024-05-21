//
//  AttendanceTableViewCell.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 19/05/2024.
//

import UIKit

class AttendanceTableViewCell: UITableViewCell {

    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
