//
//  ProductionMenuViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 03/04/2024.
//

import UIKit

class ProductionMenuViewController: UIViewController {

    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var btnBatch: UIView!
    @IBOutlet weak var btnInventory: UIView!
    @IBOutlet weak var btnAddProduct: UIView!
    @IBOutlet weak var btnRawMaterial: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        coverView.layer.cornerRadius = 45
        btnRawMaterial.layer.cornerRadius = 20
        btnBatch.layer.cornerRadius = 20
        btnInventory.layer.cornerRadius = 20
        btnAddProduct.layer.cornerRadius = 20
        btnRawMaterial.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigateToRawMaterial(_:))))
        btnAddProduct.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigateToAddProduct(_ :))))
        btnInventory.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigateToInventory(_ :))))
        btnBatch.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigateToProductViewController(_ :))))
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func navigateToRawMaterial(_ sender:Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RawMaterialViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
    }
    
    @objc func navigateToAddProduct(_ sender:Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "AddProductViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
    }
    
    @objc func navigateToInventory(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "InventoryViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
        
    }
    @objc func navigateToProductViewController(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewController")
        controller?.modalPresentationStyle = .fullScreen
        self.present(controller!, animated: true)
        
    }
    
}
