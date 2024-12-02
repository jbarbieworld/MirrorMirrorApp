//
//  BuildOutfitVC.swift
//  MirrorMirror
//
//  Created by Marilin Francisco on 11/12/24.
//

import Foundation
import UIKit

class BuildOutfitVC: UIViewController{
  
    @IBOutlet weak var tl: UIButton!
    @IBOutlet weak var tr: UIButton!
    @IBOutlet weak var bl: UIButton!
    @IBOutlet weak var br: UIButton!
    @IBOutlet weak var al: UIButton!
    @IBOutlet weak var ar: UIButton!
    
    @IBOutlet weak var topView: UIImageView!
    @IBOutlet weak var bottomView: UIImageView!
    @IBOutlet weak var accessoryView: UIImageView!
    
   // var topImages: [UIImage] = []
    //var bottomImages: [UIImage] = []
    //var accessoryImages: [UIImage] = []
    
    var topImages: [UIImage] {
        get { return ImageManager.shared.topImages }
        set { ImageManager.shared.topImages = newValue }
    }
    
    var bottomImages: [UIImage] {
        get { return ImageManager.shared.bottomImages }
        set { ImageManager.shared.bottomImages = newValue }
    }
    
    var accessoryImages: [UIImage] {
        get { return ImageManager.shared.accessoryImages }
        set { ImageManager.shared.accessoryImages = newValue }
    }
    
    var currentTopIndex = 0
    var currentBottomIndex = 0
    var currentAccessoryIndex = 0

    enum ClothingCategory {
        case top, bottom, accessory
    }
    
    var selectedCategory: ClothingCategory?
    var imagePath: String? // or UIImage if you're passing the image directly
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        NotificationCenter.default.addObserver(self, selector: #selector(updateImage), name: Notification.Name("BackgroundImageUpdated"), object: nil)
        
        if let screenshot = UIImage(named: "noPicture.jpeg") {
            topImages.append(screenshot) // Add to topImages array
            currentTopIndex = 0 // Set the index to 0 since this is the first image
            topView.image = screenshot // Set the screenshot to the UIImageView for visual display
            
            bottomImages.append(screenshot) // Add to topImages array
            currentBottomIndex = 0 // Set the index to 0 since this is the first image
            bottomView.image = screenshot // Set the screenshot to the UIImageView for visual display

            
            accessoryImages.append(screenshot) // Add to topImages array
            currentAccessoryIndex = 0 // Set the index to 0 since this is the first image
            accessoryView.image = screenshot // Set the screenshot to the UIImageView for visual display

        }
        
        if let shirt2 = UIImage(named: "Shirt2.png") {
            topImages.append(shirt2)
        }


        updateClothingItems()
        print("Top images count: \(topImages.count)") // Debugging line to check the count of topImages
        
        self.view.backgroundColor = UIColor.background
        tabBarController?.tabBar.tintColor = .darkblue // Selected tab
        tabBarController?.tabBar.unselectedItemTintColor = .white
        self.view.backgroundColor = UIColor.background
    }

    
    @objc func updateImage() {
        if let updatedImage = ImageManager.shared.backgroundRemovedImage {
            //print("Updating image in BuildOutfitVC.")
            
            // Use selectedCategory to determine which view to update
            if let category = ImageManager.shared.selectedCategory {
                switch category {
                case .top:
                    topView.image = updatedImage
                    topImages.append(updatedImage)  // Add to topImages array

                    print("TOP SET.")
                case .bottom:
                    bottomView.image = updatedImage
                    bottomImages.append(updatedImage)  // Add to topImages array

                    print("BOTTOM SET.")
                case .accessory:
                    accessoryView.image = updatedImage
                    accessoryImages.append(updatedImage)  // Add to topImages array

                    print("ACCESSORY SET.")
                }
            } else {
                print("No selected category.")
            }
        } else {
            print("No background removed image found.")
        }
    }
    
    func postImageUpdatedNotification() {
        // Manually notify that the image has been updated
        NotificationCenter.default.post(name: Notification.Name("BackgroundImageUpdated"), object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    func updateClothingItems() {
        // Dynamically load images into the views if they exist
        print("Updating clothing items...")

        if !topImages.isEmpty {
            print("Setting image for top: \(currentTopIndex)")
            topView.image = topImages[currentTopIndex]
        }else {
            topView.image = UIImage(named: "noPicture.jpeg") // Placeholder image
        }

        if !bottomImages.isEmpty {
            bottomView.image = bottomImages[currentBottomIndex]
        }else {
            bottomView.image = UIImage(named: "noPicture.jpeg") // Placeholder image
        }

        if !accessoryImages.isEmpty {
            accessoryView.image = accessoryImages[currentAccessoryIndex]
        }
        else {
                accessoryView.image = UIImage(named: "noPicture.jpeg") // Placeholder image
            }

    }

    @IBAction func TL(_ sender: UIButton) {
        if topImages.count > 0 {
            currentTopIndex = (currentTopIndex - 1 + topImages.count) % topImages.count
            print("Top moved to index: \(currentTopIndex)")
            updateClothingItems() // Update the UI to show the new image

        }else {
            print("No top images available.")
        }
    }
    @IBAction func TR(_ sender: UIButton) {
        if topImages.count > 0 {
            currentTopIndex = (currentTopIndex + 1) % topImages.count
            print("Top moved to index: \(currentTopIndex)")
            updateClothingItems() // Update the UI to show the new image

        }else {
            print("No top images available.")
        }
    }
    
    @IBAction func BL(_ sender: UIButton) {
        if bottomImages.count > 0 {
            currentBottomIndex = (currentBottomIndex - 1 + bottomImages.count) % bottomImages.count
            print("Bottom moved to index: \(currentBottomIndex)")
            updateClothingItems() // Update the UI to show the new image

        }else {
            print("No bottom images available.")
        }
    }
    @IBAction func BR(_ sender: UIButton) {
        if bottomImages.count > 0 {
            currentBottomIndex = (currentBottomIndex + 1) % bottomImages.count
            print("Bottom moved to index: \(currentBottomIndex)")
            updateClothingItems() // Update the UI to show the new image

        }else {
            print("No bottom images available.")
        }
    }
    
    @IBAction func AL(_ sender: UIButton) {
        if accessoryImages.count > 0 {
            currentAccessoryIndex = (currentAccessoryIndex - 1 + accessoryImages.count) % accessoryImages.count
            print("Accessory moved to index: \(currentAccessoryIndex)")
            updateClothingItems() // Update the UI to show the new image

        }else {
            print("No accessory images available.")
        }
    }
    @IBAction func AR(_ sender: UIButton) {
        if accessoryImages.count > 0 {
            currentAccessoryIndex = (currentAccessoryIndex + 1) % accessoryImages.count
            print("Accessory moved to index: \(currentAccessoryIndex)")
            updateClothingItems() // Update the UI to show the new image

        }else {
            print("No accessory images available.")
        }
    }
    
    
    
    func addClothingItem(image: UIImage, category: ClothingCategory) {
        switch category {
        case .top:
            topImages.append(image)
        case .bottom:
            bottomImages.append(image)
        case .accessory:
            accessoryImages.append(image)
        }
        updateClothingItems() // Update the display after adding a new item
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        guard currentTopIndex < topImages.count, currentBottomIndex < bottomImages.count, currentAccessoryIndex < accessoryImages.count else{
            
            print("Cannot save outfit. One or more indices are invalid.")
            return
        }
        
        OutfitManager.shared.saveOutfit(topIndex: currentTopIndex, bottomIndex: currentBottomIndex, accessoryIndex: currentAccessoryIndex)
        print("Outfit saved! Current indices: top =\(currentTopIndex), bottom =\(currentBottomIndex), accessory =\(currentAccessoryIndex)")
    }
    
}


