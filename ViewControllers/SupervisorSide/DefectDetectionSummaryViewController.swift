//
//  DefectDetectionSummaryViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 23/06/2024.
//

import UIKit

class DefectDetectionSummaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diskSummary.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 103
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! DefectDetectionSummaryTableViewCell
        cell.lblDefectName.text = diskSummary[indexPath.row].name
        cell.lblDefectCount.text = "\(diskSummary[indexPath.row].count)"
        return cell
    }
    
    @IBOutlet weak var lblDefectedItems: UILabel!
    @IBOutlet weak var lblTotalItems: UILabel!
    var diskSummary = [DiskSumary]()
    @IBOutlet weak var defectedItems: UILabel!
    @IBOutlet weak var totalItems: UILabel!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var tableView: UITableView!
    var total = 4
    var defected = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        container.layer.cornerRadius = 20
        lblTotalItems.text = "\(total)"
        lblDefectedItems.text = "\(defected)"
        diskSummary.append(DiskSumary(name: "yarn defect", count: 2))
        diskSummary.append(DiskSumary(name: "hole", count: 1))
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}
