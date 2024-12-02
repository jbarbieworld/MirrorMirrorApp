//
//  ClothingData.swift
//  MirrorMirror
//
//IGNORE THIS IS FOR COLLECTION VIEW SWIPE
//  Created by Marilin Francisco on 11/11/24.
//

import Foundation
import UIKit

struct Outfit{
    let topIndex: Int
    let bottomIndex: Int
    let accessoryIndex: Int
}

class ImageManager {
    static let shared = ImageManager()
    
    private init() {} // Private init to ensure it's a singleton
    
    var backgroundRemovedImage: UIImage? // Store the background-removed image
    var backgroundRemovedImagePath: String? // Store the path of the background-removed image
    var selectedCategory: BuildOutfitVC.ClothingCategory? // Stores the selected category
    
    var topImages: [UIImage] = []
    var bottomImages: [UIImage] = []
    var accessoryImages: [UIImage] = []

    // Helper to add images without duplication
    func addTopImage(_ image: UIImage) {
        if !topImages.contains(image) {
            topImages.append(image)
        }
    }

    func addBottomImage(_ image: UIImage) {
        if !bottomImages.contains(image) {
            bottomImages.append(image)
        }
    }

    func addAccessoryImage(_ image: UIImage) {
        if !accessoryImages.contains(image) {
            accessoryImages.append(image)
        }
    }

}

class OutfitManager{
    static let shared = OutfitManager()
    private init() { }
    
    private var savedOutfits: [Outfit] = []

    func saveOutfit(topIndex: Int, bottomIndex: Int, accessoryIndex: Int) {
        let outfit = Outfit(topIndex: topIndex, bottomIndex: bottomIndex, accessoryIndex: accessoryIndex)
        savedOutfits.append(outfit)
    }

    func getOutfits() -> [Outfit] {
        return savedOutfits
    }
}

