//
//  Header.swift
//  CSVDecoder
//
//  Created by Red Davis on 25/02/2019.
//  Copyright © 2019 Red Davis. All rights reserved.
//

struct Header {
    let key: String
    let index: Int
    
    // MARK: Initialization
    
    init(key: String, index: Int) {
        self.key = key
        self.index = index
    }
}
