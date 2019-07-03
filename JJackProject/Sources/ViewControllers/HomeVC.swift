//
//  HomeVC.swift
//  JJackProject
//
//  Created by SangIl Mo on 02/07/2019.
//  Copyright © 2019 SangIl Mo. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    let imageSet: [UIImage] = [
    (UIImage(named: "icCard"))!,
    (UIImage(named: "icCard"))!,
    (UIImage(named: "icCard"))!,
    (UIImage(named: "icCard"))!,
    (UIImage(named: "icCard"))!,
    (UIImage(named: "icCard"))!
    ]
    
    @IBOutlet weak var pageDot1: UIView!
    @IBOutlet weak var constraint1: NSLayoutConstraint!
    @IBOutlet weak var pageDot2: UIView!
    @IBOutlet weak var constraint2: NSLayoutConstraint!
    @IBOutlet weak var pageDot3: UIView!
    @IBOutlet weak var constraint3: NSLayoutConstraint!
    @IBOutlet weak var pageDot4: UIView!
    @IBOutlet weak var constraint4: NSLayoutConstraint!
    @IBOutlet weak var pageDot5: UIView!
    @IBOutlet weak var constraint5: NSLayoutConstraint!
    @IBOutlet weak var pageDot6: UIView!
    @IBOutlet weak var constraint6: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var HomeView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        HomeView.dataSource = self
        HomeView.delegate = self
        
        // collection View
        let cellWidth: CGFloat = 285
        let cellHeight: CGFloat = 328
        
        let insetX: CGFloat = (HomeView.bounds.width - cellWidth) / 2.0
        let insetY: CGFloat = (HomeView.bounds.height - cellHeight) / 2.0
        
        let layout = HomeView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .horizontal
        
        HomeView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        HomeView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        //paging 만들기!
//        HomeView.isPagingEnabled = true
        
        self.pageDot1.makeRounded(cornerRadius: nil)
        self.pageDot2.makeRounded(cornerRadius: nil)
        self.pageDot3.makeRounded(cornerRadius: nil)
        self.pageDot4.makeRounded(cornerRadius: nil)
        self.pageDot5.makeRounded(cornerRadius: nil)
        self.pageDot6.makeRounded(cornerRadius: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x: Int = Int((scrollView.contentOffset.x + 45) / 251)
        switch x {
        case 0:
            selectDot(view: pageDot1, constraints: constraint1)
            deselectDot(view: pageDot2, constraints: constraint2)
        case 1:
            selectDot(view: pageDot2, constraints: constraint2)
            deselectDot(view: pageDot1, constraints: constraint1)
            deselectDot(view: pageDot3, constraints: constraint3)
        case 2:
            selectDot(view: pageDot3, constraints: constraint3)
            deselectDot(view: pageDot2, constraints: constraint2)
            deselectDot(view: pageDot4, constraints: constraint4)
        case 3:
            selectDot(view: pageDot4, constraints: constraint4)
            deselectDot(view: pageDot3, constraints: constraint3)
            deselectDot(view: pageDot5, constraints: constraint5)
        case 4:
            selectDot(view: pageDot5, constraints: constraint5)
            deselectDot(view: pageDot4, constraints: constraint4)
            deselectDot(view: pageDot6, constraints: constraint6)
        case 5:
            selectDot(view: pageDot6, constraints: constraint6)
            deselectDot(view: pageDot5, constraints: constraint5)
        default:
            
            break
        }
        print(x)
        
    }
    func selectDot (view: UIView, constraints: NSLayoutConstraint) {
        UIView.animate(withDuration: 0.2, animations: {
            constraints.constant = 43
            view.backgroundColor = UIColor.mainCol
            self.view.layoutIfNeeded()
        })
    }
    func deselectDot (view: UIView, constraints: NSLayoutConstraint) {
        UIView.animate(withDuration: 0.2, animations: {
            constraints.constant = 12
            view.backgroundColor = UIColor.dotCol
            self.view.layoutIfNeeded()
        })
    }
    @IBAction func openMenu(_ sender: Any) {
        guard let dvc = UIStoryboard(name: "SideMenu", bundle: nil).instantiateViewController(withIdentifier: "SideMenuVC")as? SideMenuVC else {return}
        
        navigationController?.pushViewController(dvc, animated: true)
    }
    
}
extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath)as! HomeCell
        
//        let image = imageSet[indexPath.row]
        
        cell.categoryImg.image = imageSet[indexPath.row]
//        cell.makeRounded(cornerRadius: 8.0)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let dvc = storyboard?.instantiateViewController(withIdentifier: "MainVC") as? MainVC else {return}
        dvc.parmaIndex = indexPath.row
        present(dvc, animated: true, completion: nil)
    }

}

extension HomeVC: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let layout = self.HomeView.collectionViewLayout as! UICollectionViewFlowLayout
        
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        var roundIndex = round(index)
        
        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            roundIndex = floor(index)
        } else {
            roundIndex = ceil(index)
        }

        
        offset = CGPoint(x: roundIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
    }
    
}
