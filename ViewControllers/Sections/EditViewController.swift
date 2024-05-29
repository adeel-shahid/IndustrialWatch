//
//  EditViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/02/2024.
//

import UIKit
import Toast_Swift
class EditViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rules.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 172
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rulesCell") as! RulesAddorEditTableViewCell
        cell.lblRuleName.text = rules[indexPath.row].name
        cell.btnCheckBoxOutlet.tag = indexPath.row
        cell.btnCheckBoxOutlet.addTarget(self, action: #selector(btnCheckbox(_ :)), for: .touchUpInside)
        
        for rule in selectedRules{
            if rule.id == rules[indexPath.row].id{
                cell.btnCheckBoxOutlet.isSelected = true
                cell.txtFine.text = "\(rule.fine!)"
                cell.txtTime.text = "\(rule.allowed_time!)"
            }
        }
        cell.containerTime.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleContainerTimeTap(_ :))))
        cells.append(cell)
        return cell
    }
    var rules = [Rule]()
    var cells = [RulesAddorEditTableViewCell]()
    var selectedRules = [Rule]()
    @IBOutlet weak var txtSectionName: UITexfield_Additions!
    
    @IBOutlet weak var tableView: UITableView!
    var sectionName : String = ""
    var section_id : Int = 0
    var section : Section = Section(id: 0, name: "", status: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSectionName.layer.cornerRadius = 15
        txtSectionName.text = sectionName
        section = SectionViewModel().getSectionByID(id: section_id)
        selectedRules = section.rules!
        rules = RuleViewModel().getRules()
        print(rules)
        tableView.delegate = self
        tableView.dataSource = self
    }

    var predicate: (() -> Void)?
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnUpdateSection(_ sender: Any) {
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
        // updating selected rules list
        selectedRules = [Rule]()
        for cell in cells {
            if cell.btnCheckBoxOutlet.isSelected{
                let r = Rule(id: rules[cell.btnCheckBoxOutlet.tag].id, name: rules[cell.btnCheckBoxOutlet.tag].name,allowed_time:cell.txtTime.text!, fine:Int(cell.txtFine.text!))
                selectedRules.append(r)
            }
        }
        
        
        let s = Section(id: self.section_id, name: section, rules: selectedRules, status: 1)
        let response = SectionViewModel().update(section: s)
        if response.ResponseCode == 200{
//            //Swift tost Notification
            view.makeToast("Section Updated Successfully", duration: 2, position: .bottom)
            predicate?()
            self.dismiss(animated: true,completion: nil)
        }else{
            let alert = UIAlertController(title: "Error", message: response.ResponseMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive))
            self.present(alert, animated: true)
        }
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
    
    @objc func handleContainerTimeTap(_ sender: UITapGestureRecognizer) {
            guard let tappedView = sender.view else { return }
            
            // Find the cell containing the tapped view
            var view: UIView? = tappedView
            while view != nil, !(view is RulesAddorEditTableViewCell) {
                view = view?.superview
            }
            
            guard let cell = view as? RulesAddorEditTableViewCell else { return }
            
            // Access the label within the cell
        let label = cell.txtTime
        print("Label text: \(label?.text ?? "No text")")
            
            // Navigate to AllowedTimeViewController
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "AllowedTimeViewController") as! AllowedTimeViewController
            controller.predicate = { [unowned self] time in
                cell.txtTime.text = time
                print("Received time: \(time)")
            }
        self.present(controller, animated: true)
        }
}
