//
//  AddSupervisorViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 23/02/2024.
//

import UIKit

class AddSupervisorViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
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
    var selectedSections = [Section]()
    var uibuttons = [UIButton]()
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUsername.layer.cornerRadius = 15
        txtPassword.layer.cornerRadius = 15
        txtName.layer.cornerRadius = 15
        sectioAssignContainer.layer.cornerRadius = 15
        sections = SectionViewModel().getAllSections()
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
        let s = Supervisor(id: 0, name: txtName.text!, username: txtUsername.text!, password: txtPassword.text!, role: "Supervisor", sections: selectedSections)
        let response = SupervisorViewModel().insertSupervisor(supervisor: s)
        if response.ResponseCode == 200{
            // Swift tost
            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
               let topViewController = window.rootViewController?.topMostViewController() {
                topViewController.view.makeToast("Section Inserted Seccessfully", duration: 3.0, position: .bottom)
            }
            predicate?()
            self.dismiss(animated: true)
        }else{
            let alert = UIAlertController(title: "Error", message: response.ResponseMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive))
            self.present(alert, animated: true)
        }
        //self.dismiss(animated: true)
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
    
}
