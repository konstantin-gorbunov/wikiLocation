//
//  LocationViewModel.swift
//  wikiLocation
//
//  Created by Kostya on 08/09/2020.
//  Copyright © 2020 Kostiantyn Gorbunov. All rights reserved.
//

import Foundation

struct LocationViewModel {
    let location: Location?
    let borderSides: BorderLayer.Side
    let name: String
    
    init(_ location: Location?, borderSides: BorderLayer.Side) {
        self.location = location
        self.borderSides = borderSides
        if let location = location {
            name = "Lat: \(location.lat) Long: \(location.lon)"
        }
        else {
            name = ""
        }
    }
}

extension BorderLayer.Side {
    /// Return border sides for given index path
    static func border(at indexPath: IndexPath,
                       itemsInRow: Int = BaseCollectionViewController.Constants.itemsInRow) -> BorderLayer.Side {
        var result: BorderLayer.Side = [.bottom, .right]
        if indexPath.row < itemsInRow {
            result.insert(.top)
        }
        if indexPath.row % itemsInRow == 0 {
            result.insert([.left])
        }
        return result
    }
}
