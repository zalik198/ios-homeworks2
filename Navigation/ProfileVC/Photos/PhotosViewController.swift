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
    //var timerCount = 0.0
    //var timer: Timer? = nil
    let start = DispatchTime.now()
    
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
        title = "photo.title".localized
        view.addSubviews(collectionView)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "photosCollectionViewCell")
        
        //facade.subscribe(self)
        //facade.addImagesWithTimer(time: 0.5, repeat: 25, userImages: photosArray)
        //            self.newPhotoArray.removeAll()
        //            images.forEach({self.newPhotoArray.append($0)})
        
        //collectionView.backgroundColor = UIColor.myViewBackground
        //self.view.overrideUserInterfaceStyle = .light
        //self.view.backgroundColor = .quaternaryLabel
        //self.setupBackgroundColor(self.traitCollection.userInterfaceStyle)
        
        initialLayout()
        
        self.view.backgroundColor = UIColor.createColor(light: .white, dark: .systemGray5)
        self.collectionView.backgroundColor = UIColor.createColor(light: .white, dark: .systemGray5)
        
        imageProcessor.processImagesOnThread(sourceImages: photosArray, filter: .noir, qos: .userInteractive) { cgImage in
            self.newPhotoArray = cgImage.map({UIImage(cgImage: $0!)})
            let end = DispatchTime.now()
            let nanoTime = end.uptimeNanoseconds - self.start.uptimeNanoseconds
            let timeInterval = Double(nanoTime) / 1_000_000_000
            print("time - \(timeInterval)")
            DispatchQueue.main.async{
                self.collectionView.reloadData()
            }
        }
        
    }
    //    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    //        guard let previousTraitCollection = previousTraitCollection else {
    //            return
    //        }
    //
    //        self.setupBackgroundColor(previousTraitCollection.userInterfaceStyle)
    //
    //    }
    //
    //    private func setupBackgroundColor(_ style: UIUserInterfaceStyle) {
    //            if style == .dark {
    //                self.view.backgroundColor = .green
    //                //self.collectionView.backgroundColor = .green
    //            } else {
    //                self.view.backgroundColor = .yellow
    //                //self.collectionView.backgroundColor = .yellow
    //                self.view.tintColor = .black
    //
    //            }
    //
    //    }
    
    
    
    //Время выполнения метода всех приоритетов с разными фильтрами
    /*
     .default - 3.9 секунд
     .background - 4.1 секунд
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


//timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)

//@objc func updateTimer() {

//        timerCount += 0.01
//        if newPhotoArray.count > 0 {
//            print("Прошло \(self.timerCount) секунд")
//            timer!.invalidate()
//}
//}
