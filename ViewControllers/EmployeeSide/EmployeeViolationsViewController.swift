//
//  EmployeeViolationsViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/05/2024.
//

import UIKit

class EmployeeViolationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return violations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ViolationDetailViewController") as! ViolationDetailViewController
        controller.modalPresentationStyle = .fullScreen
        controller.employeeName = "Malik Umer"
        
        self.present(controller, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! ViolationTableViewCell
        cell.lblViolationName.text = violations[indexPath.row].rule_name
        cell.lblTime.text = violations[indexPath.row].time
        cell.lblDate.text = violations[indexPath.row].date
        cell.imageView?.image = UIImage(named: violations[indexPath.row].images[0])
        return cell
    }
    
    var violations = [Violation]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        violations.append(Violation(violation_id: 0, date: "2024-05-03", time: "10:30 AM", rule_name: "Mobile Usage", images: ["MobileUsageViolation"]))
        violations.append(Violation(violation_id: 0, date: "2024-04-23", time: "11:30 AM", rule_name: "Smoking", images: ["ViolationsSmoking"]))
        tableView.dataSource = self
        tableView.delegate = self
    }

}
