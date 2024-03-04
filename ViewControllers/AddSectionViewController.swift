//
//  AddOrEditSectionViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/02/2024.
//

import UIKit

class AddSectionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rules.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 172
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rulesCell") as! RulesAddorEditTableViewCell
        cell.lblRuleName.text = rules[indexPath.row].name
        return cell
    }
    
    var rules = [Rule]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtSectionName: UITexfield_Additions!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSectionName.layer.cornerRadius = 15
        rules = RuleViewModel().getRules()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    @IBAction func btnConfirmSection(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "SectionViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
    }
    @IBAction func btnBack(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "SectionViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
    }
    
}
