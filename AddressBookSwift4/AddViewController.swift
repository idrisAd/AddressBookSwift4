//
//  AddViewController.swift
//  AddressBookSwift4
//
//  Created by Idris Adrien on 25/10/2017.
//  Copyright © 2017 Idris Adrien. All rights reserved.
//

import UIKit


protocol AddViewControllerDelegate: AnyObject {
    func createPerson(person: Person)
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Add a person
    @IBAction func addButtonPress(_ sender: Any) {
        print("ajout")
        guard let nameField = self.nameText.text , let prenomField = self.prenomText.text else{
            return
        }
        let context = self.appDelegate().persistentContainer.viewContext
        let personne = Person(entity: Person.entity(), insertInto: context)
        personne.firstName = prenomField
        personne.lastName = nameField
        try? context.save()
        
        var progressB = self.progressBar.progress
        
        // Send a person with a picture on the server
        
        let picture = "https://i.imgur.com/jNNT4LE.jpg"
        let parameters = ["surname": nameField, "lastname": prenomField, "pictureUrl": picture]
        
        let url = URL(string : "http://10.1.0.242:3000/persons")!
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else{
                return
            }
            
            guard let data = data else {
                return
            }
            // Create json object from data
            do{
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]{
                    print(json)
                    // handle json  (recupere la data depuis le serveur)
                    let person = Person(entity: Person.entity(), insertInto: self.appDelegate().persistentContainer.viewContext)
                    person.lastName = json["surname"] as? String
                    person.firstName = json["lastname"] as? String
                    person.avatarUrl = json["pictureUrl"] as? String
                    person.id = Int32(json["id"] as? Int ?? 0)
                    try? context.save()
                }
            } catch let error{
                print(error.localizedDescription)
            }
        })
        task.resume()
        
        
        // Progress bar for loading the addition
        
//        DispatchQueue.global(qos: .background).async {
//            let counter: Float = 0.0
//            while progressB < 1{
//                Thread.sleep(forTimeInterval: 0.05)
//                progressB += 0.1
//
//                DispatchQueue.main.async {
//                    self.progressLabel.text = "\(counter)"
//                }
//            }
//        }
        
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
