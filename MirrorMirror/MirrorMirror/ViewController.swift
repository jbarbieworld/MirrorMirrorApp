//
//  ViewController.swift
//  MirrorMirror
//
//  Created by Jake Barberine on 11/6/24.
//

import UIKit


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    // Replace these with your actual API key and endpoint
    let apiKey = "4mb49wKzbwGBl7UTbFMZGPtagiHfiKymTHt9kcmuYI8OJve6ndQiJQQJ99AKACYeBjFXJ3w3AAAFACOGd5OZ"
    let endpoint = "https://mirrormirrorbackgroundremover.cognitiveservices.azure.com/"
    
    var imagePath: String?
    
    //****************************************************
    //SWIPE
    var buildOutfitVC: BuildOutfitVC?
    //****************************************************
    
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
        
        //****************************************************
        //SWIPE: give vc access to buildoutfitvc function
        if let outfitVC = storyboard?.instantiateViewController(withIdentifier: "BuildOutfitVC") as? BuildOutfitVC {
            buildOutfitVC = outfitVC
        }
        //****************************************************
        
        
        // Set a sample image
        imageView.image = UIImage(named: "test_shirt") // Replace with an actual image in your assets
        self.view.backgroundColor = UIColor.background

     
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
                        
                        //****************************************************
                        //SWIPE: get image path for build outfit vc
                        if let backgroundImage = UIImage(contentsOfFile: newImagePath.path) {
                            ImageManager.shared.backgroundRemovedImage = backgroundImage
                            ImageManager.shared.backgroundRemovedImagePath = saveImageToDocuments(image: backgroundImage, imageName: newImagePath.path)
                            
                        }
                        else {
                            print("Failed to load background image.")
                        }
                        //notify other view controllers with info
                        NotificationCenter.default.post(name: Notification.Name("BackgroundImageUpdated"), object: nil)
                        //****************************************************


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
    
    
    //SWIPE: buttons for category selection
    @IBOutlet weak var tb: UIButton!
    @IBOutlet weak var bb: UIButton!
    @IBOutlet weak var cb: UIButton!
    
    enum ClothingCategory {
        case top, bottom, accessory
    }

    var selectedCategory: ClothingCategory? = .top
    
    @IBAction func topButton(_ sender: UIButton) {
        ImageManager.shared.selectedCategory = .top
        //selectedCategory = .top

        print("Top category selected.")

    }
    @IBAction func bottomButton(_ sender: UIButton) {
        ImageManager.shared.selectedCategory = .bottom
        //selectedCategory = .bottom

        print("Bottom category selected.")
    }
    @IBAction func accessoryButton(_ sender: UIButton) {
        ImageManager.shared.selectedCategory = .accessory
        //selectedCategory = .accessory

        print("Accessory category selected.")

    }
    
    func updateImage() {
        buildOutfitVC?.updateImage()  // Optional chaining to avoid force unwrapping
    }

    
    //Camera functionality
    
    @IBAction func cameraOpened(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    // The info dictionary may contain multiple representations of the image. You want to use the original.
       /*guard let selectedImage = info[.originalImage] as? UIImage else {
        fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        imageView.image = selectedImage
        */
        
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
            if let savedPath = saveImageToDocuments(image: selectedImage, imageName: "captured_image_") {
                ImageManager.shared.imagePaths.append(savedPath)
                NotificationCenter.default.post(name: Notification.Name("NewImageAdded"), object: nil)
            }
            dismiss(animated: true, completion: nil)
        }
        dismiss(animated:true, completion: nil)

            
    }
    
}

//func saveImageToDocuments(image: UIImage, imageName: String) -> String? {
//    let fileURL = getDocumentsDirectory().appendingPathComponent("\(imageName).png")
//    guard let data = image.pngData() else { return nil }
//    do {
//        try data.write(to: fileURL)
//        print("Saved image to \(fileURL.path)")
//        return fileURL.path
//    } catch {
//        print("Failed to save image: \(error)")
//        return nil
//    }
//}

func saveImageToDocuments(image: UIImage, imageName: String) -> String? {
    let documentsDirectory = getDocumentsDirectory()
    let backgroundLessDirectory = documentsDirectory.appendingPathComponent("backgroundLess")
    
    // Ensure the "backgroundLess" directory exists
    if !FileManager.default.fileExists(atPath: backgroundLessDirectory.path) {
        do {
            try FileManager.default.createDirectory(at: backgroundLessDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Failed to create backgroundLess directory: \(error)")
            return nil
        }
    }
    
    // Append UUID to the file name
    let uniqueFileName = "\(imageName)_\(UUID().uuidString).png"
    let fileURL = backgroundLessDirectory.appendingPathComponent(uniqueFileName)
    
    // Save the image
    guard let data = image.pngData() else { return nil }
    do {
        try data.write(to: fileURL)
        print("Saved image to \(fileURL.path)")
        return fileURL.path
    } catch {
        print("Failed to save image: \(error)")
        return nil
    }
}

func getDocumentsDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
}




