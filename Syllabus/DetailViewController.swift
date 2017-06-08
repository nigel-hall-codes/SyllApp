//
//  ViewController.swift
//  Syllabus
//
//  Created by Carlos on 6/5/17.
//  Copyright © 2017 Carlos. All rights reserved.
//

import UIKit

// In order to use the camera you have to add { UIImagePickerControllerDelegate, UINavigationControllerDelegate}
//    into viewController

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var classLabel: UILabel!
    var className: String = "Default"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        classLabel.text = className
        // Do any additional setup after loading the view, typically from a nib.
        }
    
    
    // Take Picture button
    @IBAction func takePicture(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.camera;
            picker.allowsEditing = false
            self.present(picker, animated: false, completion: nil)
        }
        
       
    }
    
    
    
    // Image view
    @IBOutlet var image: UIImageView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

