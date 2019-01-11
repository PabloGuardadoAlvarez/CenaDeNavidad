//
//  EGuest.swift
//  CenaNavidad
//
//  Created by PABLO GUARDADO ALVAREZ on 9/1/19.
//  Copyright © 2019 PABLO GUARDADO ALVAREZ. All rights reserved.
//

import Foundation
import RealmSwift

class EGuest: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    @objc dynamic var HasPaid = false
    
    override static func primaryKey() -> String { //Metodo para asignar una clave primaria
        return "name"
    }
    
    convenience init(guest: MGuest) {
        self.init()
        self.name = guest.name
        self.HasPaid = guest.hasPaid
    }
    
    func taskModel() -> MGuest {
        let model = MGuest()
        model.name = self.name
        return model
    }
    
}
