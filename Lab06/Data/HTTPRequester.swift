//
//  HTTPRequester.swift
//  Lab06
//
//  Created by Ker on 01.11.2020.
//  Copyright © 2020 Ker. All rights reserved.
//

import Foundation

class HTTPRequester{
    
 static func request(url: String, completionHandler : @escaping (Data?) -> Void){
        guard let link = URL(string: url) else {
            return }
        let task = URLSession.shared.dataTask(with: link) { (data, response, error) in
            if let data = data{
                completionHandler(data)
            }
        }
    task.resume()
    }
}
