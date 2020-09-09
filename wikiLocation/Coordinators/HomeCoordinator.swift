//
//  HomeCoordinator.swift
//  wikiLocation
//
//  Created by Kostya on 08/09/2020.
//  Copyright © 2020 Kostiantyn Gorbunov. All rights reserved.
//

import UIKit

/// Home (Location List) Coordinator
class HomeCoordinator<T: Dependency>: Coordinator<T> {

    let navigationViewController: UINavigationController
    private let title = NSLocalizedString("Locations", comment: "Locations")
    private var locations: [Location] = []
    private var locationListViewCtrlDelegate: LocationListViewModelUpdateDelegate?

    init(dependency: T, navigation: UINavigationController) {
        self.navigationViewController = navigation
        super.init(dependency: dependency)
    }
    
    override func start() {
        super.start()

        let loadingViewController = LoadingViewController(nibName: nil, bundle: nil)
        navigationViewController.viewControllers = [loadingViewController]
        loadingViewController.title = title

        dependency.dataProvider.fetchLocationList { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.processResults(result)
            }
        }
    }

    private func processResults(_ result: DataProvider.FetchLocationResult) {
        guard case .success(let locations) = result, locations.isEmpty == false else {
            let errorViewController = ErrorViewController(nibName: nil, bundle: nil)
            errorViewController.title = title
            navigationViewController.viewControllers = [errorViewController]
            return
        }
        self.locations = locations
        let locationsViewController = LocationsCollectionViewController(
            viewModel: LocationListViewModel(locations),
            layout: UICollectionViewFlowLayout()
        )
        locationsViewController.title = title
        locationsViewController.delegate = self
        locationListViewCtrlDelegate = locationsViewController
        navigationViewController.viewControllers = [locationsViewController]
    }
}

extension HomeCoordinator: LocationCollectionViewDelegate {

    func didSelectLocation(_ location: Location) {
        guard let url =  NSURL(string: "wikipedia://places?lat=\(location.lat)&lon=\(location.lon)") else {
           return
        }
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    func didAddLocation(_ location: Location) {
        locations.append(location)
        locationListViewCtrlDelegate?.didModelUpdated(LocationListViewModel(locations))
    }
}
