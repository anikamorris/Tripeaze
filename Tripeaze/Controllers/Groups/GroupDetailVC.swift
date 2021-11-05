//
//  GroupDetailVC.swift
//  Tripeaze
//
//  Created by Anika Morris on 11/5/21.
//

import Foundation
import UIKit

class GroupDetailController: UIViewController {
    
    //MARK: Properties
    weak var coordinator: GroupCoordinator?
    var group: Group!
    
    //MARK: Views
    var membersCollectionView: UICollectionView?
    let collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        return layout
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    //MARK: Methods
    private func setUpCollectionView() {
        membersCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: collectionViewLayout)
        membersCollectionView?.register(GroupMemberCell.self, forCellWithReuseIdentifier: GroupMemberCell.identifier)
        membersCollectionView?.delegate = self
        membersCollectionView?.dataSource = self
        membersCollectionView?.backgroundColor = .white
    }
    
    private func setUpViews() {
        setUpCollectionView()
        view.backgroundColor = .white
        view.addSubview(membersCollectionView!)
        NSLayoutConstraint.activate([
            membersCollectionView!.topAnchor.constraint(equalTo: view.topAnchor),
            membersCollectionView!.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            membersCollectionView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            membersCollectionView!.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension GroupDetailController: UICollectionViewDelegate {
    
}

extension GroupDetailController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group.members.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupMemberCell.identifier, for: indexPath) as! GroupMemberCell
        let name = group.members[indexPath.row]
        cell.setNameLabel(name)
        return cell
    }
}
