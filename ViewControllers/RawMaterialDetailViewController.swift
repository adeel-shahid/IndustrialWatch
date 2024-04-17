//
//  RawMaterialDetailViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 05/04/2024.
//

import UIKit

class RawMaterialDetailViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rawMaterialDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! RawMaterialDetailsTableViewCell
        cell.lblSerial.text = rawMaterialDetails[indexPath.row].stock_number
        cell.lblQuantity.text = "\(rawMaterialDetails[indexPath.row].quantity) KG"
        cell.lblPrice.text = "\(rawMaterialDetails[indexPath.row].price_per_kg)"
        cell.lblDate.text = rawMaterialDetails[indexPath.row].purchased_date
        return cell
    }
    
    @IBOutlet weak var lblRawMaterialName: UILabel!
    var rawMaterialDetails = [RawMaterialDetails]()
    var rawMaterial = RawMaterials(id: 0, name: "Not Found")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblRawMaterialName.text = rawMaterial.name
        rawMaterialDetails = InventoryViewModel().getRawMaterialDetails(id: rawMaterial.id)
        tableview.dataSource = self
    }
    @IBOutlet weak var tableview: UITableView!
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
