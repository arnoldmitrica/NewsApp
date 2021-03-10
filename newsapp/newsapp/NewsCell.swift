//
//  NewsCell.swift
//  newsapp
//
//  Created by Arnold Mitricã on 10.03.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet var timeAgo: UILabel!
    @IBOutlet var articleTitle: UILabel!
    @IBOutlet var articleImage: UIImageView!
    //var urltoImage:String = ""
    
    static let reuseIdentifier = "customCell"
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        articleImage.image = nil
        articleImage.cancelImageLoad()
    }

}
