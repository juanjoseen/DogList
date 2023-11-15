//
//  DogCell.swift
//  DogList
//
//  Created by Juan Jose Elias Navaro on 15/11/23.
//

import UIKit

class DogCell: UITableViewCell {

    static let identifier: String = "DogCell"
    
    lazy var imgDog: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    lazy var lblName: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .titleColor
        label.numberOfLines = 1
        return label
    }()
    
    lazy var lblDescription: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .textColor
        label.numberOfLines = 3
        label.textAlignment = .justified
        return label
    }()
    
    lazy var lblAge: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .titleColor
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .background
        selectionStyle = .none
        
        let bgInfo: UIView = UIView()
        bgInfo.translatesAutoresizingMaskIntoConstraints = false
        bgInfo.backgroundColor = .white
        bgInfo.clipsToBounds = true
        bgInfo.layer.cornerRadius = 8
        
        bgInfo.addSubview(lblName)
        bgInfo.addSubview(lblDescription)
        bgInfo.addSubview(lblAge)
        
        contentView.addSubview(bgInfo)
        contentView.addSubview(imgDog)
        
        NSLayoutConstraint.activate([
            
            bgInfo.bottomAnchor.constraint(equalTo: imgDog.bottomAnchor),
            bgInfo.leadingAnchor.constraint(equalTo: imgDog.leadingAnchor),
            bgInfo.topAnchor.constraint(equalTo: imgDog.topAnchor, constant: 24),
            bgInfo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            imgDog.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imgDog.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            imgDog.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imgDog.widthAnchor.constraint(equalToConstant: 120),
            imgDog.heightAnchor.constraint(equalToConstant: 180),
            
            lblName.topAnchor.constraint(equalTo: bgInfo.topAnchor, constant: 16),
            lblName.leadingAnchor.constraint(equalTo: imgDog.trailingAnchor, constant: 16),
            lblName.trailingAnchor.constraint(equalTo: bgInfo.trailingAnchor, constant: -16),
            
            lblDescription.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 16),
            lblDescription.leadingAnchor.constraint(equalTo: lblName.leadingAnchor),
            lblDescription.trailingAnchor.constraint(equalTo: lblName.trailingAnchor),
            
            lblAge.leadingAnchor.constraint(equalTo: lblName.leadingAnchor),
            lblAge.trailingAnchor.constraint(equalTo: lblName.trailingAnchor),
            lblAge.bottomAnchor.constraint(equalTo: bgInfo.bottomAnchor, constant: -24),
        ])
    }
    
    func config(with dog: Dog) {
        lblName.text = dog.dogName
        lblDescription.text = dog.description
        lblAge.text = String(format: "Almost %d years", dog.age)
        imgDog.downloadImage(dog.image)
    }

}
