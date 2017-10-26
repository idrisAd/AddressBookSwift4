//
//  AddViewController.swift
//  AddressBookSwift4
//
//  Created by Idris Adrien on 25/10/2017.
//  Copyright © 2017 Idris Adrien. All rights reserved.
//

import UIKit


protocol AddViewControllerDelegate: AnyObject {
    func createPerson(/*name: String*/person: Person)
}

class AddViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var prenomText: UITextField!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    weak var delegate: AddViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Person"
        self.progressBar.progress = 0

        // Do any Ëdditional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonPress(_ sender: Any) {
        print("ajout")
        guard let nameField = self.nameText.text , let prenomField = self.prenomText.text else{
            return
        }
        let context = self.appDelegate().persistentContainer.viewContext
        let personne = Person(entity: Person.entity(), insertInto: context)
        personne.firstName = prenomField
        personne.lastName = nameField
        var progressB = self.progressBar.progress
        
        
        DispatchQueue.global(qos: .background).async {
            let counter: Float = 0.0
            while progressB < 1{
                Thread.sleep(forTimeInterval: 0.05)
                progressB += 0.1
                
                DispatchQueue.main.async {
                    self.progressLabel.text = "\(counter)"
                }
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            while progressB < 1{
                Thread.sleep(forTimeInterval: 0.05)
                progressB += 0.1
                
                DispatchQueue.main.async {
                    self.progressBar.progress = progressB
                }
            }
            DispatchQueue.main.async {
                self.delegate?.createPerson(person: personne)
            }
            
        }
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
