//
//  EmployeeProductivityViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 26/04/2024.
//

import UIKit

class EmployeeProductivityViewController: UIViewController {

    @IBOutlet weak var btnEmployeeRanking: UIView!
    @IBOutlet weak var btnAddEmployee: UIView!
    @IBOutlet weak var btnEmployeesRecord: UIView!
    @IBOutlet weak var spliter: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        spliter.layer.cornerRadius = 45
        btnAddEmployee.layer.cornerRadius = 20
        btnEmployeeRanking.layer.cornerRadius = 20
        btnEmployeesRecord.layer.cornerRadius = 20
        btnAddEmployee.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigateToAddEmployyee(_ :))))
        btnEmployeesRecord.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigateToEmployyeeRecord(_ :))))
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @objc func navigateToAddEmployyee(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "AddEmployeeViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
    }
    @objc func navigateToEmployyeeRecord(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeRecordViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
    }
}
