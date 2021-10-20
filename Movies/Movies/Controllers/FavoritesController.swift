//
//  FavoritesController.swift
//  Movies
//
//  Created by Александр Воробей on 17.10.2021.
//

import UIKit

class FavoritesController: UIViewController {

    var favoriteMovie = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        view.backgroundColor = .white
    }
    
}
