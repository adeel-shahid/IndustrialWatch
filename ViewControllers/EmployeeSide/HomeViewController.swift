//
//  HomeViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/05/2024.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var lblTotalAttendance: UILabel!
    @IBOutlet weak var lblTotalFine: UILabel!
    @IBOutlet weak var lblEmployeeName: UILabel!
    @IBOutlet weak var attendanceContainer: UIView!
    @IBOutlet weak var fineContainer: UIView!
    @IBOutlet weak var circularView: CircularProgressView!
    var employeeId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let objUserDefault = UserDefaults.standard
        if let name = objUserDefault.string(forKey: "username"){
            lblEmployeeName.text = name
            employeeId = objUserDefault.integer(forKey: "employeeId")
            let employeeDetail = EmployeeViewModel().getEmployeeDetail(employeeID: employeeId)
            lblTotalFine.text = "\(employeeDetail.total_fine)"
            lblTotalAttendance.text = "\(employeeDetail.total_attendance)"
            circularView.setProgressColor = UIColor.green
            circularView.setTrackColor = UIColor.gray
            circularView.setProgressWithAnimation(duration: 2.0, value: Float(employeeDetail.productivity / 100))
        }
        fineContainer.layer.cornerRadius = 10
        fineContainer.layer.shadowColor = UIColor.black.cgColor
        fineContainer.layer.shadowOpacity = 0.5
        fineContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        fineContainer.layer.shadowRadius = 4
        attendanceContainer.layer.cornerRadius = 10
        attendanceContainer.layer.shadowColor = UIColor.black.cgColor
        attendanceContainer.layer.shadowOpacity = 0.5
        attendanceContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        attendanceContainer.layer.shadowRadius = 4
    }

}
