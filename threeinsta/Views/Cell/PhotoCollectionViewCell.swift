//
//  PhotoCollectionViewCell.swift
//  threeinsta
//
//  Created by Kuanish on 29.07.2023.
//
import SDWebImage
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCollectionViewCell"
    
    private let photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit //передача размера imageView
        return imageView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.image = nil
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.clipsToBounds = true
        accessibilityLabel = "User post image" // func voiceOver будет читать этот текст
        accessibilityHint = "Double-tap to open post"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserPost) {
        let url = model.thumbnailImage
        photoImageView.sd_setImage(with: url)
    }
    public func configure(with imageName: String) {
        photoImageView.image = UIImage(named: imageName)
    } 

}
