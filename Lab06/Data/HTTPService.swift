//
//  HTTPService.swift
//  Lab06
//
//  Created by Ker on 01.11.2020.
//  Copyright © 2020 Ker. All rights reserved.
//

import Foundation

class HTTPService{
    
    static func buildLink(subreddit: String,listing: String, limit: Int?, after: String?)->String{
        var link = "https://www.reddit.com/r/\(subreddit)/\(listing).json"
        if limit != nil || after != nil{
        link+="?"
            if limit != nil{
                link+="limit=\(limit!)"
            }
            if after != nil{
                link+="&after=\(after!)"
            }
        }
        return link
    }
    
    
  
    

    static func requestService(subreddit: String,listing: String, limit: Int?, after: String?){
                HTTPRequester.request(url: buildLink(subreddit: subreddit, listing: listing, limit: limit, after: after), completionHandler:{ data in
            if let data = data{
            if let info:Response = try? JSONDecoder().decode(Response.self, from: data){
                for element in info.data.children{
                    PersistenceManager.shared.add(post: Post(element.data))
                        
                }
                
                    NotificationCenter.default.post(Notification(name: notify))
                }
           
              else{
        
                print("Error")
            }
                
            }
})

    
}
}
