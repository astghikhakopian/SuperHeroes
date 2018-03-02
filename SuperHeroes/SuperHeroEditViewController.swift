//
//  SuperHeroEditViewController.swift
//  SuperHeroes
//
//  Created by astghik on 1/28/18.
//  Copyright © 2018 ACA. All rights reserved.
//

import UIKit

protocol SuperHeroViewControllerDelegate {
    func createHero(hero: SuperHero);
    func editHero();
}

class SuperHeroEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Properties
    
    @IBOutlet weak var nameLabel: UITextField!;
    @IBOutlet weak var descriptionLabel: UITextView!;
    @IBOutlet weak var imageField: UIImageView!;
    
    var superHero: SuperHero?;
    var delegate: SuperHeroViewControllerDelegate?;
    
    
    //MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        if let superHero = superHero {
            title = "Edit";
            nameLabel.text = superHero.name;
            descriptionLabel.text = superHero.description;
            imageField.image = superHero.image;
        } else {
            title = "Add New";
            nameLabel.text = nil;
            descriptionLabel.text = nil;
            imageField.image = UIImage(named: "default");
        }
    }
    
    
    //MARK: - Actions
    
    @IBAction func changeImage(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self;
        imagePicker.sourceType = .photoLibrary;
        present(imagePicker, animated: true, completion: nil);
    }
    
    @IBAction func submitChanges() {
        guard let name = nameLabel.text, let description = descriptionLabel.text , let image = imageField.image else {
            fatalError("Name filed, Description filed or/and Image field is/are empty.");
        }
        if let editedHero = superHero {
            editedHero.name = name;
            editedHero.description = description;
            editedHero.image = image;
            delegate?.editHero();
        } else {
            let newHero = SuperHero(name: name, image: image, description: description);
            delegate?.createHero(hero: newHero);
        }
        navigationController?.popViewController(animated: true);
    }
    
    
    //MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageField.image = pickedImage;
        }
        dismiss(animated: true, completion: nil);
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil);
    }
}
