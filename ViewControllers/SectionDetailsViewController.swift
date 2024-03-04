//
//  SectionDetailsViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/02/2024.
//

import UIKit

class SectionDetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rules.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rulesCell") as! RulesTableViewCell
        cell.lblCount.text = "\(indexPath.row + 1)"
        cell.lblRuleName.text = rules[indexPath.row].name
        cell.lblTime.text = rules[indexPath.row].allowedTime
        cell.lblFine.text = "Rs.\(rules[indexPath.row].fine)"
        return cell
    }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblSectionName: UILabel!
    var sectionName : String = "Not Found"
    var rules = [Rule]()
    override func viewDidLoad() {
        super.viewDidLoad()
        lblSectionName.text = sectionName
        tableView.dataSource = self
        tableView.delegate = self
        rules = RuleViewModel().getRules()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "SectionViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
    }
    
    
    @IBAction func btnEditSection(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        controller.sectionName = sectionName
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
}
