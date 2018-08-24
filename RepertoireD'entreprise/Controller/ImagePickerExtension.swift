//
//  ImagePickerExtension.swift
//  RepertoireD'entreprise
//
//  Created by MyMac on 18-08-22.
//  Copyright © 2018 Apex. All rights reserved.
//

import UIKit

extension AjoutController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func miseEnPlaceImagePicker() {
        imagePicker = UIImagePickerController()
        imagePicker?.allowsEditing = true
        imagePicker?.delegate = self
        imageDeProfil.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(prendrePhoto))
        imageDeProfil.addGestureRecognizer(tap)
    }

    @objc func prendrePhoto() {
        guard imagePicker != nil else {return}
        let alerte = UIAlertController(title: "Prendre photo", message: "Choisissez votre média", preferredStyle: .actionSheet)
        
        let appareil = UIAlertAction(title: "Appareil Photo", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker?.sourceType = .camera
                self.present(self.imagePicker!, animated: true, completion: nil)
            }
        }
        
        let librairie = UIAlertAction(title: "Librairie", style: .default) { (action) in
            self.imagePicker?.sourceType = .photoLibrary
            self.present(self.imagePicker!, animated: true, completion: nil)
        }
        
        let annuler = UIAlertAction(title: "annuler", style: .destructive, handler: nil)
        
        alerte.addAction(appareil)
        alerte.addAction(librairie)
        alerte.addAction(annuler)
        self.present(alerte, animated: true, completion: nil)
        
        }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.imagePicker?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var image : UIImage?
        
        
        if let editee = info[UIImagePickerControllerEditedImage] as? UIImage {
            image = editee
        } else if let originale = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image = originale
        }
        imageDeProfil.image = image
        imagePicker?.dismiss(animated: true, completion: nil)
        
        
    }
    
}
