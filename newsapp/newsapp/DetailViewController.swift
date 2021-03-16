//
//  DetailViewController.swift
//  newsapp
//
//  Created by Arnold Mitricã on 11.03.2021.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var articleImage: UIImageView!
    @IBOutlet var category: UILabel!
    @IBOutlet var articleTitle: UILabel!
    @IBOutlet var articleText: UILabel!
    
    var detailview : CellViewModel? {
        didSet {
            fillUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillUI()

//        navigationItem.title = category.text
//        
//        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backbutton.png")
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backbutton.png")
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
//        UITableView.appearance().separatorStyle = .none
    }
    func fillUI(){
        if !isViewLoaded{
            return
        }
        guard let detailview = detailview else {
            return
        }
        articleTitle.text = detailview.artTitle
        articleText.text = detailview.artDescription + detailview.artDescription + detailview.artDescription
        category.text = detailview.category
        if let urlpath = detailview.urlImg{
            if let urlstring = URL(string: urlpath) {
                articleImage.loadImage(at: urlstring)
            }
        }
        else{
            articleImage.image = UIImage(named: "noimage.png")
        }
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
    deinit {
        print("Detail view controller deinitialized")
    }
}

