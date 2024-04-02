//
//  EditViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/02/2024.
//

import UIKit

class EditViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rules.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 172
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rulesCell") as! RulesAddorEditTableViewCell
        cell.lblRuleName.text = rules[indexPath.row].rule_name
        return cell
    }
    var rules = [Rule]()
    
    @IBOutlet weak var txtSectionName: UITexfield_Additions!
    @IBOutlet weak var tableView: UITableView!
    var sectionName : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSectionName.layer.cornerRadius = 15
        txtSectionName.text = sectionName
        rules = RuleViewModel().getRules()
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnUpdateSection(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
