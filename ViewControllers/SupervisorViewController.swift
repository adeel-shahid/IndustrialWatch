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
        cell.lblName.text = supervisors[indexPath.row].name
        cell.lbluserName.text = supervisors[indexPath.row].username
        cell.btnEdit.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(btnDelete(_ :)), for: .touchUpInside)
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
        let controller = storyboard?.instantiateViewController(withIdentifier: "AdminDashboardViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
    }
    
    
    @IBAction func btnAddSupervisor(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "AddSupervisorViewController")
        
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
    }
    
    @objc func btnEdit(_ sender: UIButton){
        let controller = storyboard?.instantiateViewController(withIdentifier: "EditSupervisorViewController") as! EditSupervisorViewController
        controller.name = supervisors[sender.tag].name
        controller.modalPresentationStyle = .automatic
        self.present(controller, animated: true)
    }
    @objc func btnDelete(_ sender: UIButton){
        supervisors.remove(at: sender.tag)
        tableView.reloadData()
    }
    
}
