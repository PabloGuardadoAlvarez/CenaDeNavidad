//
//  GuestsViewController.swift
//  CenaNavidad
//
//  Created by PABLO GUARDADO ALVAREZ on 10/1/19.
//  Copyright © 2019 PABLO GUARDADO ALVAREZ. All rights reserved.
//

import UIKit

class GuestsViewController: UIViewController {

    @IBOutlet weak var tableGuests: UITableView!
    
    internal var guests:[MGuest] = []
    internal var repository = LocalGuestsRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Invitados"
        guests = repository.getAll()
        registerCell()
        
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        navigationItem.setRightBarButton(addBarButtonItem, animated: false)
        print(guests.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    convenience init(guest:[MGuest]) {
        self.init()
        //self.guests = guest
    }
    
    private func registerCell(){
        
        let identificador = "GuestsCell"
        
        let cellnib = UINib(nibName: "GuestsCell", bundle: nil)
        tableGuests.register(cellnib,forCellReuseIdentifier:identificador)
        
    }
    
    @objc internal func addPressed() {
        let addVC = AddGuestViewController(guest: nil)
        addVC.delegate = self
        addVC.modalTransitionStyle = .coverVertical
        addVC.modalPresentationStyle = .overCurrentContext
        present(addVC, animated: true, completion: nil)
    }
    

}
extension GuestsViewController:  UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: GuestsCell = tableGuests.dequeueReusableCell(withIdentifier: "GuestsCell", for: indexPath) as! GuestsCell
        let guest = guests[indexPath.row]
        
        cell.lblGuestsName.text = guest.name
        
        var notPaid = UIImage(named: "Cross")
        var paid = UIImage(named:"Check")
        
        if(guests[indexPath.row].hasPaid == false){
            cell.imgGuest.image = notPaid
        }else{
            cell.imgGuest.image = paid
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell: GuestsCell = tableGuests.dequeueReusableCell(withIdentifier: "GuestsCell", for: indexPath) as! GuestsCell
        let guest = guests[indexPath.row]
        guest.hasPaid = !guest.hasPaid
        if repository.update(a: guest) {
            tableGuests.reloadRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let guest = guests[indexPath.row]
            if repository.delete(a: guest){
                guests.remove(at: indexPath.row)
                tableGuests.beginUpdates()
                tableGuests.deleteRows(at: [indexPath], with: .automatic)
                tableGuests.endUpdates()
                
            }
        }
    }
    
    
    
}

extension GuestsViewController: AddGuestViewControllerDelegate {
    func addGuestViewController(_ vc: AddGuestViewController, didEditGuest guest: MGuest) {
        vc.dismiss(animated: true, completion: nil)
        if repository.create(a: guest) {
            guests = repository.getAll()
            tableGuests.reloadData()
        }
    }
}
