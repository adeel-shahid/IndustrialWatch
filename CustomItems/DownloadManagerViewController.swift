//
//  DownloadManagerViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 19/04/2024.
//

import UIKit

class DownloadManagerViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        container.layer.cornerRadius = 15
        container.layer.borderWidth = 0.5
        container.layer.borderColor = UIColor.black.cgColor
    }

    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
