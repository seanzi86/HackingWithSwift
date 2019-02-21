//
//  DetailViewController.swift
//  Project1
//
//  Created by Sean Carrington on 21/02/2019.
//  Copyright © 2019 seanzi86. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedImageNumber: Int?
    var imageCount: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Picture \(selectedImageNumber!) of \(imageCount!)"
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
