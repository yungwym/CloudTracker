//
//  Meal.swift
//  Foodtracker
//
//  Created by Alex Wymer  on 2017-07-31.
//  Copyright © 2017 Sav Inc. All rights reserved.
//

import Foundation
import UIKit
import os.log

class Meal: NSObject {
    
    //MARK: Properties
    
  //  var id: Int
    var name: String
    var photo: UIImage?
    var rating: Int?
    var descripp: String
    var caloriess: String
    
    //MARK: Archiving Paths 
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")

    
    //MARK: Types
    
    struct PropertyKey {
    
 //   static let id = "id"
    static let name = "name"
    static let photo = "photo"
    static let rating = "rating"
    static let descrip = "descrip"
    static let calories = "calories"
    
    }
    
    //MARK: Initialization
    
    init?(name: String, descrip: String, calories: String) {
    
//    init?(id: Int, name: String, photo: UIImage?, rating: Int?, descrip: String, calories: String) {
    
        //Initalization should fail if there is no name or the rating is negative
        if name.isEmpty || descrip.isEmpty || calories.isEmpty {
            return nil
        }
        
        //Initialize stored properties
      //  self.id = id
        self.name = name
       // self.photo = photo
        //self.rating = rating
        self.descripp = descrip
        self.caloriess = calories
    }
    
    //MARK: NSCoding 
    
//    func encode(with aCoder: NSCoder) {
//        
//        aCoder.encode(id, forKey: PropertyKey.id)
//        aCoder.encode(name, forKey: PropertyKey.name)
//        aCoder.encode(photo, forKey: PropertyKey.photo)
//        aCoder.encode(rating, forKey: PropertyKey.rating)
//        aCoder.encode(descripp, forKey: PropertyKey.descrip)
//        aCoder.encode(caloriess, forKey: PropertyKey.calories)
//        
//    }
//    
//    required convenience init?(coder aDecoder: NSCoder) {
//        
//        // The name is required. If we cannot decode a name string, the initializer should fail.
//        guard let id = aDecoder.decodeObject(forKey: PropertyKey.id) as? Int, let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String, let descrip = aDecoder.decodeObject(forKey: PropertyKey.descrip) as? String, let calories = aDecoder.decodeObject(forKey: PropertyKey.calories) as? Int  else {
//            
//            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
//            return nil
//        }
//        // Because photo is an optional property of Meal, just use conditional cast.
//        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
//        
//        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
//        
//        // Must call designated initializer.
//        self.init(id: id, name: name, photo: photo, rating: rating, descrip: descrip, calories: calories)
//    }
}

