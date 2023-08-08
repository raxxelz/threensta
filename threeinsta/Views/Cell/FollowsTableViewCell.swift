//
//  FollowsTableViewCell.swift
//  threeinsta
//
//  Created by Kuanish on 31.07.2023.
//

import UIKit

protocol UserFollowsTableViewCellDelegate: AnyObject {
    func tapFollowUnfollowButton(model: String)
}

class FollowsTableViewCell: UITableViewCell {
    
    public weak var delegate: UserFollowsTableViewCellDelegate?

   static let identifier = "FollowsTableViewCell"
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    private let followButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(followButton)
    }
    public func configure(with model: String) {
        
    }
    //подготовка ячейки переиспользования , очищение значений ячейки
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        usernameLabel.text = nil
        followButton.layer.borderWidth = 0
        nameLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
