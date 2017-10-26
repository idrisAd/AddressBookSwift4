//
//  ContactsTableViewController.swift
//  AddressBookSwift4
//
//  Created by Idris Adrien on 25/10/2017.
//  Copyright © 2017 Idris Adrien. All rights reserved.
//

import UIKit
import CoreData

extension ContactsTableViewController: AddViewControllerDelegate{
    
    func createPerson(person: Person) {
        print("create person")
        navigationController?.popViewController(animated: true)
        print("create person success")
        reloadDataFromDataBase()
        
    }
}

class ContactsTableViewController: UITableViewController {
    
    var persons = [Person]()
    
    
    func reloadDataFromDataBase(){
        let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
        let sortFirstName = NSSortDescriptor(key: "firstName", ascending: true)
        let sortLastName = NSSortDescriptor(key: "lastName", ascending: true)
        fetchRequest.sortDescriptors = [sortFirstName,sortLastName]
        
        let context = self.appDelegate().persistentContainer.viewContext
        
        print(try? context.fetch(fetchRequest))
        // Add in persons : [Person]
        
        if let personCD = try? context.fetch(fetchRequest){
            
        persons = personCD
        self.tableView.reloadData()
        
        
        // Example for delete a person
        
        // let person = person [0]
        // context.delete(person)
        // try? context.save()
        
        // Edit a person
        // person.lastName = "bjr"
        // try? context.save()
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.reloadDataFromDataBase()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Alert for the first launch
        if UserDefaults.standard.isFirstLaunch(){
            let alertController = UIAlertController(title: "Bienvenue", message: "Dans cette application permettant la gestion de contact", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default){
                (action) in
                
                UserDefaults.standard.userSawWelcomeMessage()
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
            
        }
        
        // Import of names.plist
        let namesPlist = Bundle.main.path(forResource: "names.plist", ofType: nil)
        if let namePath = namesPlist{
            
            let url = URL(fileURLWithPath: namePath)
            let dataArray = NSArray(contentsOf: url)
            
            for dict in dataArray!{
                if let dictionnary = dict as? [String: String]{
                    
                    // With PErson class
                    //TODO/ FIX let person = Person(firstName: dictionnary["name"]!, lastName: dictionnary["lastName"]!)
                    
                    //let person = persons.append(dictionnary["name"]!)
                    print(dictionnary)
                }
            }
            print(dataArray)
        }
        
        
        self.title = "Mes contacts"
        
//            let context = self.appDelegate().persistentContainer.viewContext
//            //let person = Person(entity: Person.entity(), insertInto: context)
//            //person.firstName = "Michel"
//            //person.lastName = "Berger"
//            do{
//                try context.save()
//            } catch {
//                print(error.localizedDescription)
//            }

        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let addContact = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContactPress))
        self.navigationItem.rightBarButtonItem = addContact
        
    }

    
    @objc func addContactPress(){
        // create and push AddViewController
        //Set the delegate
        let controller = AddViewController(nibName: nil, bundle: nil)
        controller.delegate = self
       navigationController?.pushViewController(controller, animated: true)
        print("Affichage add view")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return persons.count
    }

    
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // Name of cell on tableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath)
        
        if let contactCell = cell as? ContactTableViewCell {
            contactCell.nameLabel.text = persons[indexPath.row].firstName! + " " +  persons[indexPath.row].lastName!
            
        }

        // Configure the cell...

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DetailsViewController(nibName: nil, bundle: nil)
        controller.person = persons[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
