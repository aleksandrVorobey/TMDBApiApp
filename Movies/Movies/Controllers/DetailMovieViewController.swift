//
//  DetailMovieViewController.swift
//  Movies
//
//  Created by Александр Воробей on 18.10.2021.
//

import UIKit

class DetailMovieViewController: UIViewController {
        
    private let movieManager = MovieManager()
    
    private let detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 9
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title movie"
        label.font = UIFont(name: "Avenir Next Bold", size: 13)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Release date"
        label.font = UIFont(name: "Avenir Next Medium", size: 12)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overviewTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Overview movie"
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let voteAverage: UILabel = {
        let label = UILabel()
        label.text = "Vote average"
        label.font = UIFont(name: "Avenir Next Bold", size: 13)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setConstaints()
    }
    
    func setDetailMovie(movie: Movie) {
        releaseDateLabel.text = movie.getReleaseDate()
        titleLabel.text = movie.title
        voteAverage.text = "\(movie.voteAverage ?? 0.0)"
        overviewTextLabel.text = movie.overview
        movieManager.getImageFrom(url: movie.backdropURL) { data in
            if let image = UIImage(data: data) {
                self.detailImageView.image = image
            }
        }
    }
    //MARK: - Constraints
    private func setConstaints() {
                
        let stackView = UIStackView()
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(releaseDateLabel)
        stackView.addArrangedSubview(voteAverage)
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        view.addSubview(detailImageView)
        view.addSubview(overviewTextLabel)
        
        NSLayoutConstraint.activate([
            detailImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            detailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4),

            stackView.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            overviewTextLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            overviewTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            overviewTextLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65)
        ])
    }
    
}
