//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Shom on 15.03.2022.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    private let facade = ImagePublisherFacade()
    private var newPhotoArray = [UIImage]()
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.scrollDirection = .vertical
        layout.collectionView?.toAutoLayout()
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.toAutoLayout()
        return collectionView
    }()
    
    let filterArray = [ColorFilter.tonal, ColorFilter.colorInvert, ColorFilter.posterize, ColorFilter.sepia(intensity: 3)]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        title = "Photo galery"
        view.addSubviews(collectionView)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "photosCollectionViewCell")
        
        facade.subscribe(self)
        facade.addImagesWithTimer(time: 0.5, repeat: 25, userImages: photosArray)
        
        initialLayout()
    }
    
    deinit {
        facade.rechargeImageLibrary()
        facade.removeSubscription(for: self)
    }
    
    //MARK: Initial constraints
    func initialLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    //MARK: Показ tabBar при открытии нового экрана и выключение tabBar при уходе с него
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        print("tabBar появился")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        print("tabBar исчез")
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        newPhotoArray = images
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newPhotoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        cell.initialImages(newPhotoArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width - 40) / 3, height: (collectionView.frame.width - 40) / 3)
    }
}
