//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Shom on 16.03.2022.
//

import UIKit
import iOSIntPackage


class PhotosCollectionViewCell: UICollectionViewCell {
    
    
    let imageProc = ImageProcessor()

    let filterArray = [ColorFilter.tonal, ColorFilter.colorInvert, ColorFilter.posterize, ColorFilter.sepia(intensity: 3), ColorFilter.fade, ColorFilter.crystallize(radius: 5), ColorFilter.noir]
    
    let photo: UIImageView = {
        let photo = UIImageView()
        photo.toAutoLayout()
        return photo
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(photo)
        initialLayout()
     
    }
    
    func initialLayout() {
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initialImages(_ name: String) {
        photo.image = UIImage(named: name)
        guard let image = photo.image else { return }
        imageProc.processImage(sourceImage: image, filter: getRandomFilter(set: filterArray)) { filteredImage in
            photo.image = filteredImage
        }
    }

    // случайный фильтр из масива
    func getRandomFilter (set: [ColorFilter]) -> ColorFilter {
        let randomFilterNumber = Int.random(in: 0..<set.count)
        return set[randomFilterNumber]
    }
}
