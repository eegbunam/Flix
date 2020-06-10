//
//  MoviesTableViewCell.swift
//  Flix
//
//  Created by Ebuka Egbunam on 6/9/20.
//  Copyright © 2020 Ebuka Egbunam. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    //IBOUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var MoviewImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }



}
