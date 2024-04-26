//
//  ProductDetailsViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 14/04/2024.
//

import UIKit
import Toast_Swift
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
        cell.lblBatchNumber.text = "\(batches[indexPath.row].batch_number)"
        let rejectedColor = UIColor.red.withAlphaComponent(0.2)
        let acceptedColor = UIColor.green.withAlphaComponent(0.2)
        let simpleColor = UIColor.gray.withAlphaComponent(0.2)
        if batches[indexPath.row].status == 1{
            cell.backgroundColor = rejectedColor
        }else if batches[indexPath.row].status == 0{
            cell.backgroundColor = acceptedColor
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
        StaticItems.product = product
        btnDefectedUICustomButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(downloadZipImages(_ :))))
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
        StaticItems.product = Product(name: "Not Found", product_number: "")
    }
    
    @objc func btnCreateBatch(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CreateOrAddBatchViewController") as! CreateOrAddBatchViewController
        controller.modalPresentationStyle = .fullScreen
        controller.product = product
        controller.messagePredicate = {[unowned self] in
            view.makeToast("Batches Created SuccessFully", duration: 3, position: .bottom)
            batches = BatchViewModel().getAllBatchesOf(productNumber: product.product_number)
            tableview.reloadData()
        }
        self.present(controller, animated: true)
    }
    
    @objc func downloadZipImages(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "DownloadManagerViewController")
        controller?.modalPresentationStyle = .overFullScreen
        self.present(controller!, animated: false)
    }
    
    
}
