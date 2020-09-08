//
//  LocationListViewModel.swift
//  wikiLocation
//
//  Created by Kostya on 08/09/2020.
//  Copyright © 2020 Kostiantyn Gorbunov. All rights reserved.
//

struct LocationListViewModel {
    /// List of Locations
    let locations: [Location]
    
    init(_ locations: [Location]) {
        self.locations = locations
    }
}
