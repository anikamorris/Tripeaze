//
//  GroupMemberCell.swift
//  Tripeaze
//
//  Created by Anika Morris on 11/5/21.
//

import Foundation
import UIKit

class GroupMemberCell: UICollectionViewCell {
    
    // MARK: Properties
    static let identifier: String = "GroupMemberCell"
    
    //MARK: Subviews
    let circleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 30
        view.backgroundColor = .primaryColor
        return view
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    private func setUpViews() {
        self.addSubview(circleView)
        circleView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: self.topAnchor),
            circleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            circleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            circleView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
    
    func setNameLabel(_ name: String) {
        nameLabel.text = name
    }
}
