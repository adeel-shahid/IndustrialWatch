//
//  AddSupervisorViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 23/02/2024.
//

import UIKit

class AddSupervisorViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        uibuttons[indexPath.row].isSelected = !uibuttons[indexPath.row].isSelected
        if uibuttons[indexPath.row].isSelected == true{
            selectedSections.append(allSections[indexPath.row])
        }
        else{
            if let sec = selectedSections.index(of:uibuttons[indexPath.row].accessibilityLabel!){
                selectedSections.remove(at: sec)
            }
        }
        setSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! CustomDropDownTableViewCell
        cell.lblCheckbox.text = allSections[indexPath.row]
        cell.btnCheckbox.addTarget(self, action: #selector(btnCheckbox(_:)), for: .touchUpInside)
        cell.btnCheckbox.tag = indexPath.row
        cell.btnCheckbox.accessibilityLabel = allSections[indexPath.row]
        uibuttons.append(cell.btnCheckbox)
        cell.isUserInteractionEnabled = true
        return cell
    }
    
    @IBOutlet weak var btnShowDropDown: UIButton!
    @IBOutlet weak var lblSelectSection: UILabel!
    @IBOutlet weak var dropdownTable: UITableView!
    @IBOutlet weak var sectioAssignContainer: UIView!
    @IBOutlet weak var txtPassword: UITexfield_Additions!
    @IBOutlet weak var txtUsername: UITexfield_Additions!
    @IBOutlet weak var txtName: UITexfield_Additions!
    
    var allSections = [String]()
    var selectedSections = [String]()
    var uibuttons = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUsername.layer.cornerRadius = 15
        txtPassword.layer.cornerRadius = 15
        txtName.layer.cornerRadius = 15
        sectioAssignContainer.layer.cornerRadius = 15
        allSections.append("Packing")
        allSections.append("Management")
        allSections.append("Marketing")
        dropdownTable.dataSource = self
        dropdownTable.delegate = self
        sectioAssignContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showNhideDropDown(_ :))))
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnCreateAccount(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func btnCheckbox(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            selectedSections.append(allSections[sender.tag])
        }else{
            if let sec = selectedSections.index(of:sender.accessibilityLabel!){
                selectedSections.remove(at: sec)
            }
        }
        setSections()
    }
    
    @IBAction func btnShowDropDownAction(_ sender: Any) {
        btnShowDropDown.isSelected = !btnShowDropDown.isSelected
        dropdownTable.isHidden = !dropdownTable.isHidden
    }
    
    private func setSections(){
        if selectedSections.count == 0{
            lblSelectSection.text = "--Select Section--"
            return
        }
        lblSelectSection.text = ""
        for sec in selectedSections{
            lblSelectSection.text! += "\(sec),"
        }
    }
    
    @objc func showNhideDropDown(_ sender: Any){
        dropdownTable.isHidden = !dropdownTable.isHidden
        btnShowDropDown.isSelected = !btnShowDropDown.isSelected
    }
    
}
