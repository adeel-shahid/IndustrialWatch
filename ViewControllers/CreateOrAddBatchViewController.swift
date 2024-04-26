//
//  CreateOrAddBatchViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 17/04/2024.
//

import UIKit
import Toast_Swift
class CreateOrAddBatchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productFormulas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell1") as! ChoosedStockTableViewCell
        cell.lblSerial.text = "\(indexPath.row + 1)"
        cell.lblName.text = productFormulas[indexPath.row].name
        var stringQuantity = productFormulas[indexPath.row].quantity
        var quantity : Float = Float(stringQuantity.split(separator: " ")[0]) ?? 0.0
        cell.lblQuantity.text = productFormulas[indexPath.row].quantity
        cell.btnChooseStock.tag = indexPath.row
        cell.btnChooseStock.addTarget(self, action: #selector(btnChooseStock(_ :)), for: .touchUpInside)
        return cell
        
    }
    
    var stocks = [Stocks]()
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var txtBatchNumber: UITexfield_Additions!
    @IBOutlet weak var UICutomButton: UIView!
    @IBOutlet weak var lblProductName: UILabel!
    var product = Product(name: "Not Found", product_number: "")
    var messagePredicate : (() -> Void)?
    var stockList = [String]()
    var productFormulas = [ProductFormula]()
    override func viewDidLoad() {
        super.viewDidLoad()
        productFormulas = ProductViewModel().getProductFormulaOf(productNumber: product.product_number)
        lblProductName.text = product.name
        txtBatchNumber.layer.cornerRadius = 12
        UICutomButton.layer.cornerRadius = 15
        UICutomButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnCreateBatch(_ :))))
        tableview.dataSource = self
        tableview.delegate = self
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func btnChooseStock(_ sender:UIButton){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ChooseStockForSpecificRawMaterialViewController") as! ChooseStockForSpecificRawMaterialViewController
        controller.predicate = {[unowned self] stocks in
            stockList = stocks
            let s = Stocks(stocks: stockList)
            self.stocks.append(s)
        }
        controller.modalPresentationStyle = .fullScreen
        controller.productFormula = productFormulas[sender.tag]
        self.present(controller, animated: true)
    }
    
    @objc func btnCreateBatch(_ sender: UIButton){
        guard let batches = txtBatchNumber.text, !txtBatchNumber.text!.isEmpty,
                self.productFormulas.count == self.stocks.count
        else {
            view.makeToast("Enter Batch Per Day and select the required stock", duration: 2 ,position: .bottom)
            return
        }
        let navigationStock = NavigationStock(batch_per_day: Int(batches) ?? 0, product_number: StaticItems.product.product_number, stock_list: self.stocks)
        let response = BatchViewModel().createBatches(navigationStock: navigationStock)
        if response.ResponseCode == 200{
            messagePredicate?()
            self.dismiss(animated: true)
        }else{
            let alert = UIAlertController(title: "Error", message: response.ResponseMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive))
            self.present(alert, animated: true)
        }
    }
    
}
