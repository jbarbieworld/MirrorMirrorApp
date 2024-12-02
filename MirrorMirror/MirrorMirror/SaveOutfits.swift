//
//  SaveOutfits.swift
//  MirrorMirror
//
//  Created by Marilin Francisco on 12/1/24.
//

import Foundation
import UIKit

class SaveOutfits: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var savedOutfits: [Outfit] = []
    var topImages: [UIImage] {
        return ImageManager.shared.topImages
    }
    
    var bottomImages: [UIImage] {
        return ImageManager.shared.bottomImages
    }
    
    var accessoryImages: [UIImage] {
        return ImageManager.shared.accessoryImages
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16 // Adjust this for horizontal spacing
        layout.minimumLineSpacing = 16     // Adjust this for vertical spacing
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)

        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        savedOutfits = OutfitManager.shared.getOutfits() // Assuming this is how you get the outfits
        collectionView.reloadData()
        
        // Set background color for the view
        self.view.backgroundColor = UIColor.background
        
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        savedOutfits = OutfitManager.shared.getOutfits()
        collectionView.reloadData()
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedOutfits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SaveCell", for: indexPath) as! SaveOutfitsCell

        let outfit = savedOutfits[indexPath.row]
        
        // Load images from ImageManager
        let topImage = ImageManager.shared.topImages[safe: outfit.topIndex] ?? UIImage(named: "noPicture.jpeg")
        let bottomImage = ImageManager.shared.bottomImages[safe: outfit.bottomIndex] ?? UIImage(named: "noPicture.jpeg")
        let accessoryImage = ImageManager.shared.accessoryImages[safe: outfit.accessoryIndex] ?? UIImage(named: "noPicture.jpeg")
        
        /* Debugging images and their sizes
        print("Cell \(indexPath.row): topImage = \(String(describing: topImage)), bottomImage = \(String(describing: bottomImage)), accessoryImage = \(String(describing: accessoryImage))")
        print("Top Image Size: \(topImage?.size ?? CGSize.zero)")
        print("Bottom Image Size: \(bottomImage?.size ?? CGSize.zero)")
        print("Accessory Image Size: \(accessoryImage?.size ?? CGSize.zero)")
*/
        
        // Create the composite image
        let compositeImage = createOutfitPreview(top: topImage, bottom: bottomImage, accessory: accessoryImage)
        
        // Set the image and ensure it's scaled properly
        cell.outfitImageView.contentMode = .scaleAspectFit
        cell.outfitImageView.image = compositeImage

        return cell
    }
    
    // UICollectionViewDelegate method to handle cell selection
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           // Get the selected outfit
           let selectedOutfit = savedOutfits[indexPath.row]
           
           // Create and push the detail view controller
           if let detailVC = storyboard?.instantiateViewController(withIdentifier: "OutfitDetailViewController") as? OutfitDetailViewController {
               // Pass the selected outfit's image to the detail view controller
               let topImage = ImageManager.shared.topImages[safe: selectedOutfit.topIndex] ?? UIImage(named: "noPicture.jpeg")
               let bottomImage = ImageManager.shared.bottomImages[safe: selectedOutfit.bottomIndex] ?? UIImage(named: "noPicture.jpeg")
               let accessoryImage = ImageManager.shared.accessoryImages[safe: selectedOutfit.accessoryIndex] ?? UIImage(named: "noPicture.jpeg")
               
               let compositeImage = createOutfitPreview(top: topImage, bottom: bottomImage, accessory: accessoryImage)
               
               detailVC.outfitImage = compositeImage // Pass the composite image to the detail view
               
               // Push the detail view controller
               navigationController?.pushViewController(detailVC, animated: true)
           }
       }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20  // Padding around the cells
        let itemsPerRow: CGFloat = 2 // 3 items per row

        // Calculate the total padding
        let totalPadding = padding * (itemsPerRow + 1)
        
        // Calculate the width of each item (taking padding into account)
        let itemWidth = (collectionView.frame.width - totalPadding) / itemsPerRow
        
        let compositeImage = createOutfitPreview(
               top: ImageManager.shared.topImages[safe: savedOutfits[indexPath.row].topIndex],
               bottom: ImageManager.shared.bottomImages[safe: savedOutfits[indexPath.row].bottomIndex],
               accessory: ImageManager.shared.accessoryImages[safe: savedOutfits[indexPath.row].accessoryIndex]
           )
           
         
            print (itemWidth)
        return CGSize(width: 166.5, height: 300)  // Adjust the height based on the aspect ratio
       
    }


    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Add space around the section
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }


    //turn three separate images into single composite image
    func createOutfitPreview(top: UIImage?, bottom: UIImage?, accessory: UIImage?) -> UIImage? {
        let canvasSize = CGSize(width: 200, height: 300) // Adjust as needed
        
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0.0) // Handle scaling

        // Draw the top image while preserving its aspect ratio
        if let topImage = top {
            let topAspectRatio = topImage.size.width / topImage.size.height
            let topHeight = canvasSize.height / 3
            let topWidth = topHeight * topAspectRatio
            let topRect = CGRect(x: (canvasSize.width - topWidth) / 2, y: 0, width: topWidth, height: topHeight)
            topImage.draw(in: topRect)
        }

        // Draw the bottom image while preserving its aspect ratio
        if let bottomImage = bottom {
            let bottomAspectRatio = bottomImage.size.width / bottomImage.size.height
            let bottomHeight = canvasSize.height / 3
            let bottomWidth = bottomHeight * bottomAspectRatio
            let bottomRect = CGRect(x: (canvasSize.width - bottomWidth) / 2, y: canvasSize.height / 3, width: bottomWidth, height: bottomHeight)
            bottomImage.draw(in: bottomRect)
        }

        // Draw the accessory image while preserving its aspect ratio
        if let accessoryImage = accessory {
            let accessoryAspectRatio = accessoryImage.size.width / accessoryImage.size.height
            let accessoryHeight = canvasSize.height / 3
            let accessoryWidth = accessoryHeight * accessoryAspectRatio
            let accessoryRect = CGRect(x: (canvasSize.width - accessoryWidth) / 2, y: 2 * canvasSize.height / 3, width: accessoryWidth, height: accessoryHeight)
            accessoryImage.draw(in: accessoryRect)
        }

        // Retrieve the combined image
        let compositeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return compositeImage
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
