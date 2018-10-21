//
//  Beer.swift
//  BeerApi
//
//  Created by André Brilho on 07/08/2018.
//  Copyright © 2018 André Brilho. All rights reserved.
//

import Foundation
import RealmSwift

public class Beer: Object, Codable {
    
   @objc dynamic var id = 0
   @objc dynamic var name = ""
   @objc dynamic var tagline = ""
   @objc dynamic var descricao = ""
   @objc dynamic var image_url = ""
   @objc dynamic var attenuation_level = 0.0
   @objc dynamic var abv = 0.0
    
    @objc dynamic var favorito = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case tagline
        case descricao = "description"
        case image_url
        case attenuation_level
        case abv
    }
    
    @objc override public class func primaryKey() -> String {
        return "id"
    }
    
}
