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
        
        if let screenshot = UIImage(named: "icons8-hanger-100.png") {
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
        
        bottomImages.append(UIImage(named: "Pants1.png")!)


        updateImage()
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
                    currentTopIndex = topImages.count - 1 // Set to the newly added image

                    print("TOP SET.")
                case .bottom:
                    bottomView.image = updatedImage
                    bottomImages.append(updatedImage)  // Add to topImages array
                    currentBottomIndex = bottomImages.count - 1 // Set to the newly added image

                    print("BOTTOM SET.")
                case .accessory:
                    accessoryView.image = updatedImage
                    accessoryImages.append(updatedImage)  // Add to topImages array
                    currentAccessoryIndex = accessoryImages.count - 1 // Set to the newly added image

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

        
        ImageManager.shared.allImages.append(image)
        NotificationCenter.default.post(name: Notification.Name("NewImageAdded"), object: nil)
        updateClothingItems()
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        updateClothingItems()

        guard currentTopIndex < topImages.count, currentBottomIndex < bottomImages.count, currentAccessoryIndex < accessoryImages.count else{
            
            print("Cannot save outfit. One or more indices are invalid.")
            return
        }
        
        OutfitManager.shared.saveOutfit(topIndex: currentTopIndex, bottomIndex: currentBottomIndex, accessoryIndex: currentAccessoryIndex)
        print("Outfit saved! Current indices: top =\(currentTopIndex), bottom =\(currentBottomIndex), accessory =\(currentAccessoryIndex)")
    }
    
    
    @IBAction func shuffleButton(_ sender: UIButton) {
        
        if !topImages.isEmpty, !bottomImages.isEmpty, !accessoryImages.isEmpty {
            // Random index for top, bottom, and accessory categories
            currentTopIndex = Int.random(in: 0..<topImages.count)
            currentBottomIndex = Int.random(in: 0..<bottomImages.count)
            currentAccessoryIndex = Int.random(in: 0..<accessoryImages.count)
            
            // Debugging print statements to verify the random indices
            print("Shuffling: Top index = \(currentTopIndex), Bottom index = \(currentBottomIndex), Accessory index = \(currentAccessoryIndex)")
            
            // Update the clothing items displayed in the UI
            updateClothingItems()
        } else {
            print("One or more clothing categories are empty. Cannot shuffle.")
        }

    }
    
}


