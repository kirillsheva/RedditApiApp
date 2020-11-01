//
//  UseCase.swift
//  Lab06
//
//  Created by Ker on 01.11.2020.
//  Copyright © 2020 Ker. All rights reserved.
//

import Foundation

class UseCase{

 static func getPostsInfo(subreddit: String,limit: Int?){
        Repository.getInfo(subreddit:subreddit,limit:limit, completion:{(success)->Void in
            if success{
                if let res = Repository.parse(data: PersistenceManager.shared.cache){
                    normalize(data: res)
            }
            }else {
                print("Error")
            }
        })
}
    
static func normalize(data:Response){
        var res = " "
        var time:String
  
        for (index,post) in data.data.children.enumerated(){
            let difference = Int(NSDate().timeIntervalSince1970) - post.data.created_utc
            
            switch difference{
            case let t where t < 3600:
                time = "\(Int(t/60))m"
            case let t where t < 86400:
                time = "\(Int(t/3600))h"
            case let t where t < 2678400:
                time = "\(Int(t/86400))d"
            case let t where t < 31536000:
                time = "\(Int(t/2678400))m"
            default:
                time = "\(Int(post.data.created_utc/31536000))y"
            }
            res += "\n Username : \(post.data.author)"
             res += "\n Time passed : \(time)"
            res += "\n Domain : \(post.data.domain)"
             res += "\n Title : \(post.data.title)"
             res += "\n Image url : \(post.data.url)"
            res += "\n Rating : \(post.data.ups - post.data.downs)"
             res += "\n No of comments : \(post.data.num_comments)\n\n"
        }
    print(res)
    }
}
