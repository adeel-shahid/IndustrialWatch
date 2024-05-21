//
//  ViolationsViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 19/05/2024.
//

import UIKit

class ViolationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return violations.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! ViolationTableViewCell
        cell.lblViolationName.text = violations[indexPath.row].rule_name
        cell.lblTime.text = violations[indexPath.row].time
        cell.lblDate.text = violations[indexPath.row].date
        let url = APIWrapper().getViolationImageURL(imagePath: violations[indexPath.row].images[0])
        cell.UIImageView.kf.setImage(with: url)
        return cell
    }
    
    @IBOutlet weak var lblEmployeeName: UILabel!
    var employeeId = 0
    var employeeName = "Not Found"
    var violations = [Violation]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblEmployeeName.text = employeeName
        violations = EmployeeViewModel().getEmployeeViolations(employeeId: employeeId)
        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
