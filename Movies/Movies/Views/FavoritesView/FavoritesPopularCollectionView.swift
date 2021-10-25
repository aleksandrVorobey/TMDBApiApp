//
//  FavoritesPopularCollectionView.swift
//  Movies
//
//  Created by Александр Воробей on 25.10.2021.
//

import UIKit

class FavoritesPopularCollectionView: UICollectionView {
    
    var favoritesPopularMovies = [Movie]()
    
     init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        settingCollectionView()
    }
    
    private func settingCollectionView() {
        register(FavoriteslMoviesCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteslMoviesCollectionViewCell.reuseId)
        delegate = self
        dataSource = self
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        contentInset = UIEdgeInsets(top: 0, left: ConstantsCollectionView.leftDistaneToView, bottom: 0, right: ConstantsCollectionView.righttDistaneToView)
        showsHorizontalScrollIndicator = false
        allowsMultipleSelection = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(setMoviesArray: [Movie]) {
        self.favoritesPopularMovies = setMoviesArray
        print("Set movies \(favoritesPopularMovies.count)")
        self.reloadData()
        print("relod")
    }
    
}

extension FavoritesPopularCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Count \(favoritesPopularMovies.count)")
        return favoritesPopularMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteslMoviesCollectionViewCell.reuseId, for: indexPath) as! FavoriteslMoviesCollectionViewCell
        let movie = favoritesPopularMovies[indexPath.item]
        cell.setupCell(movie: movie)
        return cell
    }

}

extension FavoritesPopularCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ConstantsCollectionView.galleryItemWidth, height: frame.height * 0.9)
    }
}
