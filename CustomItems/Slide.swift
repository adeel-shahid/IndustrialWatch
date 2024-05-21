//
//  Slide.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/03/2024.
//

import UIKit

class Slide: UIView {

    @IBOutlet weak var imageView: UIImageView!

    public func createSlides() -> [Slide] {

            let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide1.imageView.image = UIImage(named: "Defect1")
            
            let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide2.imageView.image = UIImage(named: "Defect2")
            let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide3.imageView.image = UIImage(named: "Defect3")
            let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide4.imageView.image = UIImage(named: "Defect4")
            
            let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide5.imageView.image = UIImage(named: "Defect5")
        
        let slide6:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide6.imageView.image = UIImage(named: "Defect6")
            return [slide1, slide2, slide3, slide4, slide5,slide6]
        }

}
