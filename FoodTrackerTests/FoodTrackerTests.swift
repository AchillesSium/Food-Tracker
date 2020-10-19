//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Mobioapp on 5/7/17.
//  Copyright © 2017 Mobioapp. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
   
    func testMealInitialitionSucceeds(){
    
        let zeroRating = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRating)
        
        let positiveRating = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRating)
    }
    
   func testMealInitializationFails() {
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
    
    }
}
