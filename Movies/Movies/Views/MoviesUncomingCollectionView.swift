//
//  MoviesUncomingCollectionView.swift
//  Movies
//
//  Created by Александр Воробей on 18.10.2021.
//

import UIKit

class MoviesUncomingCollectionView: UICollectionView {
    
    var uncomingMovies = [Movie]()
    var selectedUncomingMovies = [Movie]()
    
    var newViewController: UIViewController?
    
    var isButtonOn = false
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        settingCollectionView()
    }
    
    private func settingCollectionView() {
        register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseId)
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
        self.uncomingMovies = setMoviesArray
    }
    
    func selectedMoviesArray() {
        isButtonOn = true
        let selectedMovies = self.indexPathsForSelectedItems?.reduce([], { (movies, indexPath) -> [Movie] in
            var selectedMovies = movies
            let movie = uncomingMovies[indexPath.item]
            selectedMovies.append(movie)
            return selectedMovies
        })
        selectedUncomingMovies.append(contentsOf: selectedMovies ?? [])
        //selectedMovies = selectedMovie ?? []
        print("Array uncoming select\(selectedUncomingMovies)")
    }
    
    func refresh() {
        isButtonOn = false
        self.selectItem(at: nil, animated: true, scrollPosition: [])
    }
    
}

extension MoviesUncomingCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return uncomingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseId, for: indexPath) as! MovieCollectionViewCell
        let movie = uncomingMovies[indexPath.item]
        cell.setupCell(movie: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isButtonOn {
            self.selectItem(at: nil, animated: false, scrollPosition: [])
            let movie = uncomingMovies[indexPath.item]
            let detailVC = DetailMovieViewController()
            detailVC.setDetailMovie(movie: movie)
            newViewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }

}

extension MoviesUncomingCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ConstantsCollectionView.galleryItemWidth, height: frame.height * 0.9)
    }
}
