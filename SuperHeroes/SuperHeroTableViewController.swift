//
//  SuperHeroTableViewController.swift
//  SuperHeroes
//
//  Created by astghik on 1/28/18.
//  Copyright © 2018 ACA. All rights reserved.
//

import UIKit

class SuperHeroTableViewController: UITableViewController, SuperHeroViewControllerDelegate {
    
    
    //MARK: - Properties
    
    private var superHeroes = [SuperHero]();
    
    
    //MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        //tableView.register(UINib.init(nibName: "SuperHeroTableViewCell", bundle: nil), forCellReuseIdentifier: "SuperHeroTableViewCell");
        
        loadSampleSuperHeroes();
    }
    
    
    //MARK: - Actions
    
    @IBAction func editingModeButton() {
        isEditing = !isEditing;
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return superHeroes.count;
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150;
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = superHeroes[sourceIndexPath.row];
        superHeroes.remove(at: sourceIndexPath.row);
        superHeroes.insert(item, at: destinationIndexPath.row);
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            superHeroes.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .fade);
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cellIdentifier = "SuperHeroTableViewCell";
        let cellIdentifier = "SuperHeroCell";

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SuperHeroOPTableViewCell else {
            fatalError("The dequeued cell is not an instance of SuperHeroTableViewCell.");
        }

        let superHero = superHeroes[indexPath.row];

        cell.nameField.text = superHero.name;
        cell.descriptionField.text = superHero.description;
        cell.imageField.image = superHero.image;
        
        return cell;
    }
    
    
    //MARK: - Segue    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editVC = segue.destination as? SuperHeroEditViewController {
            editVC.delegate = self;
            if segue.identifier == "edit" {
                let hero = superHeroes[tableView.indexPathForSelectedRow!.row];
                    editVC.superHero = hero;
            }
        }
    }
    
    
    //MARK: - SuperHeroViewControllerDelegate
    
    func createHero(hero: SuperHero) {
        superHeroes.append(hero);
        tableView.reloadData();
    }
    func editHero() {
        tableView.reloadData();
    }
    
    
    //MARK: - Private methods
    
    private func loadSampleSuperHeroes() {
        
        let supermanImage = UIImage(named: "superman") ?? UIImage(named: "default")!;
        let spidermanImage = UIImage(named: "spiderman") ?? UIImage(named: "default")!;
        let betmanImage = UIImage(named: "betman") ?? UIImage(named: "default")!;
        let hulkImage = UIImage(named: "hulk") ?? UIImage(named: "default")!;
        
        let superman = SuperHero(
            name: "Superman",
            image: supermanImage,
            description: "Long description here about superman."
        );
        let spiderman = SuperHero(
            name: "Spiderman",
            image: spidermanImage,
            description: "Long description here about spiderman.Long description here about spiderman.Long description here about spiderman.Long description here about spiderman.Long description here about spiderman.Long description here about spiderman.Long description here about spiderman.Long description here about spiderman.Long description here about spiderman."
        );
        let betman = SuperHero(
            name: "Betman",
            image: betmanImage,
            description: "Long description here about betman."
        );
        let hulk = SuperHero(
            name: "Hulk",
            image: hulkImage,
            description: "Long description here about hulk."
        );
        
        superHeroes = [superman, spiderman, betman, hulk];
    }
}
