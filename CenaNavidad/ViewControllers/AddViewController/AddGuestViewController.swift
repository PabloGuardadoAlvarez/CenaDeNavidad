//
//  AddGuestViewController.swift
//  CenaNavidad
//
//  Created by PABLO GUARDADO ALVAREZ on 10/1/19.
//  Copyright © 2019 PABLO GUARDADO ALVAREZ. All rights reserved.
//

import UIKit

protocol AddGuestViewControllerDelegate: class {
    func addGuestViewController(_ vc: AddGuestViewController, didEditGuest guest: MGuest)
}


class AddGuestViewController: UIViewController {
    
    
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var paidSwitch: UISwitch!
    
    internal var guest: MGuest!
    weak var delegate: AddGuestViewControllerDelegate!
    
    convenience init(guest: MGuest?) {
        self.init()
        if guest == nil {
            self.guest = MGuest()
            self.guest.name = UUID().uuidString
            
        }
        else {
            self.guest = guest
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.8){
            self.view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBack.layer.cornerRadius = 8.0
        viewBack.layer.masksToBounds = true
        
        saveButton.layer.cornerRadius = 8.0
        saveButton.layer.masksToBounds = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backGuest(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addGuest(_ sender: Any) {
        
        guest.name = textField.text!
        guest.hasPaid = paidSwitch.isOn
        print(paidSwitch.isOn)
        delegate.addGuestViewController(self, didEditGuest: guest)
        
    }
    
    
}
