//
//  SupervisorDefectMonitoringViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/05/2024.
//

import UIKit

class SupervisorDefectMonitoringViewController: UIViewController {

    @IBOutlet weak var btnMultiple: UIView!
    @IBOutlet weak var UICustomButtonStartScanning: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UICustomButtonStartScanning.layer.cornerRadius = 15
        btnMultiple.layer.cornerRadius = 15
        UICustomButtonStartScanning.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnScanning(_ :))))
        btnMultiple.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnMultipleAngleMonitoring(_ :))))
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func btnScanning(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ScanningViewController") as! ScanningViewController
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
    @objc func btnMultipleAngleMonitoring(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MultipleAngleMonitoringViewController") as! MultipleAngleMonitoringViewController
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
}
