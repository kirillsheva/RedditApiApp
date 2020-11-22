//
//  Repository.swift
//  Lab06
//
//  Created by Ker on 01.11.2020.
//  Copyright © 2020 Ker. All rights reserved.
//

import Foundation

struct Response : Decodable{
 var data : DataStruct
    struct DataStruct : Decodable {
        var children : [ItemStruct]
        struct ItemStruct: Decodable {
            var data : ItemDataStruct
            struct ItemDataStruct:Decodable{
                var author:String
                var domain:String
                var created_utc:Int
                var title:String
                var url:String
                var ups:Int
                var downs:Int
                var num_comments:Int
              
            }
        }
    }
}
struct SavedResponse {
    var data:[Post]
    struct Post:Decodable{
        var author:String
        var domain:String
        var created_utc:Int
        var title:String
        var url:String
        var ups:Int
        var downs:Int
        var num_comments:Int
        var isSaved:Bool
    }
}
class Repository{
    static func parse(data:Data) -> Response?{
        do{
            let result = try JSONDecoder().decode(Response.self, from: data)
            return result
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
   static func getInfo(subreddit: String,limit: Int?, completion: @escaping (Bool) ->Void) {
        HTTPService.requestService(subreddit: subreddit, listing: "top", limit: limit, after: nil,completion: {(success)-> Void in
            if success{
                completion(true)
            }else{
                print("Error")
            }
            })
    }
}

