//
//  SectionsTableViewCell.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/02/2024.
//

import UIKit

class SectionsTableViewCell: UITableViewCell {

    @IBOutlet weak var btnDeleteOutlet: UIButton!
    @IBOutlet weak var btnEditOutlet: UIButton!
    @IBOutlet weak var lblSectionName: UILabel!
    var sectionName : String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        lblSectionName.text = sectionName
    }
    
    
    
}
