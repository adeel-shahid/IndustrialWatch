//
//  EmployeeRankingViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/05/2024.
//

import UIKit
import DropDown
import Kingfisher
class EmployeeRankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 59
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! EmployeeRankingTableViewCell
        cell.lblName.text = employees[indexPath.row].name
        cell.lblPer.text = "\(employees[indexPath.row].productivity)%"
        let url = APIWrapper().getImageURL(imagePath: employees[indexPath.row].image, employeeId: employees[indexPath.row].employee_id)
        cell.imageview.kf.setImage(with: url)
        if indexPath.row == 0{
            cell.imageviewtag.image = UIImage(named: "Top1")
        }else if indexPath.row == 1{
            cell.imageviewtag.image = UIImage(named: "Top2")
        }else if indexPath.row == 2{
            cell.imageviewtag.image = UIImage(named: "Top3")
        }
        return cell
    }
    @IBOutlet weak var lblDropDown: UILabel!
    let sectionDropDown = DropDown()
    var employees = [Employee]()
    var sectionNames = [String]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var DropDownView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employees = EmployeeViewModel().getAllEmployeesWithRanking()
        DropDownView.layer.cornerRadius = 15
        tableView.dataSource = self
        tableView.delegate = self
        sectionNames = SectionViewModel().getAllSectionNames(withStatus: 1)
        sectionDropDown.dataSource = sectionNames
        sectionDropDown.anchorView = self.DropDownView
        sectionDropDown.selectionAction  = { [unowned self] (index: Int, item: String) in
            lblDropDown.text = item
            self.employees = EmployeeViewModel().getEmployeesOfRanking(withSection: item)
            self.tableView.reloadData()
        }
        sectionDropDown.bottomOffset = CGPoint(x: 0,
            y: (sectionDropDown.anchorView?.plainView.bounds.height)!)
        DropDownView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnShowDropDown(_ :))))
    }

    @objc func btnShowDropDown(_ sender: Any){
        sectionDropDown.show()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func btnDropDown(_ sender: Any) {
        btnShowDropDown(UIButton())
    }
}
