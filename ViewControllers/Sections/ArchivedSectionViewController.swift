//
//  ArchivedSectionViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 01/05/2024.
//

import UIKit

class ArchivedSectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return archivedSections.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! SectionsTableViewCell
        cell.sectionName = archivedSections[indexPath.row].name
        cell.btnEditOutlet.isHidden = true
        cell.btnArchievedOutlet.tag = indexPath.row
        cell.btnArchievedOutlet.addTarget(self, action: #selector(btnUnArchieved(_:)), for: .touchUpInside)
        return cell
    }
    
    var predicate : (() -> Void)?
    @IBOutlet weak var tableView: UITableView!
    var archivedSections = [Section]()
    override func viewDidLoad() {
        super.viewDidLoad()
        archivedSections = try! SectionViewModel().getAllSections(withStatus: 0)
        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func btnBack(_ sender: Any) {
        predicate?()
        self.dismiss(animated: true)
    }
    
    @objc func btnUnArchieved(_ sender: UIButton){
        let response: APIMessage = SectionViewModel().changeSectionStatus(withId: self.archivedSections[sender.tag].id)
        if response.ResponseCode == 200{
            archivedSections.remove(at: sender.tag)
            tableView.reloadData()
            view.makeToast("Section UnArchieved Successfully",duration: 2, position: .bottom)
            archivedSections = try! SectionViewModel().getAllSections(withStatus: 0)
            tableView.reloadData()
        }
    }
    
}
