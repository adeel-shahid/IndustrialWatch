//
//  InventoryViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 05/04/2024.
//

import UIKit
import Toast_Swift
class InventoryViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! InventoryTableViewCell
        cell.lblSerial.text = "\(indexPath.row + 1)"
        cell.lblName.text = inventory[indexPath.row].raw_material_name
        cell.lblQuantity.text = "\(inventory[indexPath.row].total_quantity) KG"
        cell.btnDetailsOutlet.tag = indexPath.row
        cell.btnDetailsOutlet.addTarget(self, action: #selector(btnDetails(_ :)), for: .touchUpInside)
        return cell
    }
    
    var inventory = [Inventory]()
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        inventory = InventoryViewModel().getAllInventory()
        tableview.dataSource = self
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func btnDetails(_ sender: UIButton){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "RawMaterialDetailViewController") as! RawMaterialDetailViewController
        let rawMaterial = RawMaterials(id: inventory[sender.tag].raw_material_id, name: inventory[sender.tag].raw_material_name)
        controller.rawMaterial = rawMaterial
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    @IBAction func btnAddStock(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "AddNewStockViewController") as! AddNewStockViewController
        controller.predicate = {[unowned self] in
            view.makeToast("Stock Inserted Successfully", duration: 2.0, position: .bottom)
            self.inventory = InventoryViewModel().getAllInventory()
            tableview.reloadData()
        }
        controller.modalPresentationStyle = .automatic
        self.present(controller, animated: true)
        
    }
    
}
