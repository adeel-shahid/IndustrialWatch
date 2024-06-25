//
//  LoaderViewController.swift
//  IndustrialWatch
//
//  Created by Adeel's MacBook on 11/06/2024.
//

import UIKit

class LoaderViewController: UIViewController {
    
    @IBOutlet weak var loaderImage: UIImageView!
    @IBOutlet weak var loaderContainerView: UIView!
    init() {
        super.init(nibName: "LoaderViewController", bundle: Bundle(for: LoaderViewController.self))
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loaderContainerView.layer.borderWidth = 1.0
        loaderContainerView.layer.borderColor = UIColor.clear.cgColor
        loaderContainerView.layer.cornerRadius = 10
        loaderContainerView.clipsToBounds = true
    }

    
    private func startAnimation() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = 2 * Double.pi
        rotation.duration = 1.0
        rotation.repeatCount = .infinity
        loaderImage.layer.add(rotation, forKey: "spin")
    }


    private func stopAnimation() {
        loaderImage.layer.removeAllAnimations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation()
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAnimation()
    }
    
}
