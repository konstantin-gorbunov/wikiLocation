//
//  HomeCoordinatorTests.swift
//  wikiLocationTests
//
//  Created by Kostiantyn Gorbunov on 08/09/2020.
//  Copyright © 2019 Kostiantyn Gorbunov. All rights reserved.
//

import XCTest
@testable import wikiLocation

class HomeCoordinatorTests: XCTestCase {

    var dependency: MockDependency?
    var coordinator: HomeCoordinator<MockDependency>?

    override func setUp() {
        super.setUp()
        
        let navigation = UINavigationController(rootViewController: UIViewController())
        let localDependency = MockDependency()
        dependency = localDependency
        coordinator = HomeCoordinator(
            dependency: localDependency,
            navigation: navigation
        )
    }

    override func tearDown() {
        coordinator = nil
        dependency = nil
        super.tearDown()
    }

    func testInit() {
        XCTAssertNotNil(dependency)
        XCTAssertNotNil(coordinator)
    }

    func testLoadingScreen() {
        let expectation = self.expectation(description: "Data Fetched")
        let location = Location(lat: "52.0716335", lon: "4.2398289")
        if let mock = (dependency?.dataProvider as? MockDataProvider) {
            mock.onFetch = { completion in
                completion(.success([location]))
                DispatchQueue.main.async {
                    expectation.fulfill()
                }
            }
        }
        coordinator?.start()
        let firstVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(firstVisible is LoadingViewController)
        wait(for: [expectation], timeout: 2)
        let secondVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(secondVisible is LocationsCollectionViewController)
    }

    func testErrorScreen() {
        let expectation = self.expectation(description: "Data Fetched")
        if let mock = (dependency?.dataProvider as? MockDataProvider) {
            mock.onFetch = { completion in
                completion(.success([]))
                DispatchQueue.main.async {
                    expectation.fulfill()
                }
            }
        }
        coordinator?.start()
        let firstVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(firstVisible is LoadingViewController)
        wait(for: [expectation], timeout: 2)
        let secondVisible = coordinator?.navigationViewController.visibleViewController
        XCTAssertTrue(secondVisible is ErrorViewController)
    }
}
