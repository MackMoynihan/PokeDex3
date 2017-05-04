//
//  ViewController.swift
//  PókeDex
//
//  Created by Mack Moynihan on 5/2/17.
//  Copyright © 2017 Mack Moynihan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,
    AVAudioPlayerDelegate, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var musicBtn: UIButton!
    var player: AVAudioPlayer!
    
    var pokemons = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAudio()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        parsePokemonCSV()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetail" {
            if let destination = segue.destination as? PokemonVCViewController {
                if let poke = sender as? Pokemon {
                    destination.pokemon = poke
                }
            }
        }
    }
    
    

    func initAudio() {
        let pathAudio = Bundle.main.path(forResource: "music", ofType: ".mp3")
        let songURL = URL(fileURLWithPath: pathAudio!)
        do {
            player = try AVAudioPlayer(contentsOf: songURL)
            player.delegate = self
            player.prepareToPlay()
            player.numberOfLoops = -1
            player.play()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func playMusic() {
        if !player.isPlaying {
            player.play()
        }
    }

    func parsePokemonCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: ".csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            //print(rows)
            for row in rows {
                if let pokeName = row["identifier"] {
                    if let pokeID = row["id"] {
                        let poke = Pokemon(name: pokeName, pokedexID: Int(pokeID)!)
                        pokemons.append(poke)
                    } else {
                        //print("Couldn't find id")
                    }
                } else {
                    //print("Couldn't find identifier")
                }
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        } else {
            return pokemons.count
        }
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            let poke: Pokemon!
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
            } else {
                poke = pokemons[indexPath.row]
            }
            //print(poke)
            cell.loadData(poke)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // call segue
        var poke: Pokemon!
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemons[indexPath.row]
        }
        performSegue(withIdentifier: "PokemonDetail", sender: poke)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    

    @IBAction func musicPress(_ sender: UIButton) {
        if player.isPlaying {
            player.pause()
            sender.alpha = 0.2
            
        } else {
            player.play()
            sender.alpha = 1
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // filter results
        if  searchText == "" {
            inSearchMode = false
            collectionView.reloadData()
            searchBar.endEditing(true)
            print("pot")
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemons.filter({$0.name.range(of: lower) != nil})
            collectionView.reloadData()
        }
    }

}

