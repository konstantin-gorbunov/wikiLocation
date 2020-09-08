//
//  DataProvider.swift
//  wikiLocation
//
//  Created by Kostya on 08/09/2020.
//  Copyright © 2020 Kostiantyn Gorbunov. All rights reserved.
//

import Foundation

enum DataProviderError: Error {
    case resourceNotFound
    case parsingFailure(inner: Error)
}

protocol DataProvider {
    typealias FetchLocationResult = Result<[Location], Error>
    typealias FetchLocationCompletion = (FetchLocationResult) -> Void

    func fetchLocationList(_ completion: @escaping FetchLocationCompletion)
}

struct LocalLocationDataProvider: DataProvider {

    private let queue = DispatchQueue(label: "LocalLocationDataProviderQueue")

    // Completion block will be called on main queue
    func fetchLocationList(_ completion: @escaping FetchLocationCompletion) {
        guard let path = Bundle.main.url(forResource: "locations", withExtension: "csv") else {
            DispatchQueue.main.async {
                completion(.failure(DataProviderError.resourceNotFound))
            }
            return
        }
        queue.async {
            do {
                let dataStr = try String(contentsOf: path, encoding: .utf8)
                let collection = try CSVDecoder().decode([Location].self, from: dataStr)
                DispatchQueue.main.async {
                    completion(.success(collection))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(DataProviderError.parsingFailure(inner: error)))
                }
            }
        }
    }
}
