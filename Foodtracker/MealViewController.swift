//
//  MealViewController.swift
//  Foodtracker
//
//  Created by Alex Wymer  on 2017-07-30.
//  Copyright © 2017 Sav Inc. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var caloriesTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //MARK: Properties 
    
    let name: String = "Taco"
    //let photo: UIImage
   // let rating: Int
    let descrip: String = "Very Good Taco"
    let calories: String = "200"
    
    //    let name =
    //    let photo = photoImageView.image
    //    let rating = ratingControl.rating
    //    let descrip = descriptionTextField.text ?? ""
    //    let calories = caloriesTextField.text ?? ""

    
    //This value is either passed by "MealTableViewController" in prepare(for:sender) or constructed as part of adding a MealTableViewController
    var meal: Meal?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        //Handle the text fields user input through delegate callbacks
        nameTextField.delegate = self
        
        //Set up view if editing an existing meal
        if let meal = meal {
            
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating!
            descriptionTextField.text = meal.descripp
            caloriesTextField.text = "\(meal.caloriess)"
        }
        
        // Enable the Save button only if the text field has a valid Meal name.
       // updateSaveButtonState()
        
    }
    
    //MARK: Actions 
    
    

    
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        
        
        //This method lets you configure the viewController before its presented
        
//         func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            super.prepare(for: segue, sender: sender)
//            
//            //Configure the destination viewController only when the save button is pressed
//            guard let button = sender as? UIBarButtonItem, button == saveButton else {
//                
//                os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
//                return
//            }
        
        
            //Set the meal to be passed to MealTableViewController after the unwind segue
//            meal = Meal(id: 0, name: name, photo: photo, rating: rating, descrip: descrip, calories: calories)
        
        meal = Meal(name: name, descrip: descrip, calories: calories)
        
            
            NetworkManager.postNewMeal(path: "/users/me/meals", with: [name, descrip, calories]) { ( data: [String : Any]) in
                
                guard let id = data["id"] as? Int,
                      let calories = data["calories"] as? Int,
                      let descrip = data["description"] as? String,
                      let title = data["title"] as? String,
                    let userId = data["user_id"] as? Int else {
                        
                        print("Some Problem")
                        return
                }
                
                print("\(id) \(calories) \(descrip) \(title) \(userId)")
            }
        //}
    }
    
    

    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        //Hides the keyboard
        nameTextField.resignFirstResponder()
        
        //UIImagePickerController is a view controller that lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        
        //Only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        
        //Make sure viewController is notified when the user picks an image 
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: Navigation 
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            
            dismiss(animated: true, completion: nil)
            
        } else if let owningNavigationController = navigationController {
            
            owningNavigationController.popViewController(animated: true)
            
        } else {
            
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        saveButton.isEnabled = false
    }
    
    //MARK: UIImagePickerControllerDelegate 
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        //Dismiss the picker if the users canceled
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //Info dictionary may contain multiple representations of the image. YOu want to use the original
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
    
        }
        
        //Set photoImageView to display the selected image
        photoImageView.image = selectedImage
        
        //Dismiss the picker 
        dismiss(animated: true, completion: nil)    
    }
    
    //MARK: Private Methods
    
    private func updateSaveButtonState() {
        
        //Disable the text button if the textfield is empty 
        let text = nameTextField.text ?? ""
        let text1 = descriptionTextField.text ?? ""
        let text2 = caloriesTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty || !text1.isEmpty || !text2.isEmpty
    }
}

