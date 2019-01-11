//
//  ChoiceViewController.swift
//  CenaNavidad
//
//  Created by PABLO GUARDADO ALVAREZ on 10/1/19.
//  Copyright © 2019 PABLO GUARDADO ALVAREZ. All rights reserved.
//

import UIKit

class ChoiceViewController: UIViewController {
    
    internal var guests:[MGuest] = []
    internal var dishes:[MDish] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print(guests.count)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    convenience init(guests:[MGuest], dishes:[MDish]) {
        self.init()
        self.guests = guests
        self.dishes = dishes
    }
    
    @IBAction func ShowGuests(_ sender: Any) {
        
        let guestsVC  = GuestsViewController(guest:guests)
        navigationController?.pushViewController(guestsVC, animated: true)
    }
    
}
