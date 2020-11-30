//
//  PersistenceManager.swift
//  Lab06
//
//  Created by Ker on 01.11.2020.
//  Copyright © 2020 Ker. All rights reserved.
//

import Foundation

class PersistenceManager {
    static var shared :  PersistenceManager = {
        let instance = PersistenceManager()
        return instance
    }()
    
    private init() {}
    
    var saved:Array<Post> = []
    var info:Array<Post> = []

  
    func add (post : Post){
        info.append(post)
     //   print(PersistenceManager.shared.fetch())
    }
    
    func remove(title:String){
        for element in (0..<saved.count){
            if saved[element].title == title{
                saved[element].isSaved = false
               saved.remove(at: element)
       
                print("remove")
            }
        }
     savePosts(resp: saved)
         NotificationCenter.default.post(Notification(name: notify))
        
    }
    
func save (title:String){
    for element in (0..<info.count){
        if info[element].title == title {
            info[element].isSaved = true
            saved.append(info[element])
     
          
            
          //  print(saved[element])

        }
        
    }
   // print(getDirectory() )
     savePosts(resp: saved)
    print(saved)
    NotificationCenter.default.post(Notification(name: notify))
}
    
    func getInfo()-> Array<Post>{
        return info
    }
    func getSaved()->Array<Post>{
        return saved
    }
    
    
    func getDirectory() -> URL{
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                return directory!
    }
    
    func savePosts(resp: Array<Post>){
             Repository().saveToJsonFile(arr:resp)
     
        }
    }
    





