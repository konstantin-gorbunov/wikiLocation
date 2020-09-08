//
//  AccountGroepViewModel.swift
//  uiAssignment
//
//  Created by Kostya on 26/07/2020.
//  Copyright © 2020 Kostiantyn Gorbunov. All rights reserved.
//

import Foundation

struct AccountViewModel {
    let account: Account?
    let borderSides: BorderLayer.Side
    let name: String?
    
    init(_ account: Account?, borderSides: BorderLayer.Side) {
        self.account = account
        self.borderSides = borderSides
        name = account?.groupName
    }
}

extension BorderLayer.Side {
    /// Return border sides for given index path
    /// This is related to account list view with given items per row
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
