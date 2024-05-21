//
//  AddEmployeeViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 26/04/2024.
//

import UIKit
import DropDown
import PhotosUI
import Toast_Swift
class AddEmployeeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,PHPickerViewControllerDelegate {
    
        
        func openCamera() throws -> Void{
            selectedImages.removeAll()
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
        
        func openPhotoLibrary() {
            selectedImages.removeAll()
            var configuration = PHPickerConfiguration()
            configuration.selectionLimit = 6 // Set maximum selection limit to 6
            configuration.filter = .images // Specify that only images should be selectable
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            
            present(picker, animated: true, completion: nil)
        }
        
        // MARK: - PHPickerViewControllerDelegate
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            dismiss(animated: true, completion: nil)
            
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        if let image = image as? UIImage {
                            self.selectedImages.append(image)
                            let media = Media(withImage: image, forKey: "files", imageName: "img")
                            self.medias.append(media!)
                            // Reload UICollectionView data on the main thread
                            DispatchQueue.main.async {
                                self.imageView.image = image
                            }
                        }
                    }
                }
            }
        }
        
        // MARK: - UIImagePickerControllerDelegate
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                self.selectedImages.append(selectedImage)
                let media = Media(withImage: selectedImage, forKey: "files", imageName: "img")
                medias.append(media!)
                // Reload UICollectionView data on the main thread
                DispatchQueue.main.async {
                    self.imageView.image = selectedImage
                }
            }
            dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    var selectedImages = [UIImage]() // Array to hold selected images


        // Function to present PHPicker
    @objc func presentImagePicker(_ sender: Any) {
        let alertController = UIAlertController(title: "Select Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Take Photo", style: .default) { (action) in
            do{
                try self.openCamera()
            }catch{
                let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
                self.present(alert, animated: true)
            }
        }
        
        let photoLibraryAction = UIAlertAction(title: "Choose From Library", style: .default) { (action) in
            self.openPhotoLibrary()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
//        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        }




    var imagepicker = UIImagePickerController()
    
    @IBOutlet weak var txtSalary: UITexfield_Additions!
    @IBOutlet weak var lblSelectedRole: UILabel!
    @IBOutlet weak var lblSelectedSection: UILabel!
    @IBOutlet weak var dropDownRoleView: UIView!
    @IBOutlet weak var dropDownSectionView: UIView!
    @IBOutlet weak var txtPasswords: UITexfield_Additions!
    @IBOutlet weak var txtUsername: UITexfield_Additions!
    @IBOutlet weak var txtName: UITexfield_Additions!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var rdbPartTimeOutlet: UIButton!
    @IBOutlet weak var rdbFullTimeOutlet: UIButton!
    @IBOutlet weak var rdbFemaleOutlet: UIButton!
    @IBOutlet weak var rdbMaleOutlet: UIButton!
    var medias = [Media]()
    let sectionDropDown = DropDown()
    let roleDropDown = DropDown()
    var sectionName = [String]()
    var jobNames = [String]()
    var sections = [Section]()
    var sectionIndex = 0
    var jobIndex = 0
    var jobRoles = [JobRole]()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagepicker.delegate = self
        imageContainer.layer.cornerRadius = imageContainer.frame.size.width / 2
        imageContainer.clipsToBounds = true
        imageContainer.layer.borderWidth = 1
        imageContainer.layer.borderColor = UIColor.black.cgColor
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentImagePicker(_ :))))
        txtName.layer.cornerRadius = 10
        txtUsername.layer.cornerRadius = 10
        txtPasswords.layer.cornerRadius = 10
        txtSalary.layer.cornerRadius = 10
        dropDownSectionView.layer.cornerRadius = 10
        dropDownRoleView.layer.cornerRadius = 10
        sectionName = SectionViewModel().getAllSectionNames(withStatus: 1)
        self.sections = SectionViewModel().getAllSections(withStatus: 1)
        self.jobRoles = EmployeeViewModel().getJobRole()
        // Sections Drop Down
        sectionDropDown.dataSource = sectionName
        sectionDropDown.anchorView = dropDownSectionView
        sectionDropDown.selectionAction  = { [unowned self] (index: Int, item: String) in
            sectionIndex = index
            lblSelectedSection.text = item
        }
        sectionDropDown.bottomOffset = CGPoint(x: 0,
            y: (sectionDropDown.anchorView?.plainView.bounds.height)!)
        dropDownSectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showSectionDropDown(_ :))))
        jobNames = EmployeeViewModel().getJobRoleNames()
        // Role Drop Down
        roleDropDown.dataSource = jobNames
        roleDropDown.anchorView = dropDownRoleView
        roleDropDown.selectionAction  = { [unowned self] (index: Int, item: String) in
            jobIndex = index
            lblSelectedRole.text = item
        }
        roleDropDown.bottomOffset = CGPoint(x: 0,
            y: (roleDropDown.anchorView?.plainView.bounds.height)!)
        dropDownRoleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showRoleDropDown(_ :))))
    }

    @IBAction func rdbMale(_ sender: Any) {
        rdbMaleOutlet.isSelected = true
        rdbFemaleOutlet.isSelected = false
    }
    
    @IBAction func rdbFemale(_ sender: Any) {
        rdbMaleOutlet.isSelected = false
        rdbFemaleOutlet.isSelected = true
    }
    
    @IBAction func rdbFullTime(_ sender: Any) {
        rdbFullTimeOutlet.isSelected = true
        rdbPartTimeOutlet.isSelected = false
    }
    
    @IBAction func rdbPartTime(_ sender: Any) {
        rdbFullTimeOutlet.isSelected = false
        rdbPartTimeOutlet.isSelected = true
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        if selectedImages.count < 5{
            view.makeToast("Please Select 6 images at least", duration: 3, position: .bottom)
            return
        }
        guard let name = txtName.text, !txtName.text!.isEmpty,
              let username = txtUsername.text, !txtUsername.text!.isEmpty,
              let password = txtPasswords.text, !txtPasswords.text!.isEmpty,
              let salary = txtSalary.text, !txtSalary.text!.isEmpty,
              lblSelectedSection.text! != "--Select Section--",
              lblSelectedRole.text! != "--Select Role--"
        else{
            view.makeToast("Please Fill all the Text Fields and Select Section and Job Role", duration: 4, position: .bottom)
            return
        }
        if rdbMaleOutlet.isSelected == false &&
            rdbFemaleOutlet.isSelected == false{
            view.makeToast("Select Gender", duration: 3, position: .bottom)
            return
        }
        if rdbFullTimeOutlet.isSelected == false &&
            rdbPartTimeOutlet.isSelected == false{
            view.makeToast("Select Job Type", duration: 3, position: .bottom)
            return
        }
        var gender = ""
        if rdbMaleOutlet.isSelected{
            gender = "Male"
        }else{
            gender = "Female"
        }
        var jobType = ""
        if rdbPartTimeOutlet.isSelected{
            jobType = "Part Time"
        }else{
            jobType = "Full Time"
        }
        do{
            try uploadEmployeeData(name: name, salary: salary, username: username, password: password, jobRole: self.jobRoles[jobIndex].id, jobType: jobType, gender: gender, sectionId: self.sections[sectionIndex].id, images: selectedImages)
        }catch{
            let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.present(alert, animated: true)
        }
        
//        let parameters = [
//                    "name": name,
//                    "salary": salary,
//                    "username": username,
//                    "password": password,
//                    "job_role_id": self.jobRoles[jobIndex].id,
//                    "job_type": jobType,
//                    "gender": gender,
//                    "section_id": self.sections[sectionIndex].id
//        ] as [String : Any]
//
//        let parameterData = try? JSONSerialization.data(withJSONObject: parameters)
//        let apiMessage = APIWrapper().uploadImageToServer(images: medias, parameters: parameterData, endPoint: "Employee/AddEmployee")
//        if apiMessage.ResponseCode == 200{
//            view.makeToast("Employee Added Successfully", duration: 3, position: .bottom)
//            self.dismiss(animated: true)
//        }else{
//            let alert = UIAlertController(title: "Alert", message: apiMessage.ResponseMessage, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Ok", style: .destructive))
//            self.present(alert, animated: true)
//        }
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
 
    @IBAction func btnSectionDropDown(_ sender: Any) {
        sectionDropDown.show()
    }
    
    @IBAction func btnRoleDropDown(_ sender: Any) {
        roleDropDown.show()
    }
 
    @objc func showSectionDropDown(_ sender: Any){
        sectionDropDown.show()
    }
    @objc func showRoleDropDown(_ sender: Any){
        roleDropDown.show()
    }
    
    
    
    func uploadEmployeeData(name: String, salary: String, username: String, password: String, jobRole: Int, jobType: String, gender: String, sectionId: Int, images: [UIImage]) throws{
           let url = URL(string: "http://10.211.55.3:5000/api/Employee/AddEmployee")!
           var request = URLRequest(url: url)
           request.httpMethod = "POST"

           let boundary = UUID().uuidString
           request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

           var body = Data()

           let parameters = [
               "name": name,
               "salary": salary,
               "username": username,
               "password": password,
               "job_role_id": jobRole,
               "job_type": jobType,
               "gender": gender,
               "section_id": sectionId
           ] as [String : Any]

           for (key, value) in parameters {
               body.append("--\(boundary)\r\n".data(using: .utf8)!)
               body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
               body.append("\(value)\r\n".data(using: .utf8)!)
           }

           for (index, image) in images.enumerated() {
               if let imageData = image.jpegData(compressionQuality: 1.0) {
                   body.append("--\(boundary)\r\n".data(using: .utf8)!)
                   body.append("Content-Disposition: form-data; name=\"files\"; filename=\"image\(index + 1).jpg\"\r\n".data(using: .utf8)!)
                   body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                   body.append(imageData)
                   body.append("\r\n".data(using: .utf8)!)
               }
           }

           body.append("--\(boundary)--\r\n".data(using: .utf8)!)

           request.httpBody = body

           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   print("Error: \(error)")
                   return
               }

               if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                   print("Server error: \(response.statusCode)")
                   return
               }

               if let data = data {
                   let responseString = String(data: data, encoding: .utf8)
                   print("Response: \(responseString ?? "No response data")")
                   DispatchQueue.main.async {
                       self.view.makeToast("Employee Added Successfully", duration: 4, position: .bottom)
                       self.dismiss(animated: true)
                   }
               }
           }

           task.resume()
       }
}
