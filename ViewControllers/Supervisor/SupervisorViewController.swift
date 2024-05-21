//
//  SupervisorViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/02/2024.
//

import UIKit

class SupervisorViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supervisors.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! SupervisorTableViewCell
        cell.lblName.text = supervisors[indexPath.row].employee_name
        cell.lblSections.text = ""
        for sec in supervisors[indexPath.row].sections{
            cell.lblSections.text = "\(cell.lblSections.text!)\(sec),"
        }
        cell.btnEdit.tag = indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(btnEdit(_ :)), for: .touchUpInside)
        return cell
    }
    
    var supervisors = [Supervisor]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        supervisors = SupervisorViewModel().getSupervisors()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    
    @objc func btnEdit(_ sender: UIButton){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "EditSupervisorViewController") as! EditSupervisorViewController
        controller.modalPresentationStyle = .fullScreen
        controller.predicate = { [unowned self] in
            self.supervisors = SupervisorViewModel().getSupervisors()
            tableView.reloadData()
        }
        controller.supervisor = supervisors[sender.tag]
        self.present(controller, animated: true)
    }
    
}
