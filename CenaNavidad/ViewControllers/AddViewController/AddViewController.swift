//
//  AddViewController.swift
//  CenaNavidad
//
//  Created by PABLO GUARDADO ALVAREZ on 10/1/19.
//  Copyright © 2019 PABLO GUARDADO ALVAREZ. All rights reserved.
//


import UIKit

protocol AddViewControllerDelegate: class {
    func addViewController(_ vc: AddViewController, didEditDinner dinner: MDinner)
}


class AddViewController: UIViewController {
    
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    internal var dinner: MDinner!
    weak var delegate: AddViewControllerDelegate!
    
    convenience init(dinner: MDinner?) {
        self.init()
        if dinner == nil {
            self.dinner = MDinner()
            self.dinner.name = UUID().uuidString
        }
        else {
            self.dinner = dinner
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
    
    @IBAction func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveButtonPressed() {
        dinner.name = textField.text
        delegate.addViewController(self, didEditDinner: dinner)
        
    }
    
    
}
