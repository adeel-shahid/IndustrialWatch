import UIKit

class CustomDropDownController: UIViewController {
    // Checkbox button
    let checkboxButton = UIButton()
    
    // Dropdown options
    let dropdownOptions = ["Option 1", "Option 2", "Option 3"]
    
    // Dropdown table view
    let dropdownTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up checkbox button
        checkboxButton.setTitle("Select Option", for: .normal)
        checkboxButton.addTarget(self, action: #selector(checkboxButtonTapped), for: .touchUpInside)
        
        // Set up dropdown table view
        dropdownTableView.dataSource = self
        dropdownTableView.delegate = self
        dropdownTableView.isHidden = true
        
        // Add subviews
        view.addSubview(checkboxButton)
        view.addSubview(dropdownTableView)
        
        // Layout
        // Implement layout constraints as needed
    }
    
    @objc func checkboxButtonTapped() {
        dropdownTableView.isHidden = !dropdownTableView.isHidden
    }
}

extension CustomDropDownController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropdownOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = dropdownOptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        checkboxButton.setTitle(dropdownOptions[indexPath.row], for: .normal)
        dropdownTableView.isHidden = true
        // Handle selection as needed
    }
}
