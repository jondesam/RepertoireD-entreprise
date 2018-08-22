//
//  AjoutController.swift
//  RepertoireD'entreprise
//
//  Created by MyMac on 18-08-20.
//  Copyright © 2018 Apex. All rights reserved.
//

import UIKit
import CoreData

class AjoutController: UIViewController {
    
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var imageDeProfil: ImageArrondie!
    
    @IBOutlet weak var ajouterEntrepise: UIButton!
    
    @IBOutlet weak var prenomTextField: UITextField!
    @IBOutlet weak var nomTextField: UITextField!
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
   
    
    @IBOutlet weak var ajouterPersonneBouton: BoutonArrondi!
    
    @IBOutlet weak var largeurContrainte: NSLayoutConstraint!
    @IBOutlet weak var contrainteDuBas: NSLayoutConstraint!
    
    var entreprises = [Entreprise]()
    var imagePicker: UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        miseEnPlaceImagePicker()
        miseEnPlacePicker()
        fectchEntreprises()
      
    }

    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        view.backgroundColor = .gray
        largeurContrainte.constant = view.frame.width
        scroll.contentSize = CGSize(width: largeurContrainte.constant, height: scroll.frame.height)
    }
    
    func fectchEntreprises() {
        let requete: NSFetchRequest<Entreprise> = Entreprise.fetchRequest()
        let tri = NSSortDescriptor(key: "nom", ascending: true)
        requete.sortDescriptors = [tri]
        do {
            entreprises = try contexte.fetch(requete)
            pickerView.reloadAllComponents()
            } catch {
                print(error.localizedDescription)
            }
        }
    
    
    
    
    @IBAction func ajouterPersonneAction(_ sender: Any) {
    }

    @IBAction func ajouterEntrepriseAction(_ sender: Any) {
        let alerte = UIAlertController(title: "Votre entreprise n'est pas dans la liste?", message: "ajouter", preferredStyle: .alert)
        let ajout = UIAlertAction(title: "OK", style: .default) { (action) in
            let textField = alerte.textFields![0] as UITextField
            if let texte = textField.text, texte != "" {
                let nouvelleEntreprise = Entreprise(context: contexte)
                nouvelleEntreprise.nom = texte
                appDelegate.saveContext()
                self.fectchEntreprises()
            }
            
        }
        
        alerte.addTextField { (tf) in
            tf.placeholder = "nom de l'etreprise"
        }
        let annuler = UIAlertAction(title: "Annuler", style: .default, handler: nil)
        alerte.addAction(ajout)
        alerte.addAction(annuler)
        self.present(alerte, animated: true, completion: nil)
        
        
        
    }
    
   
    
}
