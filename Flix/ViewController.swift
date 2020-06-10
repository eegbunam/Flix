//
//  ViewController.swift
//  Flix
//
//  Created by Ebuka Egbunam on 6/9/20.
//  Copyright © 2020 Ebuka Egbunam. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController {
    
    //iboutlets
    
    @IBOutlet weak var moviesTableView: UITableView!
    var Movies : Response?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movies"
        setUpTableview()
        Api.getMovies { [weak self] (data) in
            
            guard let self = self else {return}
            self.Movies = data
            DispatchQueue.main.async {
                self.moviesTableView.reloadData()
            }
            
        }
    }
    
    
    func setUpTableview()  {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }


}


extension ViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let Movies = Movies else {
            return 5
        }
        return Movies.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let Movies = Movies else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "The api failed sorry"
            return cell
            
        }
        
        if let cell = moviesTableView.dequeueReusableCell(withIdentifier: "cell") as? MoviesTableViewCell {
            
            let movie = Movies.results[indexPath.row]
            cell.titleLabel.text = movie.title
            cell.descriptionLabel.text  = movie.overview
            cell.MoviewImageView.af.setImage(withURL: Api.getImageUrl(movie: movie))
            return cell
        }else{
            let cell = UITableViewCell()
            cell.textLabel?.text = Movies.results[indexPath.row].title
            return cell
        }
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    
    
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

