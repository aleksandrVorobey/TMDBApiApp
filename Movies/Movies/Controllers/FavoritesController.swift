//
//  FavoritesController.swift
//  Movies
//
//  Created by Александр Воробей on 17.10.2021.
//

import UIKit

class FavoritesController: UIViewController {
    
    private let movieManager = MovieManager()
            
    private let popularMoviesLabel: UILabel = {
        let label = UILabel()
        label.text = "POPULAR"
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var detailMoviesPopularCollectionView = FavoritesPopularCollectionView()
    
    private let uncomingMoviesLabel: UILabel = {
        let label = UILabel()
        label.text = "UNCOMING"
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailMoviesUncomingCollectionView = FavoritesUncomingCollectionView()
    
    var isOn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Movie"
        view.backgroundColor = .white
                
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.detailMoviesPopularCollectionView.reloadData()
    }

   //MARK: - Set Constraints
    private func setConstraints() {
        view.addSubview(popularMoviesLabel)
        view.addSubview(detailMoviesPopularCollectionView)
        view.addSubview(uncomingMoviesLabel)
        view.addSubview(detailMoviesUncomingCollectionView)
        
        NSLayoutConstraint.activate([
            popularMoviesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            popularMoviesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            popularMoviesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            detailMoviesPopularCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailMoviesPopularCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailMoviesPopularCollectionView.topAnchor.constraint(equalTo: popularMoviesLabel.bottomAnchor, constant: 5),
            detailMoviesPopularCollectionView.bottomAnchor.constraint(equalTo: uncomingMoviesLabel.topAnchor, constant: 10),
            
            uncomingMoviesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 45),
            uncomingMoviesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            uncomingMoviesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            detailMoviesUncomingCollectionView.topAnchor.constraint(equalTo: uncomingMoviesLabel.bottomAnchor),
            detailMoviesUncomingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailMoviesUncomingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailMoviesUncomingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -85)
        ])
    }
}


