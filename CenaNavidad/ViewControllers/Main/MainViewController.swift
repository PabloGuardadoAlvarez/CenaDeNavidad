//
//  MainViewController.swift
//  CenaNavidad
//
//  Created by PABLO GUARDADO ALVAREZ on 9/1/19.
//  Copyright © 2019 PABLO GUARDADO ALVAREZ. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    

    @IBOutlet weak var tableDinners: UITableView!
    internal var dinners:[MDinner] = []
    internal var repository = LocalDinnerRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        dinners = repository.getAll()
        title = "Cenas para las navidades"
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        navigationItem.setRightBarButton(addBarButtonItem, animated: false)
    }
    
    @objc internal func addPressed() {
        let addVC = AddViewController(dinner: nil)
        addVC.delegate = self
        addVC.modalTransitionStyle = .coverVertical
        addVC.modalPresentationStyle = .overCurrentContext
        present(addVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func registerCell(){
        
        let identificador = "DinnerCell"
        
        let cellnib = UINib(nibName: "DinnerCell", bundle: nil)
        tableDinners.register(cellnib,forCellReuseIdentifier:identificador)
        
    }
    


}
extension MainViewController:  UITableViewDelegate,UITableViewDataSource{

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    return dinners.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: DinnerCell = tableDinners.dequeueReusableCell(withIdentifier: "DinnerCell", for: indexPath) as! DinnerCell
        let dinner = dinners[indexPath.row]
        
        cell.lblDinnerName.text = dinner.name
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dinner = dinners[indexPath.row]
        let choiceVC  = ChoiceViewController(guests:dinner.guest, dishes:dinner.dish)
        navigationController?.pushViewController(choiceVC, animated: true)
        print(dinner.guest.count)
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let dinner = dinners[indexPath.row]
            if repository.delete(a: dinner){
                dinners.remove(at: indexPath.row)
                tableDinners.beginUpdates()
                tableDinners.deleteRows(at: [indexPath], with: .automatic)
                tableDinners.endUpdates()
                
            }
        }
    }

}

extension MainViewController: AddViewControllerDelegate {
    func addViewController(_ vc: AddViewController, didEditDinner dinner: MDinner) {
        vc.dismiss(animated: true, completion: nil)
        if repository.create(a: dinner) {
            dinners = repository.getAll()
            tableDinners.reloadData()
        }
    }
}
