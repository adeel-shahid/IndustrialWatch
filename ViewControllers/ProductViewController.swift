//
//  ProductViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 09/04/2024.
//

import UIKit
import Toast_Swift
class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        controller.product = products[indexPath.row]
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! ProductTableViewCell
        cell.lblProductName.text = products[indexPath.row].name
        return cell
    }
    
    var products = [Product]()
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var UICustomButton: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        products = ProductViewModel().getLinkedProducts()
        tableview.dataSource = self
        tableview.delegate = self
        UICustomButton.layer.cornerRadius = 20
        UICustomButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnLinkProduct(_ :))))
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func btnLinkProduct(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "LinkProductViewController") as! LinkProductViewController
        controller.predicate = { [unowned self] in
            view.makeToast("Product Linked Successfully", duration: 3.0, position: .bottom)
            products = ProductViewModel().getLinkedProducts()
            tableview.reloadData()
        }
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
}
