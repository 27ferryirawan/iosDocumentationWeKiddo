//
//  FooterContentCell.swift
//  WeKiddoLogo-School
//
//  Created by zein rezky chandra on 17/04/19.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol FooterHomeDelegate: class {
    func goToNews()
    func goToNewsDetail(urlString: String?)
}

class FooterContentCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionNews: UICollectionView!
    @IBOutlet weak var moreNewsButton: UIButton!
    weak var delegate: FooterHomeDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionNews.delegate = self
        collectionNews.dataSource = self
        collectionNews.register(UINib(nibName: "NewsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "newsCollectionCell")
        moreNewsButton.addTarget(self, action: #selector(goToNewsPage), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @objc func goToNewsPage() {
        self.delegate?.goToNews()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ACData.DASHBOARDDATA.dashboardNews.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCollectionCell", for: indexPath as IndexPath) as! NewsCollectionCell
        cell.configCell(index: indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(ACData.DASHBOARDDATA.dashboardNews[indexPath.row].news_url)
        self.delegate?.goToNewsDetail(urlString: ACData.DASHBOARDDATA.dashboardNews[indexPath.row].news_url)
    }
}
