//
//  UseCase.swift
//  Lab06
//
//  Created by Ker on 01.11.2020.
//  Copyright © 2020 Ker. All rights reserved.
//

import Foundation
let subreddit = "memes"
let limit = 50
class UseCase{

    func request() {
        HTTPService.requestService(subreddit: subreddit, listing: "top", limit: limit, after: nil)
     
    }
    
   
    
  
    func getComments() ->Array<PostComment>{
        PersistenceManager.shared.getComments()
    }
    func getData() -> Array<Post>{
        PersistenceManager.shared.getInfo()
    }
    
    func getSavedData() -> Array<Post>{
        PersistenceManager.shared.getSaved()
    }
}
