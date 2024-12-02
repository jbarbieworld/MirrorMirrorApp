//
//  ClosetViewController.swift
//  MirrorMirror
//
//  Created by Marilin Francisco on 11/12/24.
//

import Foundation
import UIKit

    /*class ClosetViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    // @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    var imageNames = ["converted_image", "Pants1", "Shirt2",  "Pants2", "Pants3", "Shirt3", "converted_image", "Pants1", "Shirt2",  "Pants2", "Shirt3", "converted_image", "Pants1", "Shirt2",  "Pants2", "Pants3", "Shirt3", "converted_image", "Pants1", "Shirt2",  "Pants2", "Shirt3", "converted_image", "Pants1", "Shirt2",  "Pants2", "Shirt3"] // Add names of your images in the assets folder
    
    var updatedImagePaths: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Configure the layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        
        // Load images from Documents directory
        let backgroundLessImages = loadBackgroundLessImages()
        ImageManager.shared.allImages = backgroundLessImages // Update data source
        collectionView.reloadData()
        
        // Observe for newly added images
        NotificationCenter.default.addObserver(self, selector: #selector(refreshCollectionView), name: Notification.Name("NewImageAdded"), object: nil)
        
        
    }
    
    func loadSavedImages() {
        let fileManager = FileManager.default
        let documentsDirectory = getDocumentsDirectory()
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: documentsDirectory.path)
            for path in filePaths where path.hasSuffix(".png") || path.hasSuffix(".jpeg") {
                let fileURL = documentsDirectory.appendingPathComponent(path)
                if let image = UIImage(contentsOfFile: fileURL.path) {
                    ImageManager.shared.allImages.append(image)
                    ImageManager.shared.imagePaths.append(fileURL.path)
                }
            }
        } catch {
            print("Failed to load images from Documents: \(error)")
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout.invalidateLayout() // Refresh layout
        collectionView.reloadData() // Reload collection view with updated data
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return ImageManager.shared.allImages.count
        return ImageManager.shared.imagePaths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20  // Adjust this value to control spacing
        let itemsPerRow: CGFloat = 2
        
        // Calculate the total padding and size per item
        let totalPadding = padding * (itemsPerRow + 1)
        let itemWidth = (collectionView.frame.width - totalPadding) / itemsPerRow
        
        return CGSize(width: itemWidth, height: itemWidth)  // Square cells
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCollectionViewCell else {
            fatalError("Unable to dequeue ImageCollectionViewCell")
        }
        //allImages == imagePaths
        let imagePath = ImageManager.shared.imagePaths[indexPath.item]
//loadBackgroundLessImages()
        if let image = UIImage(contentsOfFile: imagePath) {
            cell.imageView.image = image //images[indexPath.item]
        }
        
        return cell
    }
    
    func saveImagesToDocuments() {
        for imageName in imageNames {
            if let image = UIImage(named: imageName) { // Load image from assets
                if let data = image.pngData() {
                    let fileURL = getDocumentsDirectory().appendingPathComponent("\(imageName).png")
                    do {
                        try data.write(to: fileURL)
                        print("Saved \(imageName) to Documents")
                    } catch {
                        print("Failed to save \(imageName): \(error)")
                    }
                }
            } else {
                print("Image \(imageName) not found in assets.")
            }
        }
    }
    
    //        func loadImageFromDocuments(imageName: String) -> UIImage? {
    //            let fileURL = getDocumentsDirectory().appendingPathComponent("\(imageName).png")
    //            return UIImage(contentsOfFile: fileURL.path)
    //        }
    
    func loadBackgroundLessImages() -> [UIImage] {
        let backgroundLessDirectory = getDocumentsDirectory().appendingPathComponent("backgroundLess")
        var images: [UIImage] = []
        
        do {
            let filePaths = try FileManager.default.contentsOfDirectory(atPath: backgroundLessDirectory.path)
            print("BackgroundLess Directory Files: \(filePaths)")

            for path in filePaths where path.hasSuffix(".png") {
                let fileURL = backgroundLessDirectory.appendingPathComponent(path)
                if let image = UIImage(contentsOfFile: fileURL.path) {
                    images.append(image)
                }
                else {
                    print("Failed to load image: \(fileURL.path)")
                    }

            }
        } catch {
            print("Failed to load images from backgroundLess directory: \(error)")
        }
        
        return images
    }
    
    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    @objc func refreshCollectionView() {
        collectionView.reloadData() // Reload with updated images
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("NewImageAdded"), object: nil)
    }
    
    
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let padding: CGFloat = 20  // Adjust this value to control spacing
         let itemsPerRow: CGFloat = 2
         
         // Calculate the total padding and size per item
         let totalPadding = padding * (itemsPerRow + 1)
         let itemWidth = (collectionView.frame.width - totalPadding) / itemsPerRow
         
         return CGSize(width: itemWidth, height: itemWidth)  // Square cells
     }
     
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
     }

}*/

