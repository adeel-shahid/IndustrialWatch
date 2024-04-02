//
//  Slide.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/03/2024.
//

import UIKit

class Slide: UIView {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var defectCaptureTime: UILabel!
    @IBOutlet weak var defectAngle: UILabel!
    public func createSlides() -> [Slide] {

            let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide1.imageView.image = UIImage(named: "Defect1")
        slide1.defectAngle.text = "Front"
        slide1.defectCaptureTime.text = "10:00"
            
            let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide2.imageView.image = UIImage(named: "Defect2")
        slide2.defectAngle.text = "Back"
        slide2.defectCaptureTime.text = "10:01"
            let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide3.imageView.image = UIImage(named: "Defect3")
        slide3.defectAngle.text = "Left"
        slide3.defectCaptureTime.text = "10:02"
            let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide4.imageView.image = UIImage(named: "Defect4")
        slide4.defectAngle.text = "Right"
        slide4.defectCaptureTime.text = "10:03"
            
            let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide5.imageView.image = UIImage(named: "Defect5")
        slide5.defectAngle.text = "Top"
        slide5.defectCaptureTime.text = "10:04"
        
        let slide6:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide6.imageView.image = UIImage(named: "Defect6")
    slide6.defectAngle.text = "Bottom"
    slide6.defectCaptureTime.text = "10:05"
            return [slide1, slide2, slide3, slide4, slide5,slide6]
        }

}
