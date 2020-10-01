//
//  ViewController.swift
//  RunKeeperMedals
//
//  Created by Danilo Silveira on 2020-09-17.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    let achievementViewModel: AchievementViewModel = AchievementViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "achievedCell", for: indexPath) as? AchievementCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.achieveName.text = achievementViewModel.getName(index: indexPath)
        cell.achieveRecord.text = achievementViewModel.getRecord(index: indexPath)
        cell.medalIcon.image = achievementViewModel.getMedalIcon(index: indexPath) { img in
            DispatchQueue.main.async {
                cell.medalIcon.image = img
            }
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCollectionIdent", for: indexPath) as? HeaderCollectionReusableView else { return UICollectionReusableView()}
        header.title.text = achievementViewModel.getSectionName(section: indexPath.section)
        header.numOfAchievements.text = achievementViewModel.getAchievementSection(section: indexPath.section)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !achievementViewModel.hasAchieved(index: indexPath) {
            cell.alpha = 0.5
        } else {
            cell.alpha = 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/2.0
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return achievementViewModel.getNumberRows(section: section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return achievementViewModel.getNumberOfSection()
    }
}

