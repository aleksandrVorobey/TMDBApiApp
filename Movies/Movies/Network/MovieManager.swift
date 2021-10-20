//
//  MovieManager.swift
//  Movies
//
//  Created by Александр Воробей on 17.10.2021.
//

import Foundation

class MovieManager {
        
    func fetchMovies(filmsCategory: QueryMovie.RawValue, completion: @escaping (Result<MoviesData, Error>) -> ()) {
        let requestURL = API.baseURL + "\(filmsCategory)" + API.apiKey
        
        guard let requestURL = URL(string: requestURL) else { return }
        URLSession.shared.dataTask(with: requestURL, completionHandler: { data, response, error in
            if let error = error {
                completion(.failure(error))
                print("Data task error\(error)")
                return
            }
            guard let data = data else { return }
            
            do {
                let jsonData = try JSONDecoder().decode(MoviesData.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch {
                completion(.failure(error))
            }
        })
        .resume()
    }
    
    func getImageFrom(url: URL, completion: @escaping (Data) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
                completion(data)
            }
        }.resume()
    }
    
}
