//
//  NewsCell.swift
//  newsapp
//
//  Created by Arnold Mitricã on 10.03.2021.
//

import UIKit

class NewsCell: UITableViewCell, CellConfigurable, RowViewModel {
    @IBOutlet var timeAgo: UILabel!
    @IBOutlet var articleTitle: UILabel!
    @IBOutlet var articleImage: UIImageView!
    static let reuseIdentifier = "customCell"
    var tablecellViewModel : CellViewModel? {
        didSet {
            let dateFormatter = ISO8601DateFormatter()
            let date = dateFormatter.date(from: tablecellViewModel!.publishedAt)!
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

    override func prepareForReuse() {
        articleImage.image = nil
        articleImage.cancelImageLoad()
    }
    
    func setup(viewModel: RowViewModel) {
        guard let viewModel = viewModel as? CellViewModel else { fatalError("Newscell error")}
        tablecellViewModel = viewModel
    }

}
