//
//  SupervisorDashBoardViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 20/05/2024.
//

import UIKit

class SupervisorDashBoardViewController: UIViewController {

    
    @IBOutlet weak var lblSupervisorName: UILabel!
    @IBOutlet weak var UICustomButtonMyAttendance: UIView!
    @IBOutlet weak var UICustomButtonDefectMonitoring: UIView!
    @IBOutlet weak var UICustomButtonEmployeeMonitoring: UIView!
    var supervisorName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        lblSupervisorName.text = supervisorName
        UICustomButtonEmployeeMonitoring.layer.cornerRadius = 20
        UICustomButtonMyAttendance.layer.cornerRadius = 20
        UICustomButtonDefectMonitoring.layer.cornerRadius = 20
    }
    @IBAction func btnLogout(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
