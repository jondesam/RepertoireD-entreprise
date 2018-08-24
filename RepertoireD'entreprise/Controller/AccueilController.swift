//
//  AccueilControllerViewController.swift
//  RepertoireD'entreprise
//
//  Created by MyMac on 18-08-24.
//  Copyright © 2018 Apex. All rights reserved.
//

import UIKit
import CoreData

class AccueilController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var entreprises = [Entreprise]()
    
    var cellId = "PersonneCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchEntreprises()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return entreprises.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let employes = entreprises[section].employes?.allObjects as? [Personne]{
         return employes.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let employes = entreprises[indexPath.section].employes?.allObjects as? [Personne]{
            let emplyeDeLaCell = employes[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? PersonneCell {
                cell.miseEnPlace(personne: emplyeDeLaCell)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return entreprises[section].nom
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete :
            if let perssoneASupprimer = entreprises[indexPath.section].employes?.allObjects[indexPath.row] as? Personne
            {
            contexte.delete(perssoneASupprimer)
                do {
                    try contexte.save()
                } catch {
                    print(error.localizedDescription)
                }
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default: break
        }
    }
    
    
    func fetchEntreprises() {
        let requete: NSFetchRequest<Entreprise> = Entreprise.fetchRequest()
        let tri = NSSortDescriptor(key: "nom", ascending: true)
        requete.sortDescriptors = [tri]
        do {
            entreprises = try contexte.fetch(requete)
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }

}
