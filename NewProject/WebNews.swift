//
//  WebNews.swift
//  NewProject
//
//  Created by Monkey on 27/9/2017.
//  Copyright © 2017 monkey. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class WebNews: Object, Mappable {
    
    dynamic var id = 0
    dynamic var name = ""
    dynamic var image = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

