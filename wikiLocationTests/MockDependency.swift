//
//  MockDependency.swift
//  wikiLocationTests
//
//  Created by Kostya on 08/09/2020.
//  Copyright © 2020 Kostiantyn Gorbunov. All rights reserved.
//

@testable import wikiLocation

class MockDataProvider: DataProvider {

    var onFetch: ((DataProvider.FetchLocationCompletion) -> Void)?

    func fetchLocationList(_ completion: @escaping DataProvider.FetchLocationCompletion) {
        onFetch?(completion)
    }
}

class MockDependency: Dependency {
    
    let dataProvider: DataProvider = MockDataProvider()
}
