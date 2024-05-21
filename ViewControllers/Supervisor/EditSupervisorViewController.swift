//
//  AddSupervisorViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 23/02/2024.
//

import UIKit
import Toast_Swift
class EditSupervisorViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        uibuttons[indexPath.row].isSelected = !uibuttons[indexPath.row].isSelected
        if uibuttons[indexPath.row].isSelected == true{
            selectedSections.append(sections[indexPath.row])
        }
        else{
//            if let sec = selectedSections.index(of:uibuttons[indexPath.row].accessibilityLabel!){
//                selectedSections.remove(at: sec)
//            }
            var i : Int = 0
            while(i < selectedSections.count){
                if selectedSections[i].id == sections[indexPath.row].id{
                    selectedSections.remove(at: i)
                    break
                }
                i = i + 1
            }
        }
        setSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! CustomDropDownTableViewCell
        cell.lblCheckbox.text = sections[indexPath.row].name
        cell.btnCheckbox.addTarget(self, action: #selector(btnCheckbox(_:)), for: .touchUpInside)
        cell.btnCheckbox.tag = indexPath.row
        // cell.btnCheckbox.accessibilityLabel = allSections[indexPath.row]
        for sec in supervisor.sections{
            if sec == sections[indexPath.row].name{
                cell.btnCheckbox.isSelected = true
            }
        }
        uibuttons.append(cell.btnCheckbox)
        cell.layer.cornerRadius = 10
        cell.isUserInteractionEnabled = true
        return cell
    }
    
    
    @IBOutlet weak var UICustomButtonUpdate: UIView!
    @IBOutlet weak var btnShowDropDown: UIButton!
    @IBOutlet weak var lblSelectSection: UILabel!
    @IBOutlet weak var dropdownTable: UITableView!
    @IBOutlet weak var sectioAssignContainer: UIView!
    @IBOutlet weak var txtPassword: UITexfield_Additions!
    @IBOutlet weak var txtUsername: UITexfield_Additions!
    @IBOutlet weak var txtName: UITexfield_Additions!
    
//    var allSections = [String]()
    var selectedSections = [Section]()
    var uibuttons = [UIButton]()
    var sections = [Section]()
    var supervisor = Supervisor(employee_id: 0, employee_name: "Not Found", sections: [])
    var supervisorDetail = SupervisorDetail(username: "", password: "", sections: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUsername.layer.cornerRadius = 15
        txtPassword.layer.cornerRadius = 15
        txtName.layer.cornerRadius = 15
        sectioAssignContainer.layer.cornerRadius = 15
        UICustomButtonUpdate.layer.cornerRadius = 15
        UICustomButtonUpdate.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnUpdateSupervisor(_ :))))
        sections = try! SectionViewModel().getAllSections(withStatus: 1)
        txtName.text = supervisor.employee_name
        supervisorDetail = SupervisorViewModel().getSupervisorById(id: supervisor.employee_id)
        txtUsername.text = supervisorDetail.username
        txtPassword.text = supervisorDetail.password
        selectedSections = supervisorDetail.sections
        setSections()
        dropdownTable.dataSource = self
        dropdownTable.delegate = self
        sectioAssignContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showNhideDropDown(_ :))))
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    var predicate : (() -> Void)?
    @objc func btnCheckbox(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            selectedSections.append(sections[sender.tag])
        }else{
//            if let sec = selectedSections.index(of:sender.accessibilityLabel!){
//                selectedSections.remove(at: sec)
//            }
            var i : Int = 0
            while(i < selectedSections.count){
                if selectedSections[i].id == sections[sender.tag].id{
                    selectedSections.remove(at: i)
                    break
                }
                i = i + 1
            }
            
        }
        setSections()
    }
    
    @IBAction func btnShowDropDownAction(_ sender: Any) {
        btnShowDropDown.isSelected = !btnShowDropDown.isSelected
        dropdownTable.isHidden = !dropdownTable.isHidden
    }
    
    private func setSections(){
        print(selectedSections)
        if selectedSections.count == 0{
            lblSelectSection.text = "--Select Section--"
            return
        }
        lblSelectSection.text = ""
        for sec in selectedSections{
            lblSelectSection.text! += "\(sec.name),"
        }
    }
    
    @objc func showNhideDropDown(_ sender: Any){
        dropdownTable.isHidden = !dropdownTable.isHidden
        btnShowDropDown.isSelected = !btnShowDropDown.isSelected
    }
    
    @objc func btnUpdateSupervisor(_ sender: Any){
        guard let name = txtName.text, !txtName.text!.isEmpty,
              let username = txtUsername.text, !txtUsername.text!.isEmpty,
              let password = txtPassword.text, !txtPassword.text!.isEmpty,
              selectedSections.count != 0
        else{
            view.makeToast("Fill the TextFields and select at least one Section!", duration: 2, position: .bottom)
            return
        }
        var sectionIds = [Int]()
        for section in selectedSections {
            sectionIds.append(section.id)
        }
        let s = SupervisorDetail(employee_id: supervisor.employee_id,name: name,username: username, password: password, sections: selectedSections,sections_id: sectionIds)
        let response = SupervisorViewModel().updateSupervisor(supervisor: s)
        if response.ResponseCode == 200{
            view.makeToast("Supervisor Updated Successfully", duration: 2, position: .bottom)
            predicate?()
            self.dismiss(animated: true)
        }else{
            let alert = UIAlertController(title: "Error", message: response.ResponseMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
        }
    }
    
}
