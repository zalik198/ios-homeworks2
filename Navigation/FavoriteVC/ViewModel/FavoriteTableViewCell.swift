//
//  FavoriteTableViewCell.swift
//  Navigation
//
//  Created by Shom on 25.07.2022.
//

import Foundation
import UIKit
import StorageService

class FavoriteTableViewCell : UITableViewCell {
    
    //MARK: create labels
    private var authorCells: UILabel = {
        var authorCell = UILabel()
        authorCell.toAutoLayout()
        authorCell.font = .systemFont(ofSize: 20, weight: .bold)
        authorCell.textColor = .black
        authorCell.numberOfLines = 2
        return authorCell
    }()
    
    private var descriptionCells: UILabel = {
        var descriptionCell = UILabel()
        descriptionCell.toAutoLayout()
        descriptionCell.font = .systemFont(ofSize: 14)
        descriptionCell.textColor = .systemGray
        descriptionCell.numberOfLines = 0
        return descriptionCell
    }()
    
    private var imageCells: UIImageView = {
        var imageCell = UIImageView()
        imageCell.toAutoLayout()
        imageCell.contentMode = .scaleAspectFit
        imageCell.backgroundColor = .black
        return imageCell
    }()
    
    private var likesCells: UILabel = {
        var likesCell = UILabel()
        likesCell.toAutoLayout()
        likesCell.font = .systemFont(ofSize: 16)
        likesCell.textColor = .black
        return likesCell
    }()
    
    private var viewsCells: UILabel = {
        var viewsCell = UILabel()
        viewsCell.toAutoLayout()
        viewsCell.font = .systemFont(ofSize: 16)
        viewsCell.textColor = .black
        return viewsCell
    }()
    
    //MARK: Initial cells
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(authorCells, descriptionCells, imageCells, likesCells, viewsCells)
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Приравние структурных ячеек к созданным ячейкам
    
    public func myCells(_ post: PostData) {
        self.authorCells.text = post.authorCell ?? ""
        self.imageCells.image = UIImage(data: post.imageCell!) ?? UIImage()
        self.descriptionCells.text = "profileDescription".localized
        self.likesCells.text = "profileLikes".localized
        self.viewsCells.text = "profileViews".localized
    }
    
    //MARK: Initial constraints
    func initialLayout() {
        toAutoLayout()
        NSLayoutConstraint.activate([authorCells.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                                     authorCells.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                     authorCells.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                                     authorCells.heightAnchor.constraint(equalToConstant: 28),
                                     
                                     imageCells.topAnchor.constraint(equalTo: authorCells.bottomAnchor),
                                     imageCells.heightAnchor.constraint(equalTo: contentView.widthAnchor),
                                     imageCells.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                                     
                                     descriptionCells.topAnchor.constraint(equalTo: imageCells.bottomAnchor),
                                     descriptionCells.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                     descriptionCells.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                                     descriptionCells.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
                                     
                                     likesCells.topAnchor.constraint(equalTo: descriptionCells.bottomAnchor, constant: 16),
                                     likesCells.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                     likesCells.heightAnchor.constraint(equalToConstant: 20),
                                     
                                     viewsCells.topAnchor.constraint(equalTo: descriptionCells.bottomAnchor, constant: 16),
                                     viewsCells.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                                     viewsCells.heightAnchor.constraint(equalToConstant: 20)
                                    ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
