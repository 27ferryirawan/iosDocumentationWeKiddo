//
//  OnboardingViewController.swift
//  WeKiddo
//
//  Created by Ferry Irawan on 24/05/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var nextLbl: UILabel!
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigation()
        configTable()
        pageControl.hidesForSinglePage = true
        pageControl.pageIndicatorTintColor = UIColor(hex: "#A6F8F8")
        pageControl.currentPageIndicatorTintColor = UIColor(hex: "#44B8E2")
        nextBtn.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        //        pageControl.addTarget(self, action: #selector(pageBeingClicked), for: .touchUpInside)
    }
    
    @objc func pageBeingClicked(sender: UIPageControl) {
        let page: Int? = sender.currentPage
        let cellSize = CGSize(width: 414, height: self.view.frame.height);
        
        //get current content Offset of the Collection view
        let contentOffset = collectionView.contentOffset;
        //scroll to next cell
        if page == 0 {
            collectionView.scrollRectToVisible(CGRect(x: 0 + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);
        }
        else if page == 1 {
            collectionView.scrollRectToVisible(CGRect(x: 414 + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);
        }
        else if page == 2 {
            collectionView.scrollRectToVisible(CGRect(x: 827 + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);
        }
        
    }
    
    @objc func nextPage(){
        //get cell size
        let cellSize = CGSize(width: 414, height: self.view.frame.height);
        
        //get current content Offset of the Collection view
        let contentOffset = collectionView.contentOffset;
        
        //scroll to next cell
        collectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true);
    }
    
    func configNavigation() {
        detectAdaptiveClass()
        self.navigationController?.navigationBar.isHidden = true
    }
    func configTable() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "OnboardingCollectionCell", bundle: nil), forCellWithReuseIdentifier: "onboardingCollectionCell")
        collectionView.isPagingEnabled = true
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = 3
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingCollectionCell", for: indexPath) as? OnboardingCollectionCell)!
        cell.configCell(index: indexPath.row)
        cell.delegate = self
        return cell
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updatePageControl(scrollView: scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updatePageControl(scrollView: scrollView)
    }
    func updatePageControl(scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.bounds.size.width)
        print(scrollView.contentOffset.x)
        let currentPageNumber = Int(pageNumber) % 3
        if currentPageNumber == 2 {
            nextLbl.isHidden = true
            arrowImg.isHidden = true
            pageControl.isHidden = true
            nextBtn.isHidden = true
        } else{
            nextLbl.isHidden = false
            arrowImg.isHidden = false
            pageControl.isHidden = false
            nextBtn.isHidden = false
        }
        pageControl.currentPage = currentPageNumber
    }
}
extension OnboardingViewController: OnboardingCollectionDelegate {
    func toLogin() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.showLoginView()
        UserDefaults.standard.set(true, forKey: "isFirstInstall")
        UserDefaults.standard.synchronize()
    }
    //    func carouselState(state: Int) {
    //        if state == 0 {
    //            carouselOne.image = UIImage(named: "ic_2")
    //            carouselTwo.image = UIImage(named: "ic_1")
    //            carouselThree.image = UIImage(named: "ic_1")
    //        } else if state == 1 {
    //            carouselOne.image = UIImage(named: "ic_1")
    //            carouselTwo.image = UIImage(named: "ic_2")
    //            carouselThree.image = UIImage(named: "ic_1")
    //        } else{
    //            carouselOne.isHidden = true
    //            carouselTwo.isHidden = true
    //            carouselThree.isHidden = true
    //        }
    //    }
}
