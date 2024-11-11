//
//  ViewController.swift
//  MirrorMirror
//
//  Created by Jake Barberine on 11/6/24.
//

import UIKit


class ViewController: UIViewController {

    // Replace these with your actual API key and endpoint
    let apiKey = ""
    let endpoint = ""
       

    
       private let apiService: APIService
       
       @IBOutlet weak var imageView: UIImageView! // Connected to storyboard
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBAction func removeBackgroundButtonTapped(_ sender: UIButton) {
          removeBackground()
           imageView.layer.opacity = 0.5
        activityIndicator.startAnimating()
       }
       
       init() {
           self.apiService = APIService(apiKey: apiKey, endpoint: endpoint)
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           // Initialize the API service with API key and endpoint when using storyboard
           self.apiService = APIService(apiKey: apiKey, endpoint: endpoint)
           super.init(coder: coder)
       }
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           // Set a sample image
           imageView.image = UIImage(named: "test_shirt") // Replace with an actual image in your assets
       }
       
       private func removeBackground() {
           guard let originalImage = imageView.image else {
               print("No image found.")
               return
           }
           
           // Save the image to the document directory
           guard let imageData = originalImage.jpegData(compressionQuality: 0.5) else {
               print("Failed to convert image to data.")
               return
           }
           
           let fileManager = FileManager.default
           let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
           let originalImagePath = documentsDirectory.appendingPathComponent("original_image.jpeg")
           
           do {
               try imageData.write(to: originalImagePath)
               print("Original image saved to: \(originalImagePath.path)")
           } catch {
               print("Error saving original image: \(error)")
               return
           }
           
           // Call the APIService to remove the background using the image path
           apiService.removeBackground(from: originalImagePath.path, with: imageData) { [weak self] result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let backgroundRemovedData):
                       // Save the background-removed image to the Documents directory
                       let newImagePath = documentsDirectory.appendingPathComponent("background_removed_image.png")
                       
                       do {
                           try backgroundRemovedData.write(to: newImagePath)
                           print("Background-removed image saved to: \(newImagePath.path)")
                           
                           // Update the UIImageView with the new image
                           if let newImage = UIImage(contentsOfFile: newImagePath.path) {
                               self?.activityIndicator.stopAnimating()
                               self?.imageView.layer.opacity = 1
                               self?.imageView.image = newImage
                               print("Background removed successfully!")
                           }
                       } catch {
                           print("Error saving background-removed image: \(error)")
                       }
                       
                   case .failure(let error):
                       print("Error removing background: \(error.localizedDescription)")
                   }
               }
           }
       }
}

