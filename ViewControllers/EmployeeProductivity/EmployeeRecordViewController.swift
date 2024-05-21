//
//  EmployeeRecordViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 13/05/2024.
//

import UIKit
import Kingfisher
import DropDown
class EmployeeRecordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(ceil(Double(employees.count) / 2))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 192
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! EmployeesDetailTableViewCell
        cell.UIContainer2.isHidden = true
        cell.UIContainer1.isHidden = false
        let regContainer1 = CustomTapGestureRecognizer(target: self, action: #selector(btnEmployeeDetails(_ :)))
        regContainer1.index = pos
        cell.UIContainer1.addGestureRecognizer(regContainer1)
        cell.Container1lblName.text = employees[pos].name
        cell.Container1JobRole.text = employees[pos].section_name
        cell.Container1Percentege.text = "\(employees[pos].productivity)%"
        let url = APIWrapper().getImageURL(imagePath: employees[pos].image)
        cell.container1ImageView.kf.setImage(with: url)
        cell.UIContainer1.tag = pos
        pos += 1
        if pos < employees.count{
            cell.UIContainer2.isHidden = false
            let regContainer2 = CustomTapGestureRecognizer(target: self, action: #selector(btnEmployeeDetails(_ :)))
            regContainer2.index = pos
            cell.UIContainer2.addGestureRecognizer(regContainer2)
            cell.Container2lblName.text = employees[pos].name
            cell.Container2JobRole.text = employees[pos].section_name
            cell.Container2Percentege.text = "\(employees[pos].productivity)%"
            let url = APIWrapper().getImageURL(imagePath: employees[pos].image)
            cell.Container2ImageView.kf.setImage(with: url)
            cell.UIContainer2.tag = pos
            pos += 1
        }
        return cell
    }
    @IBOutlet weak var txtSearchEmployee: UITexfield_Additions!
    let sectionDropDown = DropDown()
    @IBOutlet weak var lblDropDown: UILabel!
    @IBOutlet weak var DropDownView: UIView!
    var employees = [Employee]()
    var sectionNames = [String]()
    var pos = 0
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var UISearchBarContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        employees = EmployeeViewModel().getAllEmployees()
        sectionNames = SectionViewModel().getAllSectionNames(withStatus: 1)
        sectionDropDown.dataSource = sectionNames
        sectionDropDown.anchorView = self.DropDownView
        sectionDropDown.selectionAction  = { [unowned self] (index: Int, item: String) in
            lblDropDown.text = item
            pos = 0
            self.employees = EmployeeViewModel().getEmployees(withSection: item)
            self.tableView.reloadData()
        }
        sectionDropDown.bottomOffset = CGPoint(x: 0,
            y: (sectionDropDown.anchorView?.plainView.bounds.height)!)
        DropDownView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnShowDropDown(_ :))))
        UISearchBarContainer.layer.cornerRadius = 12
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 12
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func btnDropDown(_ sender: Any) {
        btnShowDropDown(sender)
    }
    
    @objc func btnShowDropDown(_ sender: Any){
        sectionDropDown.show()
    }
    
    @IBAction func textChangeSearchEmployee(_ sender: Any) {
        guard let searchtext = txtSearchEmployee.text, !txtSearchEmployee.text!.isEmpty,
              let sectionName = lblDropDown.text, !lblDropDown.text!.isEmpty, lblDropDown.text! != "All Sections"
        else{
            return
        }
        pos = 0
        self.employees = EmployeeViewModel().getEmployees(withSection: sectionName, andEmployeeName: searchtext)
        self.tableView.reloadData()
        if sectionName == ""{
            self.employees = EmployeeViewModel().getAllEmployees()
            self.tableView.reloadData()
        }
    }
    
    @objc func btnEmployeeDetails(_ sender: CustomTapGestureRecognizer){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeDetailViewController") as! EmployeeDetailViewController
        controller.modalPresentationStyle = .fullScreen
        controller.employeeName = self.employees[sender.index].name
        controller.employeeId = self.employees[sender.index].employee_id
        self.present(controller, animated: true)
    }
    
}


class CustomTapGestureRecognizer: UITapGestureRecognizer {
    var index: Int = 0
}
