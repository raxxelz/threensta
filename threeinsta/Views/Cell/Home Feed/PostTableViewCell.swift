//
//  PostTableViewCell.swift
//  threeinsta
//
//  Created by Kuanish on 28.07.2023.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    static let shared = PostTableViewCell()
    
    static let identifier = "PostTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        // конфигурация cell
    }
}
