//
//  ProductCell.swift
//  avitoTestTask_ShapovalovA
//
//  Created by Aleksandr Shapovalov on 25/08/23.
//

import UIKit

class ProductCell: UICollectionViewCell {

    var nameLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)

        // Add constraints
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
