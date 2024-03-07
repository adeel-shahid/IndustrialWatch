//
//  BatchDetailViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 01/03/2024.
//

import UIKit

class BatchDetailViewController: UIViewController {

    @IBOutlet weak var outputYeildView: UIView!
    @IBOutlet weak var expectedYieldView: UIView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var lblBatchNumber: UILabel!
    var batch : String = "Not Found"
    override func viewDidLoad() {
        super.viewDidLoad()
        lblBatchNumber.text = batch
        productView.layer.cornerRadius = 20
        expectedYieldView.layer.cornerRadius = 20
        outputYeildView.layer.cornerRadius = 20
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
