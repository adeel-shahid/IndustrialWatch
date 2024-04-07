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
        cell.lblRuleName.text = rules[indexPath.row].rule_name
        cell.btnCheckBoxOutlet.tag = indexPath.row
        cell.btnCheckBoxOutlet.addTarget(self, action: #selector(btnCheckbox(_ :)), for: .touchUpInside)
        cells.append(cell)
        return cell
    }
    var selectedRules = [Rule]()
    var rules = [Rule]()
    var cells = [RulesAddorEditTableViewCell]()
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var txtSectionName: UITexfield_Additions!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSectionName.layer.cornerRadius = 15
        rules = RuleViewModel().getRules()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    var predicate: (() -> Void)?
    @IBAction func btnConfirmSection(_ sender: Any) {
        
        guard let section = txtSectionName.text, !txtSectionName.text!.isEmpty else {
            //Swift tost Notification
            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
               let topViewController = window.rootViewController?.topMostViewController() {
                topViewController.view.makeToast("Please fill the Section Name!", duration: 3.0, position: .bottom)
            }
                return
            }
        
        for rule in rules{
            if rule.status == "Checked"{
                selectedRules.append(rule)
            }
        }
        let s = Section(id: 0, name: section, rules: selectedRules)
        let response = SectionViewModel().insertSectionWithRules(section: s)
        if response.ResponseCode == 200{
//            //Swift tost Notification
            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
               let topViewController = window.rootViewController?.topMostViewController() {
                topViewController.view.makeToast("Section Inserted Seccessfully", duration: 3.0, position: .bottom)
            }
            predicate?()
            self.dismiss(animated: true,completion: predicate)
        }else{
            let alert = UIAlertController(title: "Error", message: response.ResponseMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive))
            self.present(alert, animated: true)
        }
        
    }
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
 
    @objc func btnCheckbox(_ sender: UIButton){
        if cells[sender.tag].btnCheckBoxOutlet.isSelected{
            cells[sender.tag].btnCheckBoxOutlet.isSelected = false
            cells[sender.tag].txtFine.text = ""
            cells[sender.tag].txtTime.text = ""
            rules[sender.tag].status = nil
            rules[sender.tag].fine = 0
            rules[sender.tag].allowed_time = ""
            print("\nRemoval\(rules)")
            return
        }
        
        
        guard let time = cells[sender.tag].txtTime.text,let fine = cells[sender.tag].txtFine.text, !cells[sender.tag].txtTime.text!.isEmpty,!cells[sender.tag].txtFine.text!.isEmpty else {
            
            //Swift tost Notification
            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
               let topViewController = window.rootViewController?.topMostViewController() {
                topViewController.view.makeToast("Please fill text fields", duration: 3.0, position: .bottom)
            }

            return
        }
        let pattern = #"^(\d{1,2}):(\d{2})$"#
        let finepattern = #"^(\d)$"#

        // Define a sample string to validate
        let timeString = cells[sender.tag].txtTime.text!
        let fineString = cells[sender.tag].txtFine.text!
        // Create an NSRegularExpression object with the pattern
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            
            // Perform the match
            let matches = regex.matches(in: timeString, options: [], range: NSRange(location: 0, length: timeString.utf16.count))
            
            // Check if there is at least one match
            if matches.count > 0 {
                print("Valid time format: \(timeString)")
            } else {
                //Swift tost Notification
                if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
                   let topViewController = window.rootViewController?.topMostViewController() {
                    topViewController.view.makeToast("Invalid fine format: \(timeString)", duration: 3.0, position: .bottom)
                }
                return
            }
        } catch {
            print("Error creating regular expression: \(error)")
            return
        }
        //Fine Validation
        var amount : Int = 0
        if let rulefine = Int(fineString){
            amount = rulefine
        }
        else{
            //Swift tost Notification
            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
               let topViewController = window.rootViewController?.topMostViewController() {
                topViewController.view.makeToast("Invalid fine format: \(fineString)", duration: 3.0, position: .bottom)
            }

            return
        }
        rules[sender.tag].status = "Checked"
        rules[sender.tag].fine = amount
        rules[sender.tag].allowed_time = timeString
        print("\n\(rules)")
        cells[sender.tag].btnCheckBoxOutlet.isSelected = true
    }
    
}
