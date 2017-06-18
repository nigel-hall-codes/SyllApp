//
//  ViewController.swift
//  Syllabus
//
//  Created by Carlos on 6/5/17.
//  Copyright © 2017 Carlos. All rights reserved.
//

import UIKit
import TesseractOCR

// In order to use the camera you have to add { UIImagePickerControllerDelegate, UINavigationControllerDelegate}
//    into viewController


class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, G8TesseractDelegate{
    
    @IBOutlet weak var UpcomingTableView: UITableView!
    
    @IBOutlet weak var classLabel: UILabel!
    var className: String = "Default"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        UpcomingTableView.dataSource = self
        UpcomingTableView.delegate = self
        classLabel.text = className
        // Do any additional setup after loading the view, typically from a nib.
        }
    
    
    // Take Picture button
    @IBAction func cameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
        
        }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            analyzeImage(image: image)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
        
//    Text Analysis
    
    func analyzeImage(image: UIImage) {
        
    
        if let tesseract = G8Tesseract(language: "eng"){
            tesseract.delegate = self
            tesseract.image = image.g8_blackAndWhite()
            tesseract.recognize()
            print(tesseract.recognizedText)
            
            
        }
    }
    
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print("Recognition Process \(tesseract.progress) %")
        }

        
    
    
    
//    Tableview setup
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Assignment \(indexPath[1])      due \(indexPath[1]) days from now"
        return cell
    }
    
    
   
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

