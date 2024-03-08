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
        defects.append("SideCut")
        defects.append("Pinhole")
        tableView.dataSource = self
    }

    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
