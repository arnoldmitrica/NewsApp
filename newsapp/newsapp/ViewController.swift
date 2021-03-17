//
//  ViewController.swift
//  newsapp
//
//  Created by Arnold Mitricã on 10.03.2021.
//
import Foundation
import UIKit

extension UINavigationBar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 51)
    }
}

class ViewController: UITableViewController, UINavigationControllerDelegate {
    
    lazy var viewModel: NewsViewModel = {
        return NewsViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initView()
        initVM()
    }
    
    func initView(){
        self.navigationController?.delegate = self
        self.navigationItem.title = "Front page"
    }
    
    func initVM() {
        
        // Naive binding
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.initFetch()

    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCells
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {

            viewModel.increasePage()
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        performSegue(withIdentifier: "Detail", sender: indexPath)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "Detail") {
            // initialize new view controller and cast it as your view controller
            let viewcontroller = segue.destination as? DetailViewController
            if let vc = viewcontroller{
                vc.detailview = viewModel.getCellViewModel(at: sender as! IndexPath) as? CellViewModel
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return viewModel.dequeCellTypeAt(indexPath: indexPath, tableView: tableView)
        let rowViewModel = viewModel.getCellViewModel(at: indexPath)
        //let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier(for: rowViewModel), for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier(for: indexPath), for: indexPath)
        if let cell = cell as? CellConfigurable {
            cell.setup(viewModel: rowViewModel)
        }
        //cell.layoutIfNeeded()
        return cell
    }
        
    func addNavBarImage() {

        let navController = navigationController!

        let image = UIImage(named: "title.png")
        let imageView = UIImageView(image: image)

        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height

        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2

        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit

        navigationItem.titleView = imageView
    }

}

