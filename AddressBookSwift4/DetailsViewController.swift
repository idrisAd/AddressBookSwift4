//
//  DetailsViewController.swift
//  AddressBookSwift4
//
//  Created by Idris Adrien on 25/10/2017.
//  Copyright © 2017 Idris Adrien. All rights reserved.
//

import UIKit


protocol DetailsViewControllerDelegate: AnyObject {
    func deletePerson(person: Person) -> Void
}

class DetailsViewController: UIViewController {
    
    weak var person : Person?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = person?.lastName
        
        firstNameLabel.text = person?.firstName
        lastNameLabel.text = person?.lastName
        
        
        appDelegate().downloadResource(url: URL(string: (person?.avatarUrl!)!)!) { (data) in
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*let picture = "https://i.imgur.com/jNNT4LE.jpg"*/
    
    
    
    
    
    var deleteDelegate : DetailsViewControllerDelegate?
    @IBAction func deleteButton(_ sender: Any) {
        let alertController : UIAlertController = UIAlertController(title: "Suppression du contact", message: "Voulez-vous vraiment supprimer ?", preferredStyle: UIAlertControllerStyle.alert)
        let confirmAction = UIAlertAction(title: "SUPPRIMER", style: UIAlertActionStyle.destructive, handler: {
            alert -> Void in
            
            print("Suppression")
            self.deleteDelegate?.deletePerson(person: self.person!)
        })
        let cancelAction = UIAlertAction(title: "Annuler", style: UIAlertActionStyle.cancel, handler: {
            alert -> Void in
            
            print("Annulation suppression")
            
        })
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
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


