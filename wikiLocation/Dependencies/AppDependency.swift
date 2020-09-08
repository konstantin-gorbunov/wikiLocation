//
//  AppDependency.swift
//  wikiLocation
//
//  Created by Kostya on 08/09/2020.
//  Copyright © 2020 Kostiantyn Gorbunov. All rights reserved.
//

protocol Dependency {
    var dataProvider: DataProvider { get }
}

class AppDependency: Dependency {

    let dataProvider: DataProvider = LocalLocationDataProvider()
}
