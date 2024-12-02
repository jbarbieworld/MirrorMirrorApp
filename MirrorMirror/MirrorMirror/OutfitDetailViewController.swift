//
//  OutfitDetailViewController.swift
//  MirrorMirror
//
//  Created by Marilin Francisco on 12/1/24.
//

import Foundation
import UIKit

class OutfitDetailViewController: UIViewController {
    
    var outfitImage: UIImage? // This will hold the image passed from the collection view cell
    
  
    @IBOutlet weak var outfitImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the image of the outfit
        outfitImageView.image = outfitImage
        outfitImageView.contentMode = .scaleAspectFit
    }
}
