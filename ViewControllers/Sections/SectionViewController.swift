//
//  SectionViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 21/02/2024.
//

import UIKit
import Toast_Swift
class SectionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (!sections.isEmpty) ? sections.count : 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "SectionDetailsViewController") as! SectionDetailsViewController
        controller.sectionName = sections[indexPath.row].name
        controller.id = sections[indexPath.row].id
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let emptyCell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell")as! EmptyTableViewCell
        if sections.isEmpty {
            return emptyCell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! SectionsTableViewCell
        cell.sectionName = sections[indexPath.row].name
        cell.btnEditOutlet.tag = indexPath.row
        cell.btnArchievedOutlet.tag = indexPath.row
        cell.btnEditOutlet.addTarget(self, action: #selector(btnEdit(_:)), for: .touchUpInside)
        cell.btnArchievedOutlet.addTarget(self, action: #selector(btnArchieved(_:)), for: .touchUpInside)
        return cell
    }
    @IBOutlet weak var UICustomButtonArchieve: UIView!
    @IBOutlet weak var tableView: UITableView!
    var sections = [Section]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        UICustomButtonArchieve.layer.cornerRadius = 8
        UICustomButtonArchieve.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigateToArchivedSections(_ :))))
        do{
            self.sections = try fetchSections()
            self.tableView.reloadData()
        }catch{
            let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    
    private func fetchSections()throws -> [Section]{
        var sectionLocal = [Section]()
        sectionLocal = SectionViewModel().getAllSections(withStatus: 1)
        return sectionLocal
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func btnEdit(_ sender: UIButton){
        let controller = storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        controller.sectionName = sections[sender.tag].name
        controller.section_id = sections[sender.tag].id
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
    @objc func btnArchieved(_ sender: UIButton){
        let response: APIMessage = SectionViewModel().changeSectionStatus(withId: self.sections[sender.tag].id)
        if response.ResponseCode == 200{
            sections.remove(at: sender.tag)
            do{
                self.sections = try fetchSections()
                self.tableView.reloadData()
            }catch{
                let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                self.present(alert, animated: true)
            }
            view.makeToast("Section Archieved Successfully",duration: 2, position: .bottom)
        }
    }
    
    @IBAction func btnAddSection(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "AddSectionViewController") as! AddSectionViewController
        controller.modalPresentationStyle = .fullScreen
        controller.predicate = { [unowned self] in
            do{
                self.sections = try fetchSections()
                self.tableView.reloadData()
            }catch{
                let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                self.present(alert, animated: true)
            }
        }
        self.present(controller, animated: true)
    }
    
    @objc func navigateToArchivedSections(_ sender: Any){
        let controller = storyboard?.instantiateViewController(withIdentifier: "ArchivedSectionViewController") as! ArchivedSectionViewController
        controller.predicate = { [unowned self] in
            do{
                self.sections = try fetchSections()
                self.tableView.reloadData()
            }catch{
                let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                self.present(alert, animated: true)
            }
        }
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
}
