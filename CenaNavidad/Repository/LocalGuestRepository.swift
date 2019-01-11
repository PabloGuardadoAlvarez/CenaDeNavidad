//
//  LocalGuestRepository.swift
//  CenaNavidad
//
//  Created by PABLO GUARDADO ALVAREZ on 10/1/19.
//  Copyright © 2019 PABLO GUARDADO ALVAREZ. All rights reserved.
//

import Foundation

import RealmSwift
import UIKit

class LocalGuestsRepository: Repository {
    
    func getAll() -> [MGuest] {
        var tasks: [MGuest] = []
        do {
            let entities = try Realm().objects(EGuest.self).sorted(byKeyPath: "date", ascending: true) //Esto equivaldria a una Query
            for entity in entities {
                let model = entity.taskModel()
                tasks.append(model)
            }
        }
        catch let error as NSError {
            print("Error getAll Tasks: ", error.description)
        }
        return tasks
    }
    
    func get(identifier: String) -> MGuest? {
        do {
            let realm =  try Realm()
            if let entity = realm.objects(EGuest.self).filter("name == %@", identifier).first{ //Esto equivaldria a una Query
                let model = entity.taskModel()
                return model
            }
        }
        catch {
            return nil
        }
        return nil
    }
    
    func create(a: MGuest) -> Bool {
        do {
            let realm = try Realm()
            let entity = EGuest(guest: a)
            try realm.write {
                realm.add(entity, update: true)
            }
        }
        catch {
            return false
        }
        
        return true
    }
    
    func update(a: MGuest) -> Bool {
        return create(a: a)
    }
    
    func delete(a: MGuest) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                let entityToDelete = realm.objects(EGuest.self).filter("name == %@", a.name) //Esto equivaldria a una Query
                realm.delete(entityToDelete)
            }
            
        }
        catch {
            return false
        }
        return true
    }
}
