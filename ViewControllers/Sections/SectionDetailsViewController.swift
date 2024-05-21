//
//  SectionDetailsViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/02/2024.
//

import UIKit

class SectionDetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.section.rules!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rulesCell") as! RulesTableViewCell
        cell.lblCount.text = "\(indexPath.row + 1)"
        cell.lblRuleName.text = self.section.rules?[indexPath.row].name
        cell.lblTime.text = self.section.rules?[indexPath.row].allowed_time
        if let fine = self.section.rules?[indexPath.row].fine{
            cell.lblFine.text = "Rs.\(fine)"
        }else{
            cell.lblFine.text = "Rs.0"
        }
        return cell
    }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblSectionName: UILabel!
    var sectionName : String = "Not Found"
    var section : Section = Section(id: 0, name: "", status: 0)
    var id : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        lblSectionName.text = sectionName
        section = SectionViewModel().getSectionByID(id: id)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func btnEditSection(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        controller.sectionName = sectionName
        controller.section_id = self.id
        controller.predicate = { [unowned self] in
            self.section = SectionViewModel().getSectionByID(id: self.id)
            tableView.reloadData()
        }
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
}
