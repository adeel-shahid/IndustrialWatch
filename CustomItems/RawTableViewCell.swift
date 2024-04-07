//
//  RawTableViewCell.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 04/04/2024.
//

import UIKit

class RawTableViewCell: UITableViewCell {

    @IBOutlet weak var btnEditOutlet: UIButton!
    @IBOutlet weak var lblRawMaterialName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func btnEdit(_ sender: Any) {
    }
}
