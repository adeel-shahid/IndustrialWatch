//
//  ViolationTableViewCell.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 19/05/2024.
//

import UIKit

class ViolationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblViolationName: UILabel!
    @IBOutlet weak var UIImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        UIImageView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
