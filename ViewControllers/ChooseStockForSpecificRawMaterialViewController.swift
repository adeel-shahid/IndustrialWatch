//
//  ChooseStockForSpecificRawMaterialViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 17/04/2024.
//

import UIKit
import Toast_Swift
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
        cell.btnCheckBoxOutlet.addTarget(self, action: #selector(btnSelectStock(_ :)), for: .touchUpInside)
        return cell
    }
    

    var stockList = [String]()
    var predicate : ((_ stocks: [String])->Void)?
    @IBOutlet weak var UICustomButton: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var lblRawMaterialName: UILabel!
    var productFormula = ProductFormula(name: "Not Found", quantity: "", raw_material_id: 0)
    var rawMaterials = [RawMaterialDetails]()
    override func viewDidLoad() {
        super.viewDidLoad()
        stockList = [String]()
        rawMaterials = RawMaterialViewModel().getStockDetailOfRawMaterial(rawMaterialId: productFormula.raw_material_id)
        UICustomButton.layer.cornerRadius = 15
        UICustomButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnDone(_ :))))
        lblRawMaterialName.text = "Choose Stocks For \(productFormula.name)"
        tableview.dataSource = self
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @objc func btnSelectStock(_ sender: UIButton){
        if sender.isSelected {
            let stock =  rawMaterials[sender.tag].stock_number
            stockList.append(stock)
//            var navigationStock = NavigationStock(batch_per_day: 0, product_number: StaticItems.product.product_number, stock_list: stockList)
        }else if !sender.isSelected{
            let index = getIndexOf(stock: rawMaterials[sender.tag].stock_number)
            if index != -1{
                stockList.remove(at: index)
            }
        }
        print("\nUpdated Stock List:-       \(stockList)")
    }
    
    @objc func btnDone(_ sender: Any){
        if stockList.count == 0{
            view.makeToast("Atleast one Stock should be selected",  duration: 1, position: .bottom)
        }else{
            predicate?(stockList)
            self.dismiss(animated: true)
        }
    }
    
    func getIndexOf(stock: String)->Int{
        var i = 0
        while i < stockList.count{
            if stockList[i] == stock{
                return i
            }
            i += 1
        }
        return -1
    }
    
}
