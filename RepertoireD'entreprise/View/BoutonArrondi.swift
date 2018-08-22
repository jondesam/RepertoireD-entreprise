//
//  BoutonArrondi.swift
//  RepertoireD'entreprise
//
//  Created by MyMac on 18-08-21.
//  Copyright © 2018 Apex. All rights reserved.
//

import UIKit

class BoutonArrondi: UIButton {
    override init(frame: CGRect){
        super.init(frame: frame)
        miseEnPlace()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        miseEnPlace()
    }
    
    func miseEnPlace() {
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.darkGray.cgColor
        tintColor = UIColor.black
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
}
