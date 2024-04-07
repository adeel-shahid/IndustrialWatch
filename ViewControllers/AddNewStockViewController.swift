//
//  AddNewStockViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 05/04/2024.
//

import UIKit
import DropDown
class AddNewStockViewController: UIViewController {
    
    @IBOutlet weak var showQuantity: UIButton!
    @IBOutlet weak var rawMaterialContainer: UIView!
    @IBOutlet weak var btnShowRawMaterials: UIButton!
    @IBOutlet weak var lblUnitOfQuantity: UILabel!
    @IBOutlet weak var quantitydDropDownView: UIView!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var quantityContainer: UIView!
    @IBOutlet weak var lblRawMaterial: UILabel!
    @IBOutlet weak var txtPrice: UITexfield_Additions!
    
    
    let quantityDropDown = DropDown()
    let rawMaterialDropDown = DropDown()
    var rawMaterials = [RawMaterials]()
    @IBOutlet weak var mainContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainContainer.layer.cornerRadius = 15
        quantityContainer.layer.cornerRadius = 15
        txtPrice.layer.cornerRadius = 15
        rawMaterialContainer.layer.cornerRadius = 15
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

    func dropdown(){
        quantityDropDown.show()
    }
    @objc func quantityContainerClick(_ sender:Any){
        dropdown()
    }
    
    @objc func dropDownRawMaterial(_ sender: Any){
        rawMaterialDropDown.show()
    }
    @IBAction func btnShowQuantityDropDown(_ sender: Any) {
        dropdown()
    }
    
    @IBAction func btnRawMaterialDropDown(_ sender: Any) {
        rawMaterialDropDown.show()
    }
    var predicate: (()->Void)?
    
    @IBAction func btnAdd(_ sender: Any) {
        guard let quantity = txtQuantity.text,
              let nameRawMaterial =
                lblRawMaterial.text,!txtQuantity.text!.isEmpty,!lblRawMaterial.text!.elementsEqual("--Select Raw Material--" ),let quantityUnit = lblUnitOfQuantity.text,!lblUnitOfQuantity.text!.elementsEqual("Unit"),
              let price = txtPrice.text, !txtPrice.text!.isEmpty
        else{
            view.makeToast("Fill The Text Fields and Select the RawMaterial with unit", duration: 2.0, position: .bottom)
            return
        }
        guard let priceInt = Int(price), let quantityInt = Int(quantity) else{
            view.makeToast("Price and Quantity Should Be Integer", duration: 2.0, position: .bottom)
            return
        }
        let materialID = getRawMaterialId(byName: nameRawMaterial)!
        var s = Stock(stock_number: "generate", raw_material_id: materialID, quantity: quantityInt, unit: quantityUnit, price_per_unit: priceInt, purchased_date: "aj ki")
        let response = InventoryViewModel().insertNewStock(stock: s)
        if response.ResponseCode == 200{
            predicate?()
            self.dismiss(animated: true)
        }else{
            view.makeToast(response.ResponseMessage, duration: 3.0, position: .bottom)
        }
    }
    
    @IBAction func btnCancel(_ sender: Any) {
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
