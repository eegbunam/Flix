//
//  Api.swift
//  Flix
//
//  Created by Ebuka Egbunam on 6/9/20.
//  Copyright © 2020 Ebuka Egbunam. All rights reserved.
//

import Foundation


struct Api {
    static var baseUrlImage = "https://image.tmdb.org/t/p/w300"
    
    static func getMovies(completion : @escaping (Response?) -> ()){
        
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
            
            
            do{
                let decoder = JSONDecoder()
                let information = try decoder.decode(Response.self ,from: data)
                completion(information)
            }catch{
                print("couldnt decode data")
                completion(nil)
                
            }
            

              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()
    }
    
    
    static func getImageUrl(movie : Result) -> URL{
        
        return URL(string: baseUrlImage + movie.poster_path)!
        
        
    }
    
    static func getBackImageUrl(movie : Result) -> URL{
        let newBaseUrlImage = "https://image.tmdb.org/t/p/w500"
        
        return URL(string: newBaseUrlImage + movie.backdrop_path)!
        
        
    }
    
    
}


struct Response : Codable {
    var results : [Result]
}


struct Result :Codable {
    var title : String
    var overview : String
    var id : Int
    var poster_path : String
    var release_date : String
    var backdrop_path : String
    
 
}
