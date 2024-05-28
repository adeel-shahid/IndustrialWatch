//
//  EmployeeAttendanceViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/05/2024.
//

import UIKit

class EmployeeAttendanceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
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
    
    var attendance = [Attendance]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let obj = UserDefaults.standard
        let employeeId = obj.integer(forKey: "employeeId")
        attendance = EmployeeViewModel().getEmployeeAttendance(employeeID: employeeId)
        tableView.dataSource = self
        tableView.delegate = self
    }

}
