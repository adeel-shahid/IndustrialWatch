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
        let obj = UserDefaults.standard
        if let name = obj.string(forKey: "username"){
            controller.employeeName = name
            controller.violationId = self.violations[indexPath.row].violation_id
            self.present(controller, animated: true)
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! ViolationTableViewCell
        cell.lblViolationName.text = violations[indexPath.row].rule_name
        cell.lblTime.text = violations[indexPath.row].start_time
        cell.lblDate.text = violations[indexPath.row].date
        if let url = violations[indexPath.row].images[0].image_url{
            let url = APIWrapper().getViolationImageURL(imagePath: url)
            cell.UIImageView.kf.setImage(with: url)
        }
        return cell
    }
    
    var violations = [Violation]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let obj = UserDefaults.standard
        let employeeId = obj.integer(forKey: "employeeId")
        violations = EmployeeViewModel().getEmployeeViolations(employeeId: employeeId)
        tableView.dataSource = self
        tableView.delegate = self
    }

}
