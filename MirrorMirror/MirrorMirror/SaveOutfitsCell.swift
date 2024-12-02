//
//  SaveOutfitsCell.swift
//  MirrorMirror
//
//  Created by Marilin Francisco on 12/1/24.
//

import Foundation
import UIKit

class SaveOutfitsCell: UICollectionViewCell{
    
    
    @IBOutlet weak var outfitImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        outfitImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Use the aspect fit content mode to maintain the image's aspect ratio
        outfitImageView.contentMode = .scaleAspectFit
        outfitImageView.translatesAutoresizingMaskIntoConstraints = false

        // If you need the image to fit within the bounds of the cell without stretching or cutting off, add the following constraints:
        NSLayoutConstraint.activate([
            outfitImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            outfitImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            outfitImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            outfitImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
}
