//
//  BuildOutfit.swift
//  MirrorMirror
//
//IGNORE THIS IS FOR COLLECTION VIEW SWIPE

//  Created by Marilin Francisco on 11/11/24.
//
/*
import Foundation
import UIKit

class BuildOutfit: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var topCV: UICollectionView!
    @IBOutlet weak var bottomCV: UICollectionView!
    @IBOutlet weak var accessoryCV: UICollectionView!
    
    var tops: [ClothingItem] = []
    var bottoms: [ClothingItem] = []
    var accessories: [ClothingItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadClothingData()
        
        topCV.dataSource = self
        topCV.delegate = self
        bottomCV.dataSource = self
        bottomCV.delegate = self
        accessoryCV.dataSource = self
        accessoryCV.delegate = self

        // Filter clothing items by category
        
        topCV.register(ClothingCell.self, forCellWithReuseIdentifier: "ClothingCell")
        bottomCV.register(ClothingCell.self, forCellWithReuseIdentifier: "ClothingCell")
        accessoryCV.register(ClothingCell.self, forCellWithReuseIdentifier: "ClothingCell")

        topCV.reloadData()
        bottomCV.reloadData()
        accessoryCV.reloadData()

        
        // Set up collection views
        setupCollectionView(topCV)
        setupCollectionView(bottomCV)
        setupCollectionView(accessoryCV)
        setupCollectionViewLayout(for: topCV)
        setupCollectionViewLayout(for: bottomCV)
        setupCollectionViewLayout(for: accessoryCV)

        print("Tops count: \(tops.count), Bottoms count: \(bottoms.count), Accessories count: \(accessories.count)")

    }

    private func setupCollectionView(_ collectionView: UICollectionView) {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
    }

    private func setupCollectionViewLayout(for collectionView: UICollectionView) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        collectionView.collectionViewLayout = layout
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case topCV:
            return tops.count
        case bottomCV:
            return bottoms.count
        case accessoryCV:
            return accessories.count
        default:
            return 0
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("In collection view cellForItemAt")

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClothingCell", for: indexPath) as! ClothingCell

        // Clear image views to avoid incorrect images being displayed
        cell.topImageView.image = nil
        cell.bottomImageView.image = nil
        cell.accessoryImageView.image = nil

        // Determine which category's items to show in each collection
        let clothingItem: ClothingItem
        
        if collectionView == topCV {
            clothingItem = tops[indexPath.item]
            print("Image path for top item: \(clothingItem.imagePath)")
            loadImage(for: clothingItem, into: cell.topImageView)
        } else if collectionView == bottomCV {
            clothingItem = bottoms[indexPath.item]
            print("Image path for bottom item: \(clothingItem.imagePath)")
            loadImage(for: clothingItem, into: cell.bottomImageView)
        } else {
            clothingItem = accessories[indexPath.item]
            print("Image path for accessory item: \(clothingItem.imagePath)")
            loadImage(for: clothingItem, into: cell.accessoryImageView)
        }

        return cell

    }
    
    private func loadImage(for clothingItem: ClothingItem, into imageView: UIImageView) {
        imageView.image = nil // Clear the image first

        print("Loading image from path: \(clothingItem.imagePath)") // Debugging print

        if FileManager.default.fileExists(atPath: clothingItem.imagePath) {
            print("Image exists at path: \(clothingItem.imagePath)")
            if let image = UIImage(contentsOfFile: clothingItem.imagePath) {
                imageView.image = image
            } else {
                print("Failed to load image from path: \(clothingItem.imagePath)")
                imageView.image = UIImage(named: "noPicture.jpeg") // Show a placeholder if image loading fails
            }
        } else {
            print("No file found at path: \(clothingItem.imagePath)")
            imageView.image = UIImage(named: "noPicture.jpeg") // Show a placeholder if no file is found
        }
    }
    
    func loadClothingData() {
        // Example: Adding a top item manually to the clothingItems array

        // Debugging: Print out clothing items
        for item in ClothingData.shared.clothingItems {
            print("Clothing Item: \(item.imagePath), Category: \(item.category)")
        }

        // Filter clothing items by category
        tops = ClothingData.shared.clothingItems.filter { $0.category == .top }
        bottoms = ClothingData.shared.clothingItems.filter { $0.category == .bottom }
        accessories = ClothingData.shared.clothingItems.filter { $0.category == .accessory }

        // Debugging prints to confirm the counts
        print("Tops count: \(tops.count), Bottoms count: \(bottoms.count), Accessories count: \(accessories.count)")
    }

    
    
}
*/
