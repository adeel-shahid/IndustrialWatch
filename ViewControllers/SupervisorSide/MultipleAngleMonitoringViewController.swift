//
//  MultipleAngleMonitoringViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 23/06/2024.
//

import UIKit
import PhotosUI

class MultipleAngleMonitoringViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,PHPickerViewControllerDelegate, FrontViewDelegate, BackViewDelegate {
    func didPickBackImage(_ image: UIImage) {
        DispatchQueue.main.async {
           self.backImageView.image = image
        }
    }
    
    func didPickImage(_ image: UIImage) {
        DispatchQueue.main.async {
           self.frontImageView.image = image
        }
    }
    
    
    var frontview : FrontView?
    var backview : BackView?
    
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
        configuration.selectionLimit = 50 // Set maximum selection limit to 6
        configuration.filter = .images // Specify that only images should be selectable
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        present(picker, animated: true, completion: nil)
    }
    
    
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
                            self.setUpImageScrollView()
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
                self.setUpImageScrollView()
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ScrollViewContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        frontview = FrontView()
        frontview?.delegate = self
        backview = BackView()
        backview?.delegate = self
        printAnglesMonitoringResponse = { [weak self] response in
                    guard let self = self else { return }
                    guard let response = response else {
                        print("No response received or failed to decode response.")
                        return
                    }
                    let status = "Status: \(response.status)"
                    let front = "Front Defects: \(response.defects_report.front.joined(separator: ", "))"
                    let back = "Back Defects: \(response.defects_report.back.joined(separator: ", "))"
                    print(status)
                    print(front)
                    print(back)
                    var sides = [String]()
                    for sideDefect in response.defects_report.sides {
                        sides.append("Side \(sideDefect.side): \(sideDefect.defect)")
                        print("Side \(sideDefect.side): \(sideDefect.defect)")
                    }
                    print(sides)
                    
                    // Navigate to the new view controller
                    DispatchQueue.main.async {
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MultipleAngleMonitoringResponseViewController") as! MultipleAngleMonitoringResponseViewController
                        controller.modalPresentationStyle = .automatic
                        // Pass the response data to the new view controller if needed
                        controller.status = status
                        controller.front = front
                        controller.back = back
                        controller.sideDefects = sides
                        self.present(controller, animated: true)
                    }
                }
    }
    var medias = [Media]()
    var selectedImages = [UIImage]()
    func setUpImageScrollView() {
        // Calculate the height of the scroll view to fit within the parent view
        let scrollViewHeight = self.ScrollViewContainer.frame.height - 40
        
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.bounces = false // Optional: to prevent bouncing effect vertically
        
        DispatchQueue.main.async { [self] in
            for i in 0..<self.selectedImages.count {
                    let imageView = UIImageView(frame: CGRect(x: CGFloat(i) * scrollView.frame.width, y: 0, width: scrollView.frame.width, height: scrollViewHeight))
                    imageView.contentMode = .scaleAspectFit
                    imageView.image = self.selectedImages[i] // Set image directly from self.images array
                    
                    // Update scroll view content size after setting the image
                    let contentWidth = CGFloat(self.selectedImages.count) * self.scrollView.frame.width
                    scrollView.contentSize = CGSize(width: contentWidth, height: scrollViewHeight)
                    
                    scrollView.addSubview(imageView)
                }
        }
        
        pageController.numberOfPages = selectedImages.count
        pageController.currentPage = 0
        pageController.tintColor = UIColor.red // Change color as needed
        pageController.pageIndicatorTintColor = UIColor.lightGray // Change color as needed
        pageController.currentPageIndicatorTintColor = UIColor.black // Change color as needed
        pageController.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
        
        self.ScrollViewContainer.addSubview(scrollView)
    }
    
    @objc func changePage(sender: UIPageControl) {
        let x = CGFloat(sender.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageController.currentPage = Int(pageIndex)
    }
    
    
    @IBAction func btnSelectFourSideImages(_ sender: Any) {
        self.presentImagePicker(sender)
    }
    
    @IBAction func btnSelectFrontImage(_ sender: Any) {
        self.frontview?.presentPicker(from: self)
    }
    
    @IBAction func btnSelectBackImage(_ sender: Any) {
        self.backview?.presentPicker(from: self)
    }
    
    var printAnglesMonitoringResponse: ((AnglesMonitoringResponse?) -> Void)?
    
    @IBAction func btnStartMonitoring(_ sender: Any) {
        anglesMonitoring(frontImage: self.frontImageView.image!, backImage: self.backImageView.image!, sideImages: self.selectedImages, completion: printAnglesMonitoringResponse!)
//        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MultipleAngleMonitoringResponseViewController")
//        controller?.modalPresentationStyle = .automatic
//        self.present(controller!, animated: true)
        
    }
    
    func anglesMonitoring(frontImage: UIImage, backImage: UIImage, sideImages: [UIImage], completion: @escaping (AnglesMonitoringResponse?) -> Void) {
        guard let url = URL(string: "http://10.211.55.3:5000/api/Production/AnglesMonitoring") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var requestBodyData = Data()
        
        func appendImageData(_ imageData: Data, withName name: String, filename: String) {
            requestBodyData.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            requestBodyData.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
            requestBodyData.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            requestBodyData.append(imageData)
        }
        
        if let frontImageData = frontImage.jpegData(compressionQuality: 1.0) {
            appendImageData(frontImageData, withName: "front", filename: "front.jpeg")
        }
        
        if let backImageData = backImage.jpegData(compressionQuality: 1.0) {
            appendImageData(backImageData, withName: "back", filename: "back.jpeg")
        }
        
        for (index, sideImage) in sideImages.enumerated() {
            if let sideImageData = sideImage.jpegData(compressionQuality: 1.0) {
                appendImageData(sideImageData, withName: "sides", filename: "side\(index+1).jpeg")
            }
        }
        
        requestBodyData.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = requestBodyData
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 3600
        sessionConfig.timeoutIntervalForResource = 3600.0
        let session = URLSession(configuration: sessionConfig)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(AnglesMonitoringResponse.self, from: data)
                completion(response)
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        task.resume()
    }

    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}


class FrontView: NSObject, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker: UIImagePickerController?
    weak var delegate: FrontViewDelegate?
    
    override init() {
        super.init()
        setupImagePicker()
    }
    
    func setupImagePicker() {
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.sourceType = .photoLibrary  // Example: Use the photo library for image picking
    }
    
    func presentPicker(from viewController: UIViewController) {
        if let picker = imagePicker {
            viewController.present(picker, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            delegate?.didPickImage(pickedImage)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

protocol FrontViewDelegate: AnyObject {
    func didPickImage(_ image: UIImage)
}


class BackView: NSObject, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker: UIImagePickerController?
    weak var delegate: BackViewDelegate?
    
    override init() {
        super.init()
        setupImagePicker()
    }
    
    func setupImagePicker() {
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.sourceType = .photoLibrary  // Example: Use the photo library for image picking
    }
    
    func presentPicker(from viewController: UIViewController) {
        if let picker = imagePicker {
            viewController.present(picker, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            delegate?.didPickBackImage(pickedImage)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

protocol BackViewDelegate: AnyObject {
    func didPickBackImage(_ image: UIImage)
}



struct AnglesMonitoringResponse: Codable {
    let status: String
    let defects_report: DefectsReport
}

struct DefectsReport: Codable {
    let front: [String]
    let back: [String]
    let sides: [SideDefect]
}

struct SideDefect: Codable {
    let side: Int
    let defect: String
}
 
