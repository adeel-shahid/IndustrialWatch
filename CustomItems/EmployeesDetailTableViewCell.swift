//
//  EmployeesDetailTableViewCell.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 14/05/2024.
//

import UIKit

class EmployeesDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var UIContainer2: UIView!
    @IBOutlet weak var UIContainer1: UIView!
    
    @IBOutlet weak var Container2Percentege: UILabel!
    @IBOutlet weak var Container2JobRole: UILabel!
    @IBOutlet weak var Container2lblName: UILabel!
    @IBOutlet weak var Container2ImageView: UIImageView!
    @IBOutlet weak var Container1Percentege: UILabel!
    @IBOutlet weak var Container1JobRole: UILabel!
    @IBOutlet weak var Container1lblName: UILabel!
    @IBOutlet weak var container1ImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        UIContainer1.layer.cornerRadius = 10
        UIContainer2.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
