//
//  MovieViewController.swift
//  Movies
//
//  Created by Александр Воробей on 18.10.2021.
//

import UIKit

class MovieViewController: UIViewController {
    
    private let movieManager = MovieManager()
            
    private let popularMoviesLabel: UILabel = {
        let label = UILabel()
        label.text = "POPULAR"
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var moviesPopularCollectionView = MoviesPopularCollectionView()
    
    private let uncomingMoviesLabel: UILabel = {
        let label = UILabel()
        label.text = "UNCOMING"
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moviesUncomingCollectionView = MoviesUncomingCollectionView()
    
    private lazy var selectedBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "list.star"), style: .done, target: self, action: #selector(selectButtonTapped))
        return button
    }()
    
    var isOn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Movie"
        view.backgroundColor = .white
                
        setupNavigationBar()
        setupSearchController()
        setConstraints()
        fetchPopularMovies()
        fetchUpcomingMovies()
    }
    
    @objc func selectButtonTapped() {
        print(#function)
        if self.selectedBarButton.image == UIImage(systemName: "list.star") {
            alert()
        } else {
            self.selectedBarButton.image = UIImage(systemName: "list.star")
            self.moviesUncomingCollectionView.selectedMoviesArray()
            self.moviesPopularCollectionView.selectedMoviesArray()
            self.moviesPopularCollectionView.refresh()
            self.moviesUncomingCollectionView.refresh()
        }
    }
    
    func alert() {
        let alertController = UIAlertController(title: "Add in favorites", message: "Change movie for add in favorites", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            self.selectedBarButton.image = UIImage(systemName: "checkmark.circle.fill")
            self.moviesUncomingCollectionView.isButtonOn = true
            self.moviesPopularCollectionView.isButtonOn = true
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) { _ in
            self.moviesUncomingCollectionView.refresh()
            self.moviesPopularCollectionView.refresh()
        }
        alertController.addAction(cancel)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Fetch Movies
    private func fetchPopularMovies() {
        movieManager.fetchMovies(filmsCategory: QueryMovie.popular.rawValue, completion: { result in
            switch result {
            case .success(let movies):
                self.moviesPopularCollectionView.set(setMoviesArray: movies.results)
                self.moviesPopularCollectionView.newViewController = self
                self.moviesPopularCollectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    private func fetchUpcomingMovies() {
        movieManager.fetchMovies(filmsCategory: QueryMovie.upcoming.rawValue, completion: { result in
            switch result {
            case .success(let movies):
                self.moviesUncomingCollectionView.set(setMoviesArray: movies.results)
                self.moviesUncomingCollectionView.newViewController = self
                self.moviesUncomingCollectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    //MARK: - Setup UI Elements
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = selectedBarButton
    }

    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search movie"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
   //MARK: - Set Constraints
    private func setConstraints() {
        view.addSubview(popularMoviesLabel)
        view.addSubview(moviesPopularCollectionView)
        view.addSubview(uncomingMoviesLabel)
        view.addSubview(moviesUncomingCollectionView)
        
        NSLayoutConstraint.activate([
            popularMoviesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            popularMoviesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            popularMoviesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            moviesPopularCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesPopularCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesPopularCollectionView.topAnchor.constraint(equalTo: popularMoviesLabel.bottomAnchor, constant: 5),
            moviesPopularCollectionView.bottomAnchor.constraint(equalTo: uncomingMoviesLabel.topAnchor, constant: 10),
            
            uncomingMoviesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 45),
            uncomingMoviesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            uncomingMoviesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            moviesUncomingCollectionView.topAnchor.constraint(equalTo: uncomingMoviesLabel.bottomAnchor),
            moviesUncomingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesUncomingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesUncomingCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -85)
        ])
    }
}

extension MovieViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)            
    }
}
