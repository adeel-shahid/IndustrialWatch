//
//  AttendanceViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 19/05/2024.
//

import UIKit

class AttendanceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attendance.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! AttendanceTableViewCell
        cell.lblDate.text = attendance[indexPath.row].attendance_date
        cell.lblStatus.text = attendance[indexPath.row].status
        return cell
    }

    @IBOutlet weak var lblEmployeeName: UILabel!
    
    var attendance = [Attendance]()
    var employeeId = 0
    var employeeName = "Not Found"
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblEmployeeName.text = employeeName
        attendance = EmployeeViewModel().getEmployeeAttendance(employeeID: self.employeeId)
        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
