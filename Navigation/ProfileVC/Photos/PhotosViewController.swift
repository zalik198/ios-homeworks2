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
    let imageProcessor = ImageProcessor()
    var timerCount = 0.0
    var timer: Timer? = nil
    
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
        
        //facade.subscribe(self)
        //facade.addImagesWithTimer(time: 0.5, repeat: 25, userImages: photosArray)
        //            self.newPhotoArray.removeAll()
        //            images.forEach({self.newPhotoArray.append($0)})
        
        initialLayout()
        
        imageProcessor.processImagesOnThread(sourceImages: photosArray, filter: .process, qos: .utility) { cgImage in
            self.newPhotoArray = cgImage.map({UIImage(cgImage: $0!)})
            DispatchQueue.main.async{
                self.collectionView.reloadData()
            }
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        timerCount += 0.01
        if newPhotoArray.count > 0 {
            print("Прошло \(self.timerCount) секунд")
            timer!.invalidate()
        }
    }
    
    //Время выполнения метода всех приоритетов с разными фильтрами
    /*
     .default - 3.9 секунд
     .background - 15.3 секунд
     .userInitiated - 5.1 секунда
     .userInteractive - 4.8 секунд
     .utility - 4.5 секунд
     */
    
    
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
        //facade.rechargeImageLibrary()
        //facade.removeSubscription(for: self)
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout //ImageLibrarySubscriber
{
    //    func receive(images: [UIImage]) {
    //        newPhotoArray = images
    //        collectionView.reloadData()
    //    }
    
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
