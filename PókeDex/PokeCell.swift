//
//  PokeCell.swift
//  PókeDex
//
//  Created by Mack Moynihan on 5/3/17.
//  Copyright © 2017 Mack Moynihan. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var pic: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func loadData(_ pokemon: Pokemon){
        self.pokemon = pokemon
        pic.image = UIImage(named: "\(self.pokemon.ID)")
        nameLbl.text = self.pokemon.name.capitalized
        
    }
}
