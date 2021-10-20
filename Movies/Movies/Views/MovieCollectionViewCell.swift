//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Александр Воробей on 17.10.2021.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "MovieCell"
    
    private let movieManager = MovieManager()
    
    let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 9
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let checkmark: UIImageView = {
        let image = UIImage(systemName: "heart.fill")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title movie"
        label.font = UIFont(name: "Avenir Next Bold", size: 13)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Release"
        label.font = UIFont(name: "Avenir Next Medium", size: 11)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    override var isSelected: Bool {
//        didSet {
//            updateSelectedState()
//        }
//    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupMovieUI()
        //updateSelectedState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5
        self.layer.shadowRadius = 10
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 4, height: 6)
        self.clipsToBounds = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
    }
    
    private func updateSelectedState() {
        movieImageView.alpha = isSelected ? 0.7 : 1
        checkmark.alpha = isSelected ? 1 : 0
    }

    //MARK: - Setup cell and set image
    func setupCell(movie: Movie) {
        self.releaseDateLabel.text = movie.releaseDate
        self.titleLabel.text = movie.title
        getImage(backdropURL: movie) { data in
            if let image = UIImage(data: data) {
                self.movieImageView.image = image
            }
        }
    }
    
    private func getImage(backdropURL: Movie, completion: @escaping (Data) -> ()) {
        self.movieImageView.image = nil
        movieManager.getImageFrom(url: backdropURL.posterURL) { data in
                completion(data)
        }
    }

    //MARK: - SetupUICell
    private func setupMovieUI() {
        
        addSubview(movieImageView)
        addSubview(titleLabel)
        addSubview(checkmark)
        addSubview(releaseDateLabel)
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: self.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            releaseDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            releaseDateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            
            checkmark.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: -8),
            checkmark.bottomAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: -8)
        ])
    }
}
