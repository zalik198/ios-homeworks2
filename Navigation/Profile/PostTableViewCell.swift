//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Shom on 11.03.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    //MARK: create labels
    var authorCell: UILabel = {
        var authorCell = UILabel()
        authorCell.toAutoLayout()
        authorCell.font = .systemFont(ofSize: 20, weight: .bold)
        authorCell.textColor = .black
        authorCell.numberOfLines = 2
        return authorCell
    }()
    
    var descriptionCell: UILabel = {
        var descriptionCell = UILabel()
        descriptionCell.toAutoLayout()
        descriptionCell.font = .systemFont(ofSize: 14)
        descriptionCell.textColor = .systemGray
        descriptionCell.numberOfLines = 0
        return descriptionCell
    }()
    
    var imageCell: UIImageView = {
        var imageCell = UIImageView()
        imageCell.toAutoLayout()
        imageCell.contentMode = .scaleAspectFit
        imageCell.backgroundColor = .black
        return imageCell
    }()
    
    var likesCell: UILabel = {
        var likesCell = UILabel()
        likesCell.toAutoLayout()
        likesCell.font = .systemFont(ofSize: 16)
        likesCell.textColor = .black
        return likesCell
    }()
    
    var viewsCell: UILabel = {
        var viewsCell = UILabel()
        viewsCell.toAutoLayout()
        viewsCell.font = .systemFont(ofSize: 16)
        viewsCell.textColor = .black
        return viewsCell
    }()
    
    //MARK: Initial cells
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(authorCell, descriptionCell, imageCell, likesCell, viewsCell)
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Приравние структурных ячеек к созданным ячейкам
    
    public func myCells(post: Post) {
        authorCell.text = post.author
        imageCell.image = UIImage(named: post.image)
        descriptionCell.text = post.description
        likesCell.text = "Likes: \(post.likes)"
        viewsCell.text = "Views: \(post.views)"
    }
    
    //MARK: Initial constraints
    func initialLayout() {
        toAutoLayout()
        NSLayoutConstraint.activate([authorCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                                     authorCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                     authorCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                                     authorCell.heightAnchor.constraint(equalToConstant: 28),
                                     
                                     imageCell.topAnchor.constraint(equalTo: authorCell.bottomAnchor),
                                     imageCell.heightAnchor.constraint(equalTo: contentView.widthAnchor),
                                     imageCell.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                                     
                                     descriptionCell.topAnchor.constraint(equalTo: imageCell.bottomAnchor),
                                     descriptionCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                     descriptionCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                                     descriptionCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
                                     
                                     likesCell.topAnchor.constraint(equalTo: descriptionCell.bottomAnchor, constant: 16),
                                     likesCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                     likesCell.heightAnchor.constraint(equalToConstant: 20),
                                     
                                     viewsCell.topAnchor.constraint(equalTo: descriptionCell.bottomAnchor, constant: 16),
                                     viewsCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                                     viewsCell.heightAnchor.constraint(equalToConstant: 20)
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
