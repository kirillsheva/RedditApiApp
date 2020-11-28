//
//  UseCase.swift
//  Lab06
//
//  Created by Ker on 01.11.2020.
//  Copyright © 2020 Ker. All rights reserved.
//

import Foundation
let subreddit = "memes"
class UseCase{

    func request(){
        HTTPService.requestService(subreddit: subreddit, listing: "top", limit: 5, after: nil)
    }
  
    
    func getData() -> Array<Post>{
        Repository().getData()
    }
    
    func getSavedData() -> Array<Post>{
        PersistenceManager.shared.fetchSaved()
    }
}
