//
//  EmployeeSummaryViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/05/2024.
//

import UIKit

class EmployeeSummaryViewController: UIViewController {

    @IBOutlet weak var attendanceContainer: UIView!
    @IBOutlet weak var ViolationContainer: UIView!
    @IBOutlet weak var totalFineContainer: UIView!
    @IBOutlet weak var circularView: CircularProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        totalFineContainer.layer.cornerRadius = 10
        totalFineContainer.layer.shadowColor = UIColor.black.cgColor
        totalFineContainer.layer.shadowOpacity = 0.5
        totalFineContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        totalFineContainer.layer.shadowRadius = 4
        ViolationContainer.layer.cornerRadius = 10
        ViolationContainer.layer.shadowColor = UIColor.black.cgColor
        ViolationContainer.layer.shadowOpacity = 0.5
        ViolationContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        ViolationContainer.layer.shadowRadius = 4
        attendanceContainer.layer.cornerRadius = 10
        attendanceContainer.layer.shadowColor = UIColor.black.cgColor
        attendanceContainer.layer.shadowOpacity = 0.5
        attendanceContainer.layer.shadowOffset = CGSize(width: 0, height: 2)
        attendanceContainer.layer.shadowRadius = 4
        circularView.setProgressColor = UIColor.green
        circularView.setTrackColor = UIColor.gray
        circularView.setProgressWithAnimation(duration: 2.0, value: ((25 * 100) / 30) / 100)
    }

}
