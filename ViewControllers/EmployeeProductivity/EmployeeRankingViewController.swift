//
//  EmployeeRankingViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/05/2024.
//

import UIKit

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
        cell.lblPer.text = employees[indexPath.row].per
        cell.imageview.image = UIImage(named: "Person")
        if indexPath.row == 0{
            cell.imageviewtag.image = UIImage(named: "Top1")
        }else if indexPath.row == 1{
            cell.imageviewtag.image = UIImage(named: "Top2")
        }else if indexPath.row == 2{
            cell.imageviewtag.image = UIImage(named: "Top3")
        }
        return cell
    }
    
    var employees = [EmployeeRanking]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var DropDownView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        employees.append(EmployeeRanking(name: "Muhammad Anees", per: "95 %"))
        employees.append(EmployeeRanking(name: "Usama Fayyaz", per: "90 %"))
        employees.append(EmployeeRanking(name: "Abdullah", per: "80 %"))
        employees.append(EmployeeRanking(name: "Adeel Shahid Khan", per: "75 %"))
        DropDownView.layer.cornerRadius = 15
        tableView.dataSource = self
        tableView.delegate = self
    }

}
