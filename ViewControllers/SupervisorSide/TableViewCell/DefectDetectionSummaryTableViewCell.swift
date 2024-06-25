//
//  DefectDetectionSummaryTableViewCell.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 23/06/2024.
//

import UIKit

class DefectDetectionSummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDefectCount: UILabel!
    @IBOutlet weak var lblDefectName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func setupShadow() {
            // Clear previous shadows to avoid overlapping shadows on cell reuse
            self.layer.shadowPath = nil
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowRadius = 4
            self.layer.masksToBounds = false
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
        }
    
}
