//
//  LinkProductViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 14/04/2024.
//

import UIKit
import DropDown
import Toast_Swift
class LinkProductViewController: UIViewController {
    let productDropDown = DropDown()
    @IBOutlet weak var txtSelectedText: UILabel!
    @IBOutlet weak var UICustomButton: UIView!
    @IBOutlet weak var DropDownView: UIView!
    @IBOutlet weak var txtPacks: UITexfield_Additions!
    @IBOutlet weak var txtrejTolerance: UITexfield_Additions!
    @IBOutlet weak var txtPieces: UITexfield_Additions!
    
    var predicate: (() -> Void)?
    
    var products = [Product]()
    var selectedIndex : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        UICustomButton.layer.cornerRadius = 20
        txtPacks.layer.cornerRadius = 13
        txtPieces.layer.cornerRadius = 13
        txtrejTolerance.layer.cornerRadius = 13
        UICustomButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnSave(_ :))))
        products = ProductViewModel().getUnLinkedProducts()
        var productsString = [String]()
        for product in products {
            productsString.append(product.name)
        }
        // Products Drop Down
        DropDownView.layer.cornerRadius = 15
        productDropDown.dataSource = productsString
        productDropDown.anchorView = DropDownView
        productDropDown.selectionAction  = { [unowned self] (index: Int, item: String) in
            selectedIndex = index
            txtSelectedText.text = item
        }
        productDropDown.bottomOffset = CGPoint(x: 0,
            y: (productDropDown.anchorView?.plainView.bounds.height)!)
        DropDownView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showDropDown(_ :))))
    }
    
    @objc func showDropDown(_ sender: Any){
        productDropDown.show()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func btnShowDropDown(_ sender: Any) {
        showDropDown(UIButton())
    }
    
    @objc func btnSave(_ sender: Any){
        guard let selectedProduct = txtSelectedText.text , !txtSelectedText.text!.isEmpty,txtSelectedText.text! != "--Select Product--",
              let packs = txtPacks.text, !txtPacks.text!.isEmpty,
              let peices = txtPieces.text, !txtPieces.text!.isEmpty,
              let rejectionTolerance = txtrejTolerance.text, !txtrejTolerance.text!.isEmpty else{
            view.makeToast("Please Fill all the Fields and Select at least one Product", duration: 3.0, position: .bottom)
            return
        }
        let productLink = LinkProduct(product_number: products[selectedIndex].product_number, packs_per_batch: Int(packs)!, piece_per_pack: Int(peices)!, rejection_tolerance: Float(rejectionTolerance)!)
        let response = ProductViewModel().linkProduct(linkProduct: productLink)
        if response.ResponseCode == 200{
            predicate?()
            self.dismiss(animated: true)
        }else{
            let alert = UIAlertController(title: "Server Error", message: response.ResponseMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive))
            self.present(alert, animated: true)
        }
    }
    
}
