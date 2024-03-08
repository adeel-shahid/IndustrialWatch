//
//  BatchDetailViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 01/03/2024.
//

import UIKit

class BatchDetailViewController: UIViewController, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formula.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! FormulaTableViewCell
        cell.lblserial.text = "\(formula[indexPath.row].id + 1)"
        cell.lblMaterial.text = formula[indexPath.row].material
        cell.lblQuantity.text = formula[indexPath.row].quantity
        return cell
    }
    

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var outputYeildView: UIView!
    @IBOutlet weak var expectedYieldView: UIView!
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var lblBatchNumber: UILabel!
    var batch : String = "Not Found"
    var formula = [Formula]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var f = Formula(id: 0, material: "Iron", quantity: "500 G")
        formula.append(f)
        f = Formula(id: 1, material: "Copper", quantity: "52 G")
        formula.append(f)
        tableView.dataSource = self
        lblBatchNumber.text = batch
        productView.layer.cornerRadius = 20
        expectedYieldView.layer.cornerRadius = 20
        outputYeildView.layer.cornerRadius = 20
    }

    @IBAction func btnDefects(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "DefectProductViewController") as! DefectProductViewController
        controller.batchNumber = batch
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
        
    }
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
