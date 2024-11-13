//
//  ClothingData.swift
//  MirrorMirror
//
//IGNORE THIS IS FOR COLLECTION VIEW SWIPE
//  Created by Marilin Francisco on 11/11/24.
//

import Foundation
import UIKit
/*
class ClothingData{
    
    static let shared = ClothingData()
    var clothingItems: [ClothingItem] = []
}

struct ClothingItem{
    var imagePath: String
    var category: CategoryType
    
    init(imagePath: String, category: CategoryType) {
        self.imagePath = imagePath
        self.category = category
    }
}

enum CategoryType{
    case none
    case top
    case bottom
    case accessory
}

var selectedOutfit: [CategoryType: ClothingItem?] = [
    .top: nil,
    .bottom: nil,
    .accessory: nil
]
*/


class ImageManager {
    static let shared = ImageManager()
    
    private init() {} // Private init to ensure it's a singleton
    
    var backgroundRemovedImage: UIImage? // Store the background-removed image
    var backgroundRemovedImagePath: String? // Store the path of the background-removed image
    var selectedCategory: BuildOutfitVC.ClothingCategory? // Stores the selected category

    
}

