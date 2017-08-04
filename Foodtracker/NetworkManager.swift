//
//  NetworkManager.swift
//  Foodtracker
//
//  Created by Alex Wymer  on 2017-08-01.
//  Copyright © 2017 Sav Inc. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager: NSObject {
    
    //MARK: Base
    //username = alexwymer
    //password = 12345
    
    
    //MARK:POST
    
    static func requestPost(path: String, with formData : [String], completion: @escaping ([String:Any]) -> Void) {
        // usl params
        
        var components = URLComponents(string: "https://cloud-tracker.herokuapp.com" + path)!
        components.queryItems = [URLQueryItem(name: "username" , value: formData[0]), URLQueryItem(name: "password" , value: formData[1])]
        let request = NSMutableURLRequest(url: components.url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print("\(components.url!)")
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200  else {
                print("an error occurred problem with statusCode")
                return
            }
            
            // check the error status
            
            guard error == nil else {
                print(#line, error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("no data returned")
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any] else {
                print("data returned is not json, or not valid")
                return
            }
            
            completion(json)
            
        }
        
        task.resume()
    }
    
    //MARK: GET

    static func requestGet(path: String, completion: @escaping ([[String:Any]]) -> Void) {
        // usl params
        
        let components = URLComponents(string: "https://cloud-tracker.herokuapp.com" + path)!
       // components.queryItems = [URLQueryItem(name: "username" , value: formData[0]), URLQueryItem(name: "password" , value: formData[1])]
        let request = NSMutableURLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(UserDefaults.standard.value(forKey: "userAuthToken") as! String, forHTTPHeaderField: "token")
        print("\(components.url!)")
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200  else {
                print("an error occurred problem with statusCode")
                return
            }
            
            // check the error status
            
            guard error == nil else {
                print(#line, error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("no data returned")
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]] else {
                print("data returned is not json, or not valid")
                return
            }
            
            completion(json)
        }
        // do something with the json object
        task.resume()
    }
    
    static func postNewMeal(path: String, with formData : [String], completion: @escaping ([String:Any]) -> Void) {
        // usl params
        
        var components = URLComponents(string: "https://cloud-tracker.herokuapp.com" + path)!
        components.queryItems = [URLQueryItem(name: "title" , value: formData[0]), URLQueryItem(name: "description" , value: formData[1]), URLQueryItem(name: "calories", value: formData[2])]
        let request = NSMutableURLRequest(url: components.url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(UserDefaults.standard.value(forKey: "userAuthToken") as! String, forHTTPHeaderField: "token")
        print("\(components.url!)")
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200  else {
                print("an error occurred problem with statusCode")
                return
            }
            
            // check the error status
            
            guard error == nil else {
                print(#line, error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("no data returned")
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any] else {
                print("data returned is not json, or not valid")
                return
            }
            
            completion(json)
            
        }
        
        task.resume()
    }

    
}








