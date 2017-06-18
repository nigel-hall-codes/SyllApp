//
//  ClassesViewController.swift
//  Syllabus
//
//  Created by Nigel Hall on 6/6/17.
//  Copyright © 2017 Carlos. All rights reserved.
//

import UIKit
import RealmSwift
import TesseractOCR


class classTableViewCell: UITableViewCell {
    
    @IBOutlet weak var classTableIViewLabel: UILabel!
    
    @IBOutlet weak var celldetailLabel: UILabel!
    
    
    
}
    

class ClassesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, G8TesseractDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
//    Database initialization
    let realm = try? Realm()
   
    
    
    
    
    
    @IBAction func AddClassButton(_ sender: Any) {
        
        
        //Heres the alert box for adding a class
        let alertController = UIAlertController(title: "What class?", message: "Enter name and description:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            let name = alertController.textFields![0] as UITextField
        let desc = alertController.textFields![1] as UITextField
            
    
        
//            adds class to database
            
            self.addClass(name: name.text!, desc: desc.text!)
//        Reload the tableview
            self.tableView.reloadData()
            
        }
        
//        When alert is canceled blah blah
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Name"
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Description"
        }
        
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }

//        Here is the addClass function
    func addClass(name: String, desc:String){
        let actclass = theClass()
        actclass.name = name
        actclass.descriptions = desc
        
        do{
            
//         realm is the database framework for swift
            
        try self.realm?.write {
            self.realm?.add(actclass)
           
        }
        }catch{
            print("problem adding to realm")
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }
//    This returns the all the classes from the database
//    You can see whats in the database by going to RealmObjects.swift
    
    
    
    func getClasses() -> Results<theClass> {
        let realm = try? Realm()
        let allclasses = realm?.objects(theClass)
        
        return allclasses!
    }
    
    
//    Returns number of rows for the tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return getClasses().count
    }
    
//    For each row return the cell and its data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let theclasses = getClasses()
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! classTableViewCell
        let cl = theclasses[indexPath[1]]
        cell.classTableIViewLabel.text? = cl.name
        cell.celldetailLabel.text? = cl.descriptions
        
     
        
        print(indexPath)
        return cell
        
    }
//    This is what happens when you select a row
//    Valuetopass is the data being sent between view Controllers
    var valueToPass: String?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let theClasses = getClasses()
        
//        valueToPass is the data aka "name of class" to pass through the segue into detailViewController
        
        valueToPass = theClasses[indexPath[1]].name
        
        performSegue(withIdentifier: "toDetail", sender: nil)
        
        print(valueToPass!)
    }
    
//    This function is called before the actual segue to prepare the ViewControllers. Changes the global variable on detailViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetail") {
           
            // initialize new view controller and cast it as your view controller
            
            let viewController = segue.destination as! DetailViewController
            
            // your new view controller should have property that will store passed value

            viewController.className = valueToPass!
            
        }
    }
   
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
