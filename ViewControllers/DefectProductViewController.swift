//
//  DefectProductViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 08/03/2024.
//

import UIKit

class DefectProductViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "DefectDetailsViewController") as! DefectDetailsViewController
        controller.productNumber = products[indexPath.row]
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! BatchTableViewCell
        cell.lblBatchNumber.text = products[indexPath.row]
        return cell
    }
    
    
    @IBOutlet weak var lblBatchNumber: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tbxSearchProductContainer: UIView!
    @IBOutlet weak var txtSearchProduct: UITextField!
    
    var products = [String]()
    var batchNumber : String = "Not Found"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbxSearchProductContainer.layer.cornerRadius = 15
        lblBatchNumber.text = batchNumber
        products.append("P#110212323")
        products.append("P#112212323")
        products.append("P#110212023")
        tableView.dataSource = self
        tableView.delegate = self
    }

    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
