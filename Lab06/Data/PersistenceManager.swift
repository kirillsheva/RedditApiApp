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
    @Published var comments:Array<PostComment> = []
    func addComment(_ post: PostComment){
        comments.append(post)
    }
    func clear(){
        comments.removeAll()
    }
    func add (post : Post){
        info.append(post)
    }
    
    func remove(id:String){
        for element in (0..<saved.count){
            if saved[element].id == id{
                saved[element].isSaved = false
               saved.remove(at: element)
       
                print("remove")
            }
        }
     savePosts(resp: saved)
         NotificationCenter.default.post(Notification(name: notify))
        
    }
    
func save (id:String){
    for element in (0..<info.count){
        if info[element].id == id {
            info[element].isSaved = true
            saved.append(info[element])
        } 
    }
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
    func getComments()->Array<PostComment>{
        return comments
    }
    
    func getDirectory() -> URL{
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                return directory!
    }
    
    func savePosts(resp: Array<Post>){
             Repository().saveToJsonFile(arr:resp)
     
        }
    }
    





