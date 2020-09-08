//
//  LocationViewCell.swift
//  wikiLocation
//
//  Created by Kostya on 26/07/2020.
//  Copyright © 2020 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

class LocationViewCell: UICollectionViewCell, NibInstantiatable {

    @IBOutlet private weak var borderedView: BorderedView? {
        didSet {
            borderedView?.borderColor = UIColor.darkGray.cgColor
        }
    }
    @IBOutlet private weak var locationNameLabel: UILabel?

    var viewModel: LocationViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            locationNameLabel?.text = viewModel.name
            borderedView?.borderSides = viewModel.borderSides
        }
    }
}
