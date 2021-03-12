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
    var news: Welcome?
    var jsonURLString = ""
    var i = 1
    var articleTitle = ""
    var articleText = ""
    var urlImg = ""
    var cat = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        request(i)
        self.navigationController?.delegate = self
        self.navigationItem.title = "Front page"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let newscount = news{
            return newscount.articles.count
        }
        return 0
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {

            i = i + 1
            print("         i=\(i)")
            request(i)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        articleTitle = news?.articles[indexPath.row].title ?? "No title"
        articleText = news?.articles[indexPath.row].content ?? "No content"
        urlImg = news?.articles[indexPath.row].urlToImage ?? "No image"
        cat = news?.articles[indexPath.row].source.name ?? "Worldwide"
        
        performSegue(withIdentifier: "Detail", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "Detail") {
            // initialize new view controller and cast it as your view controller
            let viewcontroller = segue.destination as? DetailViewController
            if let vc = viewcontroller{
                vc.imageurl = urlImg
                vc.artTitle = articleTitle
                vc.artText = articleText + articleText + articleText + articleText
                vc.cat = cat
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let news = news else { fatalError("news is nil") }
        
        
        if indexPath.row == 0 {
            guard let firstcell = tableView.dequeueReusableCell(withIdentifier: FirstCell.reuseIdentifier, for: IndexPath(row: 0, section: 0)) as? FirstCell else{
                fatalError("dequeReusableCell FirstCell error")
            }
            if let urlpath = news.articles[0].urlToImage{
                if let urlstring = URL(string: urlpath) {
                    firstcell.articleImage.loadImage(at: urlstring)
                }
            }
            else{
                firstcell.articleImage.image = UIImage(named: "noimage.png")
            }
            firstcell.articleTitle.text = news.articles[0].title
            let dateFormatter = ISO8601DateFormatter()
            let date = dateFormatter.date(from: news.articles[indexPath.row].publishedAt)!
            let timenow = Date()
            let timediff = Date.timeFromLshToRhs(lhs: timenow, rhs: date)
            let timediffstring = TimeInterval(timediff).formatted
            firstcell.timeAgo.text = timediffstring
            return firstcell
        }
        else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseIdentifier, for: indexPath) as? NewsCell else{
                fatalError("dequeReusableCell error")
            }
            if let urlpath = news.articles[indexPath.row].urlToImage{
                if let urlstring = URL(string: urlpath) {
                    cell.articleImage.loadImage(at: urlstring)
                }
            }
            else{
                cell.articleImage.image = UIImage(named: "noimage.png")
            }
            
            cell.articleTitle.text = news.articles[indexPath.row].title
            let dateFormatter = ISO8601DateFormatter()
            let date = dateFormatter.date(from: news.articles[indexPath.row].publishedAt)!
            let timenow = Date()
            let timediff = Date.timeFromLshToRhs(lhs: timenow, rhs: date)
            let timediffstring = TimeInterval(timediff).formatted
            cell.timeAgo.text = timediffstring
            return cell
        }
    }
        
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print("error readlocalfile")
        }
        
        return nil
    }
    
    private func request(_ page: Int){
        jsonURLString = "https://newsapi.org/v2/everything?q=tesla&page=\(page)&pageSize=10&sortBy=publishedAt&apiKey=f71af7261c434b5d8be60816ed910d8b"
        guard let url = URL(string: jsonURLString) else { print("URL is invalid"); return }
        URLSession.shared.dataTask(with: url, completionHandler: { (datawrapped, response, error) in
            guard let data = datawrapped, error == nil, response != nil else {
                print("Something went wrong")
                return
            }
            //print("test")
            self.parse(jsonData: data)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }).resume()
    }
    
    private func parse(jsonData: Data) {
        print(jsonData)
        do{
            let jsonDecoded = try JSONDecoder().decode(Welcome.self, from: jsonData)
            if i == 1 {
                news = jsonDecoded
            }
            else{
                news?.articles.append(contentsOf: jsonDecoded.articles)
            }
        }
        catch let jsonError as NSError{
            print("decode errossr \(jsonError)")
        }
    }
    
    func addNavBarImage() {

        let navController = navigationController!

        let image = UIImage(named: "title.png") //Your logo url here
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

