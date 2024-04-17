//
//  ProductDetailsViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 14/04/2024.
//

import UIKit

class ProductDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return batches.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "BatchesDetailViewController") as! BatchesDetailViewController
        controller.batchNumber = batches[indexPath.row].batch_number
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! BatchesTableViewCell
        cell.lblBatchNumber.text = "Batch#\(batches[indexPath.row].batch_number)"
        let color = UIColor.red.withAlphaComponent(0.2)
        let simpleColor = UIColor.clear
        if batches[indexPath.row].status == 1{
            cell.backgroundColor = color
        }else{
            cell.backgroundColor = simpleColor
        }
        return cell
    }
    

    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var UICustomButton: UIView!
    @IBOutlet weak var btnDefectedUICustomButton: UIView!
    
    @IBOutlet weak var tableview: UITableView!
    var product : Product = Product(name: "Not Found", product_number: "")
    var batches = [BatchStatus]()
    override func viewDidLoad() {
        super.viewDidLoad()
//        batches.append("120224103509")
//        batches.append("120224103510")
//        batches.append("120224103511")
        batches = BatchViewModel().getAllBatchesOf(productNumber: product.product_number)
        lblProductName.text = product.name
        btnDefectedUICustomButton.layer.cornerRadius = 13
        UICustomButton.layer.cornerRadius = 15
        UICustomButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnCreateBatch(_ :))))
        tableview.dataSource = self
        tableview.delegate = self
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func btnCreateBatch(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CreateOrAddBatchViewController") as! CreateOrAddBatchViewController
        controller.modalPresentationStyle = .fullScreen
        controller.product = product
        self.present(controller, animated: true)
    }
    
    
    
}
