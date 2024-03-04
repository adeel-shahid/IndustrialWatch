//
//  AddRawMaterialViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 01/03/2024.
//

import UIKit
import DropDown
class AddRawMaterialViewController: UIViewController {

    @IBOutlet weak var showQuantityPerItem: UIButton!
    @IBOutlet weak var showQuantity: UIButton!
    @IBOutlet weak var lblUnitPerItem: UILabel!
    @IBOutlet weak var lblUnitOfQuantity: UILabel!
    @IBOutlet weak var quantityDropDownView: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var perItemDropDownView: UIView!
    @IBOutlet weak var txtPrice: UITexfield_Additions!
    @IBOutlet weak var txtQuantityPerItem: UITexfield_Additions!
    @IBOutlet weak var txtQuantity: UITexfield_Additions!
    @IBOutlet weak var txtName: UITexfield_Additions!
    let quantityDropDown = DropDown()
    let perItemDropDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Quantity DropDown View
        
        quantityDropDown.anchorView = quantityDropDownView
        quantityDropDown.dataSource = ["KG","GM","MG"]
        quantityDropDown.selectionAction = { [unowned self] (index:
            Int, item: String) in
            lblUnitOfQuantity.text = item
            showQuantity.isSelected = false
        }
        quantityDropDown.bottomOffset = CGPoint(x: 0,
            y: (quantityDropDown.anchorView?.plainView.bounds.height)!)
        
        //PerItem DropDown View
        
        perItemDropDown.anchorView = perItemDropDownView
        perItemDropDown.dataSource = ["G","KG","MG"]
        perItemDropDown.selectionAction = { [unowned self] (index:
            Int, item: String) in
            lblUnitPerItem.text = item
            showQuantityPerItem.isSelected = false
        }
        perItemDropDown.bottomOffset = CGPoint(x: 0,
            y: (quantityDropDown.anchorView?.plainView.bounds.height)!)
         
        
        // UI Optimization
        
        container.layer.cornerRadius = 20
        txtName.layer.cornerRadius = 10
        txtPrice.layer.cornerRadius = 10
        txtQuantity.layer.cornerRadius = 10
        txtQuantityPerItem.layer.cornerRadius = 10
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func btnShowQuantityDropDown(_ sender: Any) {
        showQuantity.isSelected = !showQuantity.isSelected
        quantityDropDown.show()
    }
    
    @IBAction func btnShowPeritemDropDown(_ sender: Any) {
        showQuantityPerItem.isSelected = !showQuantityPerItem.isSelected
        perItemDropDown.show()
    }
    
    
}
