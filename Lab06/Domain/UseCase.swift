//
//  UseCase.swift
//  Lab06
//
//  Created by Ker on 01.11.2020.
//  Copyright © 2020 Ker. All rights reserved.
//

import Foundation

class UseCase{

    static func getPostsInfo(subreddit: String,limit: Int?,completion:@escaping (SavedResponse)->Void){
        Repository.getInfo(subreddit:subreddit,limit:limit, completion:{(success)->Void in
            if success{
                if let res = Repository.parse(data: PersistenceManager.shared.cache){
                  //  let result = normalizeResponse(data: res)
                 //   normalize(data: result)
                   completion(normalizeResponse(data: res))
            }
            }else {
                print("Error")
            }
        })
}
    
    static func normalizeResponse(data: Response) -> SavedResponse{
        var res = SavedResponse(data: [])
       
        for post in data.data.children{
              let mirror = Mirror(reflecting: post.data)
            var npost = SavedResponse.Post(author: "", domain: "",created_utc: 0, title: "", url: "", ups: 0, downs: 0, num_comments: 0,isSaved:false)
            for info in mirror.children{
                switch info.label {
                case "author":
                    npost.author = (info.value as? String)!
                case "domain":
                    npost.domain = (info.value as? String)!
                case "created_utc":
                    npost.created_utc = (info.value as? Int)!
                case "title":
                    npost.title = (info.value as? String)!
                case "url":
                    npost.url = (info.value as? String)!
                case "ups":
                    npost.ups = (info.value as? Int)!
                case "downs":
                    npost.downs = (info.value as? Int)!
                case "num_comments":
                    npost.num_comments = (info.value as? Int)!
                default:
                    print("Undefined")
                }
            }
            res.data.append(npost)
        }
        return res
    }

}
