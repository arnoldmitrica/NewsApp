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
    var tablecellViewModel : CellViewModel? {
        didSet {
            let dateFormatter = ISO8601DateFormatter()
            let date = dateFormatter.date(from: tablecellViewModel!.publisedAt)!
            let timenow = Date()
            let timediff = Date.timeFromLshToRhs(lhs: timenow, rhs: date)
            let timediffstring = TimeInterval(timediff).formatted
            timeAgo.text = timediffstring
            articleTitle.text = tablecellViewModel?.artTitle
            if let urlpath = tablecellViewModel?.urlImg{
                if let urlstring = URL(string: urlpath) {
                    articleImage.loadImage(at: urlstring)
                }
            }
            else{
                articleImage.image = UIImage(named: "noimage.png")
            }
        }
    }
    
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
