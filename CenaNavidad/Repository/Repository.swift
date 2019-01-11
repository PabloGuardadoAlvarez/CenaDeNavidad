//
//  Repository.swift
//  CenaNavidad
//
//  Created by PABLO GUARDADO ALVAREZ on 10/1/19.
//  Copyright © 2019 PABLO GUARDADO ALVAREZ. All rights reserved.
//

import Foundation
protocol Repository {
    associatedtype T
    
    func getAll() -> [T]
    func get(identifier: String) -> T?
    func create(a: T) -> Bool
    func update(a: T) -> Bool
    func delete(a: T) -> Bool
    
}
