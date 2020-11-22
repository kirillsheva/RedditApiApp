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
            var npost = SavedResponse.Post(author: nil, domain: nil,created_utc: nil, title: nil, url: nil, ups: nil, downs: nil, num_comments: nil, isSaved:false)
            let mirror = Mirror(reflecting: post.data)
            for rawProp in mirror.children{
                switch rawProp.label {
                case "author":
                    npost.author = rawProp.value as? String
                case "domain":
                    npost.domain = rawProp.value as? String
                case "created_utc":
                    npost.created_utc = rawProp.value as? Int
                case "title":
                    npost.title = rawProp.value as? String
                case "url":
                    npost.url = rawProp.value as? String
                case "ups":
                    npost.ups = rawProp.value as? Int
                case "downs":
                    npost.downs = rawProp.value as? Int
                case "num_comments":
                    npost.num_comments = rawProp.value as? Int
                default:
                    print("Undefined")
                }
            }
            res.data.append(npost)
        }
        return res
    }
    
  
    struct SavedResponse {
        var data:[Post]
        struct Post:Decodable{
            var author:String?
            var domain:String?
            var created_utc:Int?
            var title:String?
            var url:String?
            var ups:Int?
            var downs:Int?
            var num_comments:Int?
            var isSaved:Bool
        }
    }

}
