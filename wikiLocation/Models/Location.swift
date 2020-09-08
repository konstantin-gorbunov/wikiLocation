//
//  Location.swift
//  wikiLocation
//
//  Created by Kostya on 08/09/2020.
//  Copyright © 2020 Kostiantyn Gorbunov. All rights reserved.
//

import Foundation

struct Location: Decodable {
    
    let lat: String
    let lon: String
        
    enum CodingKeys: String, CodingKey {
        case lat = "\"lat\""
        case lon = "\"lon\""
    }
}
