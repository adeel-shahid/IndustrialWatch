//
//  ChooseStockForSpecificRawMaterialViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 17/04/2024.
//

import UIKit

class ChooseStockForSpecificRawMaterialViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rawMaterials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! ChooseStockForRawMaterialTableViewCell
        cell.lblStockNumber.text = rawMaterials[indexPath.row].stock_number
        cell.lblQuantity.text = "\(rawMaterials[indexPath.row].quantity) KG"
        cell.lblDate.text = rawMaterials[indexPath.row].purchased_date
        cell.lblPrice.text = "\(rawMaterials[indexPath.row].price_per_kg)"
        return cell
    }
    

    
    @IBOutlet weak var UICustomButton: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var lblRawMaterialName: UILabel!
    var productFormula = ProductFormula(name: "Not Found", quantity: "", raw_material_id: 0)
    var rawMaterials = [RawMaterialDetails]()
    override func viewDidLoad() {
        super.viewDidLoad()
        rawMaterials = RawMaterialViewModel().getStockDetailOfRawMaterial(rawMaterialId: productFormula.raw_material_id)
        UICustomButton.layer.cornerRadius = 15
        lblRawMaterialName.text = "Choose Stocks For \(productFormula.name)"
        tableview.dataSource = self
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
