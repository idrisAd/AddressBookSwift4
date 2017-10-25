//
//  ContactsTableViewController.swift
//  AddressBookSwift4
//
//  Created by Idris Adrien on 25/10/2017.
//  Copyright © 2017 Idris Adrien. All rights reserved.
//

import UIKit

extension ContactsTableViewController: AddViewControllerDelegate{
    
    func createPerson(name: String) {
        print("create person")
        persons.append(name)
        navigationController?.popViewController(animated: true)
        self.tableView.reloadData()
        
    }
}

class ContactsTableViewController: UITableViewController {
    
    var persons = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Import of names.plist
        let namesPlist = Bundle.main.path(forResource: "names.plist", ofType: nil)
        if let namePath = namesPlist{
            
            let url = URL(fileURLWithPath: namePath)
            let dataArray = NSArray(contentsOf: url)
            
            
            
            for dict in dataArray!{
                if let dictionnary = dict as? [String: String]{
                    
                    // Avec la classe Person
                    //let person = Person(firstName: dictionnary["name"]!, lastName: dictionnary["lastName"]!)
                    
                    let person = persons.append(dictionnary["name"]!)
                    print(dictionnary)
                }
            }
            
            
            print(dataArray)

        }
        
        
        self.title = "Mes contacts"
        
        persons.append("Michel Berger")
        persons.append("Paris Dakar")
        persons.append("James Bond")
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let addContact = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContactPress))
        self.navigationItem.rightBarButtonItem = addContact
        
    }

    @objc func addContactPress(){
        // create and push AddViewController
        //Set the delagate
        let controller = AddViewController(nibName: nil, bundle: nil)
        controller.delegate = self
       navigationController?.pushViewController(controller, animated: true)
        //self.present(controller, animated: true, completion: nil)
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath)
        
        if let contactCell = cell as? ContactTableViewCell {
            contactCell.nameLabel.text = persons[indexPath.row]
            
        }

        // Configure the cell...

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DetailsViewController(nibName: nil, bundle: nil)
        controller.person = persons[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
        
        
        /* controller.onDeleteUser = { (personToDelete) in
         self.persons = self.persons.filter({ (persons
 
 */
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
