//
//  ScanningViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 29/05/2024.
//

import UIKit
import DropDown
import PhotosUI
import Toast_Swift
import Photos
class ScanningViewController: UIViewController, PHPickerViewControllerDelegate ,UIImagePickerControllerDelegate & UINavigationControllerDelegate{

    @IBOutlet weak var lblTotalPieces: UILabel!
    
    @IBOutlet weak var lblDefectedPieces: UILabel!
    @IBOutlet weak var lblCasting: UILabel!
    
    @IBOutlet weak var lblMilling: UILabel!
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
    
    
    
    @IBOutlet weak var lblToling: UILabel!
    
    @IBOutlet weak var btnUploadOutlet: UIButton!
    @IBOutlet weak var btnBatchesDropDown: UIButton!
    @IBOutlet weak var btnProductDropDown: UIButton!
    @IBOutlet weak var batchesContainer: UIView!
    @IBOutlet weak var productContainer: UIView!
    @IBOutlet weak var lblBatchesDropDown: UILabel!
    @IBOutlet weak var lblProductDropDown: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var product = ""
    var batch = ""
    var products = [Product]()
    var medias = [Media]()
    var batches = [BatchStatus]()
    let productDropDown = DropDown()
    let batchesDropDown = DropDown()
    var productString = [String]()
    var batchesString = [String]()
    var product_number = ""
    var batch_number = ""
    var imagepicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentImagePicker(_ :))))
        btnBatchesDropDown.addTarget(self, action: #selector(showBatchDropDown(_ :)), for: .touchUpInside)
        btnProductDropDown.addTarget(self, action: #selector(showProductDropDown(_ :)), for: .touchUpInside)
        PHPhotoLibrary.requestAuthorization{ status in
            switch status{
            case .authorized:
                print("access authorized")
            case .denied, .restricted, .notDetermined:
                print("access denied")
            default:
                break;
            }
        }
        
        
        batchesContainer.layer.cornerRadius = 10
        productContainer.layer.cornerRadius = 10
        products = ProductViewModel().getLinkedProducts()
        
        for productname in products{
            self.productString.append(productname.name)
        }
        if self.productString.count == 0{
            lblProductDropDown.text = "No Product Found"
        }else{
            lblProductDropDown.text = "Select Product"
        }
        if self.batchesString.count == 0{
            lblBatchesDropDown.text = "No Batches Found"
        }else{
            lblBatchesDropDown.text = "Select Batches"
        }
        //Product
        productDropDown.anchorView = productContainer
        productDropDown.dataSource = self.productString
        productDropDown.selectionAction = { [unowned self] (index:
            Int, item: String) in
            lblProductDropDown.text = item
            self.batches = BatchViewModel().getAllBatchesOf(productNumber: self.products[index].product_number)
            self.product_number = self.products[index].product_number
            for batchname in batches{
                batchesString.append(batchname.batch_number)
            }
            if self.batchesString.count == 0{
                lblBatchesDropDown.text = "No Batches Found"
            }else{
                lblBatchesDropDown.text = "Select Batches"
                self.batchesDropDown.dataSource = self.batchesString
            }
            
        }
        
        productDropDown.bottomOffset = CGPoint(x: 0,
            y: (productDropDown.anchorView?.plainView.bounds.height)!)
        productContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showProductDropDown(_ :))))
        
        //Batches
        batchesDropDown.anchorView = batchesContainer
        batchesDropDown.dataSource = batchesString
        batchesDropDown.selectionAction = { [unowned self] (index:
            Int, item: String) in
            lblBatchesDropDown.text = item
            self.batch_number = item
            self.btnUploadOutlet.isHidden = false
        }
        batchesDropDown.bottomOffset = CGPoint(x: 0,
            y: (productDropDown.anchorView?.plainView.bounds.height)!)
        batchesContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showBatchDropDown(_ :))))
    }

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func showProductDropDown(_ sender: Any){
        productDropDown.show()
    }
    
    @objc func showBatchDropDown(_ sender: Any){
        batchesDropDown.show()
    }
    
    @IBAction func btnUpload(_ sender: Any) {
        if selectedImages.count < 5{
            view.makeToast("Please Select 6 Images", duration: 2.0, position: .bottom)
        }
        do{
            if self.product_number == "" &&
                self.batch_number == ""{
                view.makeToast("Product Number and Batch Number is Empty", duration: 2, position: .bottom)
                return
            }
            try uploadImages(images: self.selectedImages, productNumber: self.product_number, batchNumber: self.batch_number)
        }catch{
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func uploadImages(images: [UIImage], productNumber: String, batchNumber: String) throws {
        let url = URL(string: "\(APIWrapper().getbaseURLString())Production/DefectMonitoring")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 3600 // 5 minutes in seconds

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        // Append product_number
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"product_number\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(productNumber)\r\n".data(using: .utf8)!)

        // Append batch_number
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"batch_number\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(batchNumber)\r\n".data(using: .utf8)!)

        // Append images
        for (index, image) in images.enumerated() {
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"images\"; filename=\"image\(index + 1).jpg\"\r\n".data(using: .utf8)!)
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
                let decoder = JSONDecoder()
                do {
                    let responseString = String(data: data, encoding: .utf8)
                    print("Response: \(responseString ?? "No response data")")
                    let defectedItem = try decoder.decode(DefectedItem.self, from: data)
                    print("Defected Item: \(defectedItem)")
                    var diskSummary = [DiskSumary]()
                    DispatchQueue.main.async {
                        self.lblDefectedPieces.text = "\(defectedItem.total_defected_items)"
                        self.lblTotalPieces.text = "\(defectedItem.total_items)"
                        for def in defectedItem.defects {
                            var summary = DiskSumary(name: "", count: 0)
                            if let casting = def.casting {
                                self.lblCasting.text = "\(casting)"
                                summary.name = "casting"
                                summary.count = casting
                                diskSummary.append(summary)
                            } else if let milling = def.milling {
                                self.lblMilling.text = "\(milling)"
                                summary.name = "milling"
                                summary.count = milling
                                diskSummary.append(summary)
                            } else if let tolling = def.tooling {
                                self.lblToling.text = "\(tolling)"
                                summary.name = "tolling"
                                summary.count = tolling
                                diskSummary.append(summary)
                            } else if let cap = def.cap{
                                summary.name = "cap"
                                summary.count = cap
                                diskSummary.append(summary)
                            } else if let label = def.label{
                                summary.name = "label"
                                summary.count = label
                                diskSummary.append(summary)
                            }else if let yarn = def.yarn{
                                summary.name = "yarn"
                                summary.count = yarn
                                diskSummary.append(summary)
                            }else if let hole = def.hole{
                                summary.name = "hole"
                                summary.count = hole
                                diskSummary.append(summary)
                            }
                        }
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "DefectDetectionSummaryViewController") as! DefectDetectionSummaryViewController
                        controller.modalPresentationStyle = .fullScreen
                        controller.diskSummary = diskSummary
                        controller.total = defectedItem.total_items
                        controller.defected = defectedItem.total_defected_items
                        self.present(controller, animated: true)
                    }
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                }
            }
        }

        task.resume()
    }

    
}
struct DefectedItem:Codable{
    var defects : [Defects]
    var total_defected_items : Int
    var total_items : Int
}

struct Defects: Codable {
    var casting: Int?
    var tooling: Int?
    var milling: Int?
    var hole : Int?
    var yarn : Int?
    var cap : Int?
    var label : Int?
}
