//
//  PersistenceManager.swift
//  Lab06
//
//  Created by Ker on 01.11.2020.
//  Copyright © 2020 Ker. All rights reserved.
//

import Foundation

class PersistenceManager {
    static var shared: PersistenceManager = {
        let instance = PersistenceManager()
        return instance
    }()
    
   var cache:Data
   
    private init(){
        cache = Data()
    }
}

