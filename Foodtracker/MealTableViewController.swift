//
//  MealTableViewController.swift
//  Foodtracker
//
//  Created by Alex Wymer  on 2017-07-31.
//  Copyright © 2017 Sav Inc. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    //MARK: Properties
    
    
     var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NetworkManager.requestGet(path: "/users/me/meals") { ( data: [[String : Any]]) in
            
            for dict in data {
                
                if let id = dict["id"] as? Int,
                    let name = dict["title"] as? String,
                    let descrip = dict["description"] as? String,
                    let calories = dict["calories"] as? Int {
                    
                    print("\(id) \n \(name) \n \(descrip) \n \(calories)")
                    
//                    let meal = Meal(id: id, name: name, photo: nil, rating: nil, descrip: descrip, calories: "\(calories)")
                }
            }
        }
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load any saved meals, otherwise load sample data.
//        if let savedMeals = loadMeals() {
//            meals += savedMeals
//        }else {
//            // Load the sample data.
//           // loadSampleMeals()
//        }
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Tableviewcells are reused and should be dequeued using the cell identifier
        let cellIdentifer = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as? MealTableViewCell else {
            
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        //Fetches the apporiate meal for the data source layout 
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating!
        
        // Configure the cell...
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        // Return false if you do not want the specified item to be editable.
        
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            
           // saveMeals()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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

    
    // MARK: - Navigation

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
         
            
        case "AddItem":
            os_log("Adding a new meal", log: OSLog.default, type: .debug)
            
        case "showDetail":
            
            guard let mealDetailViewController = segue.destination as? MealViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
    //MARK: Actions
    
//    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
    
        
        
        
//        NetworkManager.requestPost(path: "/users/me/meals", with: [], completion: ([String : Any]) -> Void)
        
        
        
        
//        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
//            
//            if let selectedIndexPath = tableView.indexPathForSelectedRow {
//                
//                //Update existing meal
//                meals[selectedIndexPath.row] = meal
//                tableView.reloadRows(at: [selectedIndexPath], with: .none)
//            } else {
//                
//                //Add a new meal
//                let newIndexPath = IndexPath(row: meals.count, section: 0)
//                
//                meals.append(meal)
//                tableView.insertRows(at: [newIndexPath], with: .automatic)
//            }
//            
//            //Save the meals 
//            //saveMeals()
//        }
  //  }
    
    //MARK: Private Methods 
//    private func loadSampleMeals() {
//        
//        let photo1 = UIImage(named: "meal1")
//        let photo2 = UIImage(named: "meal2")
//        let photo3 = UIImage(named: "meal3")
//        
//        
//        guard let meal1 = Meal(name: "Salad", photo: photo1, rating: 5, descrip: "Green", calories: "100") else {
//            
//            fatalError("Unable to instaniate meal 1")
//        }
//        
//        guard let meal2 = Meal(name: "Chicken", photo: photo2, rating: 3, descrip: "Use to be alive", calories: "250") else {
//            
//            fatalError("Unable to instaniate meal 2")
//        }
//        
//        guard let meal3 = Meal(name: "Nicer Salad", photo: photo3, rating: 4, descrip: "Very Green", calories: "100") else {
//            
//            fatalError("Unable to instaniate meal 3")
//        }
//        
//        meals += [meal1, meal2, meal3]
//    }
    
//    private func saveMeals() {
//        
//        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
//        
//        if isSuccessfulSave {
//            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
//        } else {
//            os_log("Failed to save meals...", log: OSLog.default, type: .error)
//        }
//    }
//    
//    private func loadMeals() -> [Meal]? {
//     
//        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
//        
//    }
}