//
//  PokemonVCViewController.swift
//  PókeDex
//
//  Created by Mack Moynihan on 5/3/17.
//  Copyright © 2017 Mack Moynihan. All rights reserved.
//

import UIKit

class PokemonVCViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon._name
    }

    @IBAction func backPress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
