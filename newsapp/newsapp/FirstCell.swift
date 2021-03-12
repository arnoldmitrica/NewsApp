//
//  FirstCell.swift
//  newsapp
//
//  Created by Arnold Mitricã on 11.03.2021.
//

import UIKit

class FirstCell: UITableViewCell {
    static let reuseIdentifier = "firstCell"
    @IBOutlet var articleImage: UIImageView!
    
    @IBOutlet var timeAgo: UILabel!
    @IBOutlet var articleTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        articleImage.image = nil
        articleImage.cancelImageLoad()
    }

}
