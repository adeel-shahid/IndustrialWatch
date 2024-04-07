//
//  ChooseViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 04/04/2024.
//

import UIKit
import DropDown
import Toast_Swift
class ChooseRawMaterialViewController: UIViewController {

    
    var predicate: ((_ formula: Formula) -> Void)?
    
    
    @IBOutlet weak var rawMaterialView: UIView!
    @IBOutlet weak var lblRawMaterial: UILabel!
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var quantityContainer: UIView!
    @IBOutlet weak var rawMaterialContainer: UIView!
    
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var quantitydDropDownView: UIView!
    @IBOutlet weak var showQuantity: UIButton!
    @IBOutlet weak var lblUnitOfQuantity: UILabel!
    @IBOutlet weak var btnShowRawMaterials: UIButton!
    let quantityDropDown = DropDown()
    let rawMaterialDropDown = DropDown()
    var rawMaterials = [RawMaterials]()
    var formula : Formula = Formula(raw_material_id: 0, material: "", quantity: 0,unit: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        quantityContainer.layer.cornerRadius = 15
        rawMaterialContainer.layer.cornerRadius = 15
        mainContainer.layer.cornerRadius = 15
        rawMaterials = RawMaterialViewModel().getRawMaterials()
        
        
        // Quantity DropDown
        
        quantityDropDown.anchorView = quantitydDropDownView
        quantityDropDown.dataSource = ["KG","G","MG"]
        quantityDropDown.selectionAction = { [unowned self] (index:
            Int, item: String) in
            lblUnitOfQuantity.text = item
        }
        quantityDropDown.bottomOffset = CGPoint(x: 0,
            y: (quantityDropDown.anchorView?.plainView.bounds.height)!)
        quantitydDropDownView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(quantityContainerClick(_ :))))
        
        // RawMaterialDropDown
        var data = [String]()
        for rawMaterial in rawMaterials {
            data.append(rawMaterial.name)
        }
        
        
        rawMaterialDropDown.anchorView = rawMaterialContainer
        rawMaterialDropDown.dataSource = data
        rawMaterialDropDown.selectionAction = { [unowned self] (index:
            Int, item: String) in
            lblRawMaterial.text = item
        }
        rawMaterialDropDown.bottomOffset = CGPoint(x: 0,
            y: (quantityDropDown.anchorView?.plainView.bounds.height)!)
        rawMaterialContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dropDownRawMaterial(_ :))))
        
    }

    
    @IBAction func btnShowQuantityDropDown(_ sender: Any) {
        dropdown()
    }
    @IBAction func btnRawMaterialDropDown(_ sender: Any) {
        rawMaterialDropDown.show()
    }
    
    func dropdown(){
        quantityDropDown.show()
    }
    @objc func quantityContainerClick(_ sender:Any){
        dropdown()
    }
    
    @objc func dropDownRawMaterial(_ sender: Any){
        rawMaterialDropDown.show()
    }
    
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        guard let quantity = txtQuantity.text,
              let nameRawMaterial =
                lblRawMaterial.text,!txtQuantity.text!.isEmpty,!lblRawMaterial.text!.elementsEqual("--Select Raw Material--" ),let quantityUnit = lblUnitOfQuantity.text,!lblUnitOfQuantity.text!.elementsEqual("Unit")  else{
            view.makeToast("Fill The Fields and Select the RawMaterial with unit", duration: 2.0, position: .bottom)
            return
        }
        
        
        formula.raw_material_id = getRawMaterialId(byName: nameRawMaterial)!
        formula.material = nameRawMaterial
        formula.quantity = Int(quantity) ?? 0
        formula.unit = quantityUnit
        print(formula)
        predicate?(formula)
        self.dismiss(animated: true)
    }
    
    private func getRawMaterialId(byName: String)->Int?{
        var i : Int = 0
        while i < rawMaterials.count{
            if rawMaterials[i].name == byName{
                return rawMaterials[i].id
            }
            i = i + 1
        }
        return nil
    }
    
}
