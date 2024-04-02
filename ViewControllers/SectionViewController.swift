//
//  SectionViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/02/2024.
//

import UIKit

class SectionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "SectionDetailsViewController") as! SectionDetailsViewController
        controller.sectionName = sections[indexPath.row].name
        controller.id = sections[indexPath.row].id
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! SectionsTableViewCell
        cell.sectionName = sections[indexPath.row].name
        cell.btnEditOutlet.tag = indexPath.row
        cell.btnDeleteOutlet.tag = indexPath.row
        cell.btnEditOutlet.addTarget(self, action: #selector(btnEdit(_:)), for: .touchUpInside)
        cell.btnDeleteOutlet.addTarget(self, action: #selector(btnDelete(_:)), for: .touchUpInside)
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    var sections = [Section]()
    override func viewDidLoad() {
        super.viewDidLoad()
        sections = SectionViewModel().getAllSections()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func btnEdit(_ sender: UIButton){
        let controller = storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        controller.sectionName = sections[sender.tag].name
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    @objc func btnDelete(_ sender: UIButton){
        sections.remove(at: sender.tag)
        tableView.reloadData()
    }
    
    @IBAction func btnAddSection(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "AddSectionViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
    }
}
