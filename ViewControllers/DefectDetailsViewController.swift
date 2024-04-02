//
//  DefectDetailsViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 08/03/2024.
//

import UIKit

class DefectDetailsViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! DefectsTableViewCell
        cell.lblDefectName.text = defects[indexPath.row]
        return cell
    }
    

    @IBOutlet weak var imageView4Container: UIView!
    @IBOutlet weak var lblProductNumber: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var productNumber : String = "Not Found"
    var defects = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblProductNumber.text = productNumber
        imageView1.layer.cornerRadius = 10
        imageView2.layer.cornerRadius = 10
        imageView3.layer.cornerRadius = 10
        imageView4Container.layer.cornerRadius = 10
        
        imageView4.isUserInteractionEnabled = true
        defects.append("SideCut")
        defects.append("Pinhole")
        tableView.dataSource = self
        imageView4.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMoreImages(_ :))))
    }

    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
 
    
    @objc func showMoreImages(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ImageDetailsViewController") as! ImageDetailsViewController
        controller.modalPresentationStyle = .fullScreen
        controller.productNumber = lblProductNumber.text!
        self.present(controller, animated: true)
    }
    
}
