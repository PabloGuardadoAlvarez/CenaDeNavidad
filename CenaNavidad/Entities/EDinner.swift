//
//  EDinner.swift
//  CenaNavidad
//
//  Created by PABLO GUARDADO ALVAREZ on 9/1/19.
//  Copyright © 2019 PABLO GUARDADO ALVAREZ. All rights reserved.
//

import Foundation

import RealmSwift

class EDinner: Object {
    
    @objc dynamic var name = ""
    var guests:[MGuest] = []
    //var guests = List<MGuest>()
    //var guests: List<MGuest> = List<MGuest>()
    @objc dynamic var date = Date()
    
    override static func primaryKey() -> String { //Metodo para asignar una clave primaria
        return "name"
    }
    
    convenience init(dinner: MDinner) {
        self.init()
        self.name = dinner.name
    }
    
    func taskModel() -> MDinner {
        let model = MDinner()
        model.name = self.name
        for guests in self.guests{
            model.guest.append(guests)
        }
        return model
    }
    
}
