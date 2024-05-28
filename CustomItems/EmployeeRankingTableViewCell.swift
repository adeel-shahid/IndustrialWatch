//
//  EmployeeRankingTableViewCell.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/05/2024.
//

import UIKit

class EmployeeRankingTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblPer: UILabel!
    @IBOutlet weak var imageviewtag: UIImageView!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageContainer.layer.cornerRadius = imageContainer.frame.size.width / 2
        imageContainer.clipsToBounds = true
        imageContainer.layer.borderWidth = 1
        imageContainer.layer.borderColor = UIColor.black.cgColor
        imageview.isUserInteractionEnabled = true
        imageview.layer.cornerRadius = imageview.frame.size.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
