//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Mobioapp on 5/7/17.
//  Copyright © 2017 Mobioapp. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var meal: Meal?
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var textOutlet: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var ratingControl:
    
    ratingControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.backgroundColor = UIColor.darkGray
        textOutlet.delegate = self
        
        if let newMeal = meal {
            navigationItem.title = newMeal.name
            textOutlet.text = newMeal.name
            photoImageView.image = newMeal.photo
            ratingControl.rating = newMeal.rating
        }
        
        updateSaveButtonState()
    }
    
    //text field delegate
   
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textOutlet.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textOutlet.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
       
    }
    
    //image picker controller delegates
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected Dictionary containing an image, but was provided the following /(info)")
        }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func SelectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        //hide keyboard
        textOutlet.resignFirstResponder()
        //instance of Image Picker Controller
        let imagePickerController = UIImagePickerController()
        //Source Selected
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
  /*  @IBAction func btnAction(_ sender: Any) {
        if textOutlet.text == "" {
        LabelOutlet.text = "Default"
        }
        else {
            LabelOutlet.text = textOutlet.text}
    }*/

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = textOutlet.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        meal = Meal(name: name, photo: photo, rating: rating)
        
    }
    
    
    private func updateSaveButtonState(){
        let text = textOutlet.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    
    
    @IBAction func cancel(_ sender: Any) {
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
             dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else{
            fatalError("The MealViewController is not inside a navigation controller.")
        }
        
    }
    
}

