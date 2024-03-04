//
//  ProductionViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/02/2024.
//

import UIKit

class ProductionViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return batches.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! BatchTableViewCell
        cell.lblBatchNumber.text = batches[indexPath.row]
        return cell
    }
    
    var batches = [String]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtSearchBatch: UITexfield_Additions!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearchBatch.layer.cornerRadius = 15
        batches.append("Batch#11320051123")
        batches.append("Batch#21320051123")
        batches.append("Batch#31320051123")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func btnCreateBatch(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CreateBatchViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
    }
    
}
