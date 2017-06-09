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


class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    @IBAction func takePicture(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.camera;
            picker.allowsEditing = false
            self.present(picker, animated: false, completion: nil)
        }
        
       
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
    
    
    // Image view
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

