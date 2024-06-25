//
//  MultipleAngleMonitoringResponseViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 23/06/2024.
//

import UIKit

class MultipleAngleMonitoringResponseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideDefects.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "simpleCell")
        cell?.textLabel?.text = self.sideDefects[indexPath.row]
        return cell!
    }
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblBackDefect: UILabel!
    @IBOutlet weak var lblFrontDefects: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var container: UIView!
    var sideDefects = [String]()
    var status = "Status: Not Found"
    var front = "Front Defects: Not Found"
    var back = "Back Defects: Not Found"
    override func viewDidLoad() {
        super.viewDidLoad()
        container.layer.cornerRadius = 20
        lblStatus.text = status
        lblFrontDefects.text = front
        lblBackDefect.text = back
        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
