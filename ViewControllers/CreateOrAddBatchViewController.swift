//
//  CreateOrAddBatchViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 17/04/2024.
//

import UIKit

class CreateOrAddBatchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productFormulas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell1") as! ChoosedStockTableViewCell
        cell.lblSerial.text = "\(indexPath.row + 1)"
        cell.lblName.text = productFormulas[indexPath.row].name
        cell.lblQuantity.text = productFormulas[indexPath.row].quantity
        cell.btnChooseStock.tag = indexPath.row
        cell.btnChooseStock.addTarget(self, action: #selector(btnChooseStock(_ :)), for: .touchUpInside)
        return cell
        
    }
    

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var txtBatchNumber: UITexfield_Additions!
    @IBOutlet weak var UICutomButton: UIView!
    @IBOutlet weak var lblProductName: UILabel!
    var product = Product(name: "Not Found", product_number: "")
    
    
    var productFormulas = [ProductFormula]()
    override func viewDidLoad() {
        super.viewDidLoad()
        productFormulas = ProductViewModel().getProductFormulaOf(productNumber: product.product_number)
        lblProductName.text = product.name
        txtBatchNumber.layer.cornerRadius = 12
        UICutomButton.layer.cornerRadius = 15
        tableview.dataSource = self
        tableview.delegate = self
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func btnChooseStock(_ sender:UIButton){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ChooseStockForSpecificRawMaterialViewController") as! ChooseStockForSpecificRawMaterialViewController
        controller.modalPresentationStyle = .fullScreen
        controller.productFormula = productFormulas[sender.tag]
        self.present(controller, animated: true)
    }
}
