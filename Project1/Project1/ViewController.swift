//
//  ViewController.swift
//  Project1
//
//  Created by Sean Carrington on 21/02/2019.
//  Copyright © 2019 seanzi86. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let fileManager = FileManager.default;
        let path = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: path);
        
        for item in items{
            if (item.hasPrefix("nssl")){
                pictures.append(item);
            }
        }
        
        pictures = pictures.sorted(by: <)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //1: try loading the "Detail" view controller and typecasting it to be DetailViewController.
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            //2. success! Set its selectedImage property.
            viewController.selectedImage = pictures[indexPath.row];
            viewController.selectedImageNumber = indexPath.row + 1;
            viewController.imageCount = pictures.count
            
            //3. now push it onto the navigation controller.
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

