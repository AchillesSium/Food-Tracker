//
//  ratingControl.swift
//  FoodTracker
//
//  Created by Mobioapp on 5/14/17.
//  Copyright © 2017 Mobioapp. All rights reserved.
//

import UIKit

@IBDesignable class ratingControl: UIStackView {

    @IBInspectable var starSize: CGSize = CGSize(width: 30.0, height: 30.0)
    {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5
     {
        didSet {
            setupButtons()
        }
    }
    private var ratingButtons = [UIButton]()
    var rating = 0
    {
        
        didSet{
            updateButtonSelectionStates()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Mark Private method
        setupButtons()
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    private func setupButtons(){
        
        
        
        for indexForButton in ratingButtons{
            removeArrangedSubview(indexForButton)
            indexForButton.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar",in:bundle,compatibleWith:self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar",in:bundle,compatibleWith:self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar",in:bundle,compatibleWith:self.traitCollection)
        self.traitCollection
        
        
        
        for index in 0..<starCount{
        let button = UIButton()
       // button.backgroundColor = UIColor.red
        button.setImage(emptyStar, for: .normal)
        button.setImage(filledStar, for: .selected)
        button.setImage(highlightedStar, for: .highlighted)
        button.setImage(highlightedStar, for: [.highlighted, .selected])
        
        //add constraints
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
        button.accessibilityLabel = "set \(index + 1) star rating"
        button.addTarget(self, action: #selector(ratingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
        addArrangedSubview(button)
        ratingButtons.append(button)
        }
        
    }
    
    func ratingButtonTapped(button: UIButton){
    
   // print("Button Pressed")
        
        guard let index = ratingButtons.index(of: button) else{
            fatalError("The button,\(button), is not in the Rating Button array: \(ratingButtons)")
        }
        
        let selectedRating = index + 1
        if selectedRating == rating {
            rating = 0
        }
        else{
            rating = selectedRating
        }
        
        
    }
    
    private func updateButtonSelectionStates() {
        for(index,button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
            
            let hintString: String?
            if rating == index+1 {
                hintString = "Tap to reset the rating to zero"
            }
            else
            {
                hintString = nil
            }
            
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set"
           /*
            case 1:
                valueString = "1 rating set"
            case 2:
                valueString = "2 rating set"
            case 3:
                valueString = "3 rating set"
            case 4:
                valueString = "4 rating set"
            case 5:
                valueString = "5 rating set"
               */
            default:
                valueString = "\(rating) stars"
                
                
            }
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
            
        }
    }
    
    

}
