//
//  PersonneCell.swift
//  RepertoireD'entreprise
//
//  Created by MyMac on 18-08-24.
//  Copyright © 2018 Apex. All rights reserved.
//

import UIKit

class PersonneCell: UITableViewCell {

    @IBOutlet weak var photoDeProfil: ImageArrondie!
    
    @IBOutlet weak var nomEtPrenom: UILabel!
    
    @IBOutlet weak var numeroDeTel: UILabel!
    @IBOutlet weak var adresseMail: UILabel!
    
    var personne: Personne!
    
    func miseEnPlace(personne: Personne){
        
        self.personne = personne
        photoDeProfil.image = self.personne.photo as? UIImage
        
        var nomComplet = ""
        
        if let prenom = self.personne.prenom {
            nomComplet += "Prenom: " + prenom + " "
        }
       
        if let nom = self.personne.nom {
            nomComplet += "Nom: " + nom
        }
        
        nomEtPrenom.text = nomComplet
       
        let num = String(self.personne.numero)
        numeroDeTel.text = num
        
        adresseMail.text = self.personne.mail ?? ""
        
    }
}
