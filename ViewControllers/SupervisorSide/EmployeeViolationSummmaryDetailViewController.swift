//
//  EmployeeViolationSummmaryDetailViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 23/06/2024.
//

import UIKit

class EmployeeViolationSummmaryDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeData.rules.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! ViolationSummaryDetailTableViewCell
        cell.lblRuleName.text = employeeData.rules[indexPath.row].rule_name
        cell.lblSeconds.text = "\(employeeData.rules[indexPath.row].total_time) s"
        return cell
    }
    

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var employeeData = EmployeeData(employee_name: "", rules: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = employeeData.employee_name
        tableView.dataSource = self
        tableView.delegate = self
    }

    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
