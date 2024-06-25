//
//  SupervisorDashBoardViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 20/05/2024.
//

import UIKit

class SupervisorDashBoardViewController: UIViewController {

    
    @IBOutlet weak var UICustimButtonMarkAttendance: UIView!
    @IBOutlet weak var lblSupervisorName: UILabel!
    @IBOutlet weak var UICustomButtonMyAttendance: UIView!
    @IBOutlet weak var UICustomButtonDefectMonitoring: UIView!
    @IBOutlet weak var UICustomButtonEmployeeMonitoring: UIView!
    var supervisorName = ""
    var supervisorId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        lblSupervisorName.text = supervisorName
        UICustomButtonEmployeeMonitoring.layer.cornerRadius = 20
        UICustomButtonMyAttendance.layer.cornerRadius = 20
        UICustomButtonDefectMonitoring.layer.cornerRadius = 20
        UICustimButtonMarkAttendance.layer.cornerRadius = 20
        UICustomButtonEmployeeMonitoring.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnNavigateToEmployeeMonitoring(_ :))))
        UICustomButtonMyAttendance.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnNavigateTOMyAttendance(_ :))))
        UICustomButtonDefectMonitoring.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnNavigateToDefectMonitoring(_ :))))
        UICustimButtonMarkAttendance.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnNavigateToMarkAttendance(_ :))))
    }
    @IBAction func btnLogout(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func btnNavigateToEmployeeMonitoring(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SupervisorEmployeeMonitoringViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
        
    }
    
    @objc func btnNavigateToDefectMonitoring(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SupervisorDefectMonitoringViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
        
    }
    
    @objc func btnNavigateTOMyAttendance(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "AttendanceViewController") as! AttendanceViewController
        controller.employeeName = self.supervisorName
        controller.employeeId = self.supervisorId
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
    @objc func btnNavigateToMarkAttendance(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MarkAttendanceViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
    }
    
}
