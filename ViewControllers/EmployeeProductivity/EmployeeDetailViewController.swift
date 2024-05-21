//
//  EmployeeDetailViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 18/05/2024.
//

import UIKit

class EmployeeDetailViewController: UIViewController {
    @IBOutlet weak var progressViewContainer: CircularProgressView!
    @IBOutlet weak var lblEmployeeName: UILabel!
    @IBOutlet weak var UICustomButtonAttendance: UIView!
    @IBOutlet weak var UICustomButtonSummary: UIView!
    @IBOutlet weak var UICustomButtonViolations: UIView!
    @IBOutlet weak var fineContainer: UIView!
    @IBOutlet weak var lblTotalFine: UILabel!
    var employeeId = 0
    var employeeName = "Not Found"
    var employeeDetail = EmployeeDetail(total_fine: 0.0, productivity: 0.0, total_attendance: "0.0")
    override func viewDidLoad() {
        super.viewDidLoad()
        fineContainer.layer.cornerRadius = 10
        fineContainer.layer.shadowColor = UIColor.black.cgColor
                fineContainer.layer.shadowOpacity = 0.5
                fineContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
                fineContainer.layer.shadowRadius = 4
        lblEmployeeName.text = employeeName
        employeeDetail = EmployeeViewModel().getEmployeeDetail(employeeID: employeeId)
        lblTotalFine.text = "\(employeeDetail.total_fine)"
        UICustomButtonAttendance.layer.cornerRadius = 10
        UICustomButtonViolations.layer.cornerRadius = 10
        UICustomButtonSummary.layer.cornerRadius = 10
        UICustomButtonAttendance.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnAttendance(_ :))))
        UICustomButtonViolations.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnViolations(_ :))))
        self.progressViewContainer.setProgressColor = UIColor.green
        self.progressViewContainer.setTrackColor = UIColor.gray
        self.progressViewContainer.setProgressWithAnimation(duration: 2.0, value: (self.employeeDetail.productivity / 100))
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func btnAttendance(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "AttendanceViewController") as! AttendanceViewController
        controller.modalPresentationStyle = .fullScreen
        controller.employeeId = self.employeeId
        controller.employeeName = self.employeeName
        self.present(controller, animated: true)
    }
    @objc func btnViolations(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ViolationsViewController") as! ViolationsViewController
        controller.modalPresentationStyle = .fullScreen
        controller.employeeId = self.employeeId
        controller.employeeName = self.employeeName
        self.present(controller, animated: true)
    }
}
