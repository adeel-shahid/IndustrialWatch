//
//  SupervisorDefectMonitoringViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/05/2024.
//

import UIKit

class SupervisorDefectMonitoringViewController: UIViewController {

    @IBOutlet weak var UICustomButtonStartScanning: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UICustomButtonStartScanning.layer.cornerRadius = 15
        UICustomButtonStartScanning.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnScanning(_ :))))
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func btnScanning(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ScanningViewController") as! ScanningViewController
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
}
