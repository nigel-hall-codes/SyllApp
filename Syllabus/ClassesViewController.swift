//
//  ClassesViewController.swift
//  Syllabus
//
//  Created by Nigel Hall on 6/6/17.
//  Copyright © 2017 Carlos. All rights reserved.
//

import UIKit
import RealmSwift


class classTableViewCell: UITableViewCell {
    
    @IBOutlet weak var classTableIViewLabel: UILabel!
    
    @IBOutlet weak var celldetailLabel: UILabel!
    
    
    
}
    




class ClassesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    let realm = try? Realm()
    var classes: [Class] = []
    
    
    
    
    
    @IBAction func AddClassButton(_ sender: Any) {
        
        
        //Heres the alert box for adding a class
        let alertController = UIAlertController(title: "What class?", message: "Enter name and description:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            let firstTextField = alertController.textFields![0] as UITextField
            let secondTextField = alertController.textFields![1] as UITextField
            self.classes.append(Class(name: firstTextField.text!, description:secondTextField.text!))
            
            print("button pressed")
            print(self.classes[0].name)
            print(self.classes[0].description)
            print(self.classes.count)
            
            self.addClass(name: firstTextField.text!, desc: secondTextField.text!)
            
            
            
            
            
            
            self.tableView.reloadData()
            
        }
        
        
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

   
    func addClass(name: String, desc:String){
        let actclass = theClass()
        actclass.name = name
        actclass.descriptions = desc
        
        do{
            
        
        try self.realm?.write {
            self.realm?.add(actclass)
            print("Added \(name)" )
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
    
    func getClasses() -> Results<theClass> {
        let realm = try? Realm()
        let allclasses = realm?.objects(theClass)
        
        return allclasses!
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return getClasses().count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let theclasses = getClasses()
        print("Hello\(theclasses[1].name)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! classTableViewCell
        let cl = theclasses[indexPath[1]]
        cell.classTableIViewLabel.text? = cl.name
        cell.celldetailLabel.text? = cl.descriptions
        
     
        
        print(indexPath)
        return cell
        
    }
    
    var valueToPass: String?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let theClasses = getClasses()
        
        valueToPass = theClasses[indexPath[1]].name
        
        performSegue(withIdentifier: "toDetail", sender: nil)
        print(valueToPass!)
    }
    
    
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
