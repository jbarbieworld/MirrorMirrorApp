//
//  ClosetViewController.swift
//  MirrorMirror
//
//  Created by Marilin Francisco on 11/12/24.
//

import Foundation
import UIKit

class ClosetViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {

    
    // @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var imageNames = ["converted_image", "Pants1", "Shirt2",  "Pants2", "Pants3", "Shirt3", "converted_image", "Pants1", "Shirt2",  "Pants2", "Shirt3", "converted_image", "Pants1", "Shirt2",  "Pants2", "Pants3", "Shirt3", "converted_image", "Pants1", "Shirt2",  "Pants2", "Shirt3", "converted_image", "Pants1", "Shirt2",  "Pants2", "Shirt3"] // Add names of your images in the assets folder

        override func viewDidLoad() {
            super.viewDidLoad()
            collectionView.dataSource = self
            collectionView.delegate = self
            
            // Explicitly set UICollectionViewFlowLayout
               let layout = UICollectionViewFlowLayout()
               layout.scrollDirection = .vertical
               collectionView.collectionViewLayout = layout
               
               saveImagesToDocuments()
               collectionView.reloadData()
            
            self.view.backgroundColor = UIColor.background
            tabBarController?.tabBar.tintColor = .darkblue // Selected tab
            tabBarController?.tabBar.unselectedItemTintColor = .white
            self.view.backgroundColor = UIColor.background
           }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            collectionView.collectionViewLayout.invalidateLayout() // Refresh layout
            collectionView.reloadData()
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return imageNames.count
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
            
            let imageName = imageNames[indexPath.row]
            cell.imageView.image = loadImageFromDocuments(imageName: imageName)
            
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


        func loadImageFromDocuments(imageName: String) -> UIImage? {
            let fileURL = getDocumentsDirectory().appendingPathComponent("\(imageName).png")
            return UIImage(contentsOfFile: fileURL.path)
        }

        func getDocumentsDirectory() -> URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        }
    
    }
