//
//  AddProductViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 04/04/2024.
//

import UIKit
import Toast_Swift
class AddProductViewController: UIViewController, UITableViewDataSource ,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formlas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! FormulaTableViewCell
        cell.lblserial.text = "\(indexPath.row + 1)"
        cell.lblMaterial.text = formlas[indexPath.row].material
        cell.lblQuantity.text = "\(formlas[indexPath.row].quantity) G"
        return cell
    }
    @IBOutlet weak var cbxTopOutlet: UIButton!
    
    @IBOutlet weak var checkboxContainer: UIView!
    @IBOutlet weak var cbxFlipOutlet: UIButton!
    
    @IBOutlet weak var cbxRightOutlet: UIButton!
    @IBOutlet weak var cbxLeftOutlet: UIButton!
    
    @IBOutlet weak var cbxBackOutlet: UIButton!
    @IBOutlet weak var cbxFrontOutlet: UIButton!
    
    @IBOutlet weak var txtRejectionTolerance: UITexfield_Additions!
    @IBOutlet weak var txtName: UITexfield_Additions!
    
    @IBOutlet weak var tableView: UITableView!
    var selectedAnglesList = [String]()
    var formlas = [Formula]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        txtName.layer.cornerRadius = 15
        txtRejectionTolerance.layer.cornerRadius = 15
        checkboxContainer.layer.cornerRadius = 15
    }
    
    @IBAction func btnAddMaterial(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ChooseRawMaterialViewController") as! ChooseRawMaterialViewController
        controller.modalPresentationStyle = .automatic
        controller.predicate = myPredicateFunction
        self.present(controller, animated: true)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    private func myPredicateFunction(formula: Formula) {
        view.makeToast("Formula Added Successfully", duration: 2.0, position: .bottom)
        formlas.append(formula)
        tableView.reloadData()
    }
    
    @IBAction func cbxTop(_ sender: Any) {
        cbxTopOutlet.isSelected = !cbxTopOutlet.isSelected
        if cbxTopOutlet.isSelected{
            selectedAnglesList.append("Top")
        }else{
            if selectedAnglesList.contains("Top"){
                selectedAnglesList.remove(at: selectedAnglesList.firstIndex(of: "Top")!)
            }
        }
        print(selectedAnglesList)
    }
    @IBAction func cbxLeft(_ sender: Any) {
        cbxLeftOutlet.isSelected = !cbxLeftOutlet.isSelected
        if cbxLeftOutlet.isSelected{
            selectedAnglesList.append("Left")
        }else{
            if selectedAnglesList.contains("Left"){
                selectedAnglesList.remove(at: selectedAnglesList.firstIndex(of: "Left")!)
            }
        }
        print(selectedAnglesList)

    }
    @IBAction func cbxBack(_ sender: Any) {
        cbxBackOutlet.isSelected = !cbxBackOutlet.isSelected
        if cbxBackOutlet.isSelected{
            selectedAnglesList.append("Back")
        }else{
            if selectedAnglesList.contains("Back"){
                selectedAnglesList.remove(at: selectedAnglesList.firstIndex(of: "Back")!)
            }
        }
        print(selectedAnglesList)

    }
    @IBAction func cbxFront(_ sender: Any) {
        cbxFrontOutlet.isSelected = !cbxFrontOutlet.isSelected
        if cbxFrontOutlet.isSelected{
            selectedAnglesList.append("Front")
        }else{
            if selectedAnglesList.contains("Front"){
                selectedAnglesList.remove(at: selectedAnglesList.firstIndex(of: "Front")!)
            }
        }
        print(selectedAnglesList)

    }
    @IBAction func cbxFlip(_ sender: Any) {
        cbxFlipOutlet.isSelected = !cbxFlipOutlet.isSelected
        if cbxFlipOutlet.isSelected{
            selectedAnglesList.append("Flip")
        }else{
            if selectedAnglesList.contains("Flip"){
                selectedAnglesList.remove(at: selectedAnglesList.firstIndex(of: "Flip")!)
            }
        }
        print(selectedAnglesList)

    }
    @IBAction func cbxRight(_ sender: Any) {
        cbxRightOutlet.isSelected = !cbxRightOutlet.isSelected
        if cbxRightOutlet.isSelected{
            selectedAnglesList.append("Right")
        }else{
            if selectedAnglesList.contains("Right"){
                selectedAnglesList.remove(at: selectedAnglesList.firstIndex(of: "Right")!)
            }
        }
        print(selectedAnglesList)

    }
    
    @IBAction func btnAddProduct(_ sender: Any) {
        guard let name = txtName.text, !txtName.text!.isEmpty,
              let tolrance = txtRejectionTolerance.text, !txtRejectionTolerance.text!.isEmpty,
              !selectedAnglesList.isEmpty,
              !formlas.isEmpty
        else{
            view.makeToast("Fill all Input Fields and Check Atleast one CheckBox and add atleast one Raw Material", duration: 3.0, position: .bottom)
            return
        }
        
        guard let rejTolerance = Float(tolrance) else{
            view.makeToast("Tolrance Must be in Points", duration: 3.0, position: .bottom)
            return
        }
        var inspectionAngles : String = ""
        for angles in selectedAnglesList{
            inspectionAngles = inspectionAngles + "\(angles),"
        }
        let p = Product(name: name, rejection_tolerance: rejTolerance, inspection_angles: inspectionAngles, product_number: "generate", materials: formlas)
        let response = ProductViewModel().insertProduct(product: p)
        if response.ResponseCode == 200{
            view.makeToast("Product \(name) inserted Successfully", duration: 2.0, position: .bottom)
            txtName.text = ""
            txtRejectionTolerance.text = ""
            selectedAnglesList = []
            formlas = []
            tableView.reloadData()
            cbxTopOutlet.isSelected = false
            cbxFlipOutlet.isSelected = false
            cbxFrontOutlet.isSelected = false
            cbxBackOutlet.isSelected = false
            cbxLeftOutlet.isSelected = false
            cbxRightOutlet.isSelected = false
        }else{
            view.makeToast(response.ResponseMessage, duration: 3.0, position: .bottom)
        }
    }
    
    
}
