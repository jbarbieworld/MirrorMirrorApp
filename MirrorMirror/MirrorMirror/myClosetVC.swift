//
//  myClosetVC.swift
//  MirrorMirror
//
//  Created by Marilin Francisco on 12/2/24.
//

import Foundation
import UIKit

class myClosetVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var closetCV: UICollectionView!

    
    var images: [UIImage] {
        get { return ImageManager.shared.backgroundRemovedImages }
        set { ImageManager.shared.backgroundRemovedImages = newValue }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        closetCV.delegate = self
        closetCV.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        closetCV.collectionViewLayout = UICollectionViewFlowLayout()

        layout.scrollDirection = .vertical
        closetCV.collectionViewLayout = layout

        print("Background Removed Images: \(ImageManager.shared.backgroundRemovedImages)")

        //add starter clothes
        if images.isEmpty {
            images.append(UIImage(named: "Shirt2.png")!)
            images.append(UIImage(named: "Pants1.png")!)
        }
            closetCV.reloadData()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateClosetView),
            name: Notification.Name("BackgroundImageUpdated"),
            object: nil
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        closetCV.dataSource = self
        closetCV.delegate = self
        closetCV.collectionViewLayout.invalidateLayout() // Refresh layout

        if !images.isEmpty {
            updateClosetView()
            closetCV.reloadData()
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return ImageManager.shared.backgroundRemovedImages.count
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClosetCell", for: indexPath) as? myClosetViewCell {
            let image = images[indexPath.row]
            print("Setting image at index \(indexPath.row)")

            cell.closetImage.image = image
            return cell
        } else {
            fatalError("Unable to dequeue a myClosetViewCell with identifier 'ClosetCell'")
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let itemsPerRow: CGFloat = 2
        
        let totalPadding = padding * (itemsPerRow + 1)
        let itemWidth = (collectionView.frame.width - totalPadding) / itemsPerRow
        
        return CGSize(width: itemWidth, height: itemWidth)  
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let padding: CGFloat = 16

        return UIEdgeInsets(top: 16, left: padding, bottom: 16, right: padding)
    }



    @objc func updateClosetView() {
        print("Updating closet view")
        // Debug: print current images count before updating
        print("Current backgroundRemovedImages: \(ImageManager.shared.backgroundRemovedImages)")
        print("Number of images before update: \(images.count)")

        // If backgroundRemovedImages is updated, make sure it reflects here
        if let updatedImage = ImageManager.shared.backgroundRemovedImage {
            print("Background image updated: \(updatedImage)")

            // Check if the image already exists in the array
            if !ImageManager.shared.backgroundRemovedImages.contains(updatedImage) {
                ImageManager.shared.backgroundRemovedImages.append(updatedImage)
                print("Image added to array.")

            } else {
                print("Image already exists in array.")
            }
        }

        // Debug: print current images count after updating
        print("Number of images after update: \(images.count)")
        
        closetCV.collectionViewLayout.invalidateLayout()

        closetCV.reloadData()
    }
    
    func saveBackgroundRemovedImage(image: UIImage) {
        // Save image
        ImageManager.shared.backgroundRemovedImages.append(image)
        DispatchQueue.main.async {
            self.closetCV.reloadData()
        }
    }

}
