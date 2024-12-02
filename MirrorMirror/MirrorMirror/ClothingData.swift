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
    
    var allImages: [UIImage] = [] // For images with backgrounds
    var backgroundRemovedImages: [UIImage] = [] // For background-removed images
    var backgroundRemovedImagePaths: [String] = [] // Store file paths
    
    
    var imagePaths: [String] = [] // Stores file paths of original images
    
    
    var topImages: [UIImage] = []
    var bottomImages: [UIImage] = []
    var accessoryImages: [UIImage] = []
    
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

struct Outfit{
    let topIndex: Int
    let bottomIndex: Int
    let accessoryIndex: Int
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
