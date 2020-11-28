//
//  PersistenceManager.swift
//  Lab06
//
//  Created by Ker on 01.11.2020.
//  Copyright © 2020 Ker. All rights reserved.
//

import Foundation

class PersistenceManager {
    static let shared = PersistenceManager ()
    
    private init() {}
    var saved:Array<Post> = []
    var info:Array<Post> = []

  
    func add (post : Post){
        info.append(post)
     //   print(PersistenceManager.shared.fetch())
    }
    
    func remove(title:String){
        for element in (0...saved.count - 1){
            if saved[element].title == title{
                saved[element].isSaved = false
               saved.remove(at: element)
                print("remove")
            }
        }
    }
    
func save (title:String){
    for element in (0...info.count - 1){
        if info[element].title == title {
            info[element].isSaved = !info[element].isSaved
            saved.append(info[element])
          //  print(saved[element])
            print("add")
        }
    }
    NotificationCenter.default.post(Notification(name: notify))
}
    
    func fetch()-> Array<Post>{
        return info
    }
    func fetchSaved()->Array<Post>{
        return saved
    }
    
    
}




