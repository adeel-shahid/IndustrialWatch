//
//  CreateBatchViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 01/03/2024.
//

import UIKit

class CreateBatchViewController: UIViewController ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rawMaterials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! RawMaterialsTableViewCell
        cell.lblName.text = rawMaterials[indexPath.row].name
        cell.lblQuantity.text = rawMaterials[indexPath.row].quantity
        cell.lblPrice.text = "\(rawMaterials[indexPath.row].price)"
        cell.lblQuantityPerItem.text = rawMaterials[indexPath.row].quantiyPerItem
        return cell
    }
    
    var rawMaterials = [RawMaterial]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTolerance: UILabel!
    @IBOutlet weak var lblAngles: UILabel!
    @IBOutlet weak var lblBatch: UILabel!
    @IBOutlet weak var toleranceContainer: UIView!
    @IBOutlet weak var batchContainer: UIView!
    @IBOutlet weak var anglesContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var r = RawMaterial(id: 0, name: "Iron", quantity: "16 KG", price: 100, quantiyPerItem: "100 G")
        rawMaterials.append(r)
        r = RawMaterial(id: 1, name: "Copper", quantity: "4 KG", price: 5000, quantiyPerItem: "500 G")
        rawMaterials.append(r)
        toleranceContainer.layer.cornerRadius = 15
        batchContainer.layer.cornerRadius = 15
        anglesContainer.layer.cornerRadius = 15
        tableView.dataSource = self
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnAddBatch(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnMaterial(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "AddRawMaterialViewController")
        controller?.modalPresentationStyle = .popover
        self.present(controller!, animated: true)
        
    }
    
    
}
