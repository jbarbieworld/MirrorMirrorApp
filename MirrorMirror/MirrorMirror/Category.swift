//
//  Category.swift
//  MirrorMirror
//
//  Created by Marilin Francisco on 11/11/24.
//
/*
import Foundation
import UIKit

class Category: UIViewController{
    
    enum CategoryType {
        case top, bottom, accessory, none
    }

    var clothingImagePath: String?
    
    var tops: [ClothingItem] = []
    var bottoms: [ClothingItem] = []
    var accessories: [ClothingItem] = []
    
    var topItems: [UIImage] = []
    var bottomItems: [UIImage] = []
    var accessoryItems: [UIImage] = []

    var selectedCategory: CategoryType = .none
    var processedImage: UIImage?
    
    var imagePath:String?
    
    var topImagePath: String?
    var bottomImagePath: String?
    var accessoryImagePath: String?
    
    var currentTopIndex = 0
    var currentBottomIndex = 0
    var currentAccessoryIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       /* // Set the first image paths for the categories
        topImagePath = tops[currentTopIndex].imagePath
        bottomImagePath = bottoms[currentBottomIndex].imagePath
        accessoryImagePath = accessories[currentAccessoryIndex].imagePath
        
        // Load the images into the image views
        loadImage(for: .top)
        loadImage(for: .bottom)
        loadImage(for: .accessory)*/
        
        loadClothingItems()
        updateCategoryImages()
    }
    
    func updateCategoryImages() {
        topImage.image = topItems[currentTopIndex]
        bottomImage.image = bottomItems[currentBottomIndex]
        accessoryImage.image = accessoryItems[currentAccessoryIndex]
    }

    
    func loadClothingItems() {
        // Load sample clothing items into arrays (you could replace this with real data)
        topItems = [UIImage(named: "top1")!, UIImage(named: "top2")!, UIImage(named: "top3")!]
        bottomItems = [UIImage(named: "bottom1")!, UIImage(named: "bottom2")!, UIImage(named: "bottom3")!]
        accessoryItems = [UIImage(named: "accessory1")!, UIImage(named: "accessory2")!, UIImage(named: "accessory3")!]
    }
    
    
    
    
    
    
    /*
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var accessoryButton: UIButton!
    
    @IBAction func topButton(_ sender: UIButton) {
        selectedCategory = .top
        topImagePath = tops[currentTopIndex].imagePath
        loadImage(for: .top)
    }
    
    @IBAction func bottomButton(_ sender: UIButton) {
        selectedCategory = .bottom
        bottomImagePath = bottoms[currentBottomIndex].imagePath
        loadImage(for: .bottom)
        
    }
    
    @IBAction func accessoryButton(_ sender: UIButton) {
        selectedCategory = .accessory
        accessoryImagePath = accessories[currentAccessoryIndex].imagePath
        loadImage(for: .accessory)
        
    }
    
    private func loadImage(for category: CategoryType) {
        switch category {
        case .top:
            loadImage(for: topImagePath, into: topImage)
        case .bottom:
            loadImage(for: bottomImagePath, into: bottomImage)
        case .accessory:
            loadImage(for: accessoryImagePath, into: accessoryImage)
        default:
            break
        }
    }
    
    
    private func loadImage(for imagePath: String?, into imageView: UIImageView) {
        guard let imagePath = imagePath else {
            imageView.image = UIImage(named: "noPicture.jpeg")  // Placeholder if imagePath is nil
            return
        }
        
        if FileManager.default.fileExists(atPath: imagePath) {
            if let image = UIImage(contentsOfFile: imagePath) {
                imageView.image = image
            } else {
                imageView.image = UIImage(named: "noPicture.jpeg")  // Placeholder if loading fails
            }
        } else {
            imageView.image = UIImage(named: "noPicture.jpeg")  // Placeholder if file doesn't exist
        }
    }
    
    private func addItemToClothingData(){
        disableButtons()
        
        if let path = getImagePathForSelectedCategory() {
            let newItem = ClothingItem(imagePath: path, category: selectedCategory)
            ClothingData.shared.clothingItems.append(newItem)
            print("Clothing items after adding: \(ClothingData.shared.clothingItems)")
            
            showAlert(message: "Item has been uploaded. You can now go to build your outfit.")
        } else {
            showAlert(message: "No image uploaded")
        }
    }
    
    private func getImagePathForSelectedCategory() -> String? {
        switch selectedCategory {
        case .top:
            return tops[currentTopIndex].imagePath
        case .bottom:
            return bottoms[currentBottomIndex].imagePath
        case .accessory:
            return accessories[currentAccessoryIndex].imagePath
        default:
            return nil
        }
    }
    
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Upload Complete", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func disableButtons(){
        topButton.isEnabled = false
        bottomButton.isEnabled = false
        accessoryButton.isEnabled = false
    }
    */
    
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var bottomImage: UIImageView!
    @IBOutlet weak var accessoryImage: UIImageView!
    
    
}
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BuildOutfitVC", let buildOutfitVC = segue.destination as? BuildOutfitVC {
           
            print("Selected Category in prepare: \(self.selectedCategory)")
            print("Passing imagePath: \(self.imagePath ?? "nil")")

            buildOutfitVC.selectedCategory = self.selectedCategory
            switch self.selectedCategory {
            case .top:
                buildOutfitVC.topImagePath = self.topImagePath
            case .bottom:
                buildOutfitVC.bottomImagePath = self.bottomImagePath
            case .accessory:
                buildOutfitVC.accessoryImagePath = self.accessoryImagePath
            default:
                break
            }
        }
    }
    /* FOR COLLECTION VIEW SWIPING
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothingItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClothingCell", for: indexPath) as! ClothingCell
        let clothingItem = ClothingData.shared.clothingItems[indexPath.item]
        
        if let image = UIImage(contentsOfFile: clothingItem.imagePath) {
            switch clothingItem.category {
            case .top:
                cell.topImageView.image = image
            case .bottom:
                cell.bottomImageView.image = image
            case .accessory:
                cell.accessoryImageView.image = image
            default:
                break
            }
        }

        return cell
    }*/
}


protocol CategoryDelegate: AnyObject {
    func updateCategoryImage(category: CategoryType, imagePath: String)
}*/
*/
