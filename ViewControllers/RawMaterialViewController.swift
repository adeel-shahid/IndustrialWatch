//
//  RawMaterialViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 03/04/2024.
//

import UIKit
import Toast_Swift
class RawMaterialViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rawmaterials.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! RawTableViewCell
        cell.lblRawMaterialName.text = rawmaterials[indexPath.row].name
        cell.btnEditOutlet.tag = indexPath.row
        cell.btnEditOutlet.addTarget(self, action: #selector(btnEditAction(_ :)), for: .touchUpInside)
        return cell
    }
    
    @IBOutlet weak var tableview: UITableView!
    var rawmaterials = [RawMaterials]()
    override func viewDidLoad() {
        super.viewDidLoad()
        rawmaterials = RawMaterialViewModel().getRawMaterials()
        tableview.dataSource = self
        tableview.delegate = self
        
    }
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func btnEditAction(_ sender: UIButton){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "UpdateRawMaterialViewController") as! UpdateRawMaterialViewController
        controller.rawMaterial = rawmaterials[sender.tag]
        controller.predicate = { [unowned self] in
            view.makeToast("RawMaterial Updated Successfully", duration: 2.0, position: .bottom)
            rawmaterials = RawMaterialViewModel().getRawMaterials()
            tableview.reloadData()
        }
        controller.modalPresentationStyle = .automatic
        self.present(controller, animated: true)
    }
    
    
    @IBAction func btnAddRawMaterial(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "AddRawMaterialViewController") as! AddRawMaterialViewController
        controller.predicate = {[unowned self] in
            view.makeToast("Raw material Successfully Added", duration: 2.0, position: .bottom)
            self.rawmaterials = RawMaterialViewModel().getRawMaterials()
            tableview.reloadData()
        }
        controller.modalPresentationStyle = .automatic
        self.present(controller, animated: true)
    }
    
}
