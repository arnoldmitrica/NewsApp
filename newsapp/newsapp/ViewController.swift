//
//  ViewController.swift
//  newsapp
//
//  Created by Arnold Mitricã on 10.03.2021.
//

import UIKit

class ViewController: UITableViewController {
    var news: Welcome?
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
        
        let jsonURLString = "https://newsapi.org/v2/everything?q=tesla&from=2021-02-10&sortBy=publishedAt&apiKey=f71af7261c434b5d8be60816ed910d8b"

        guard let url = URL(string: jsonURLString) else { print("URL is invalid"); return }
        
        parse(jsonData: readLocalFile(forName: "articles")!)

//        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
//            guard let data = data, error == nil, response != nil else {
//                print("Something went wrong")
//                return
//            }
//            //print("test")
//            do {
//                let welcome = try JSONDecoder().decode(Welcome.self, from: data)
//                print(welcome)
//            } catch {
//                print("summots wrong")
//            }
//
//        }).resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let newscount = news{
            return newscount.articles.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? NewsCell else{
            fatalError("dequeReusableCell error")
        }
        guard let news = news else { fatalError("news is nil") }
        let urlpath = news.articles[indexPath.row].urlToImage
        let url = URL(string: urlpath)

        if let urlpath = url {
            cell.articleImage.loadImage(at: urlpath)
        }
        cell.articleTitle.text = news.articles[indexPath.row].title
        cell.timeAgo.text = news.articles[indexPath.row].publishedAt
        return cell
    }
        
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print("fatal error readlocalfile")
        }
        
        return nil
    }
    
    private func parse(jsonData: Data) {
        print(jsonData)
        do{
            let jsonPresidents = try JSONDecoder().decode(Welcome.self, from: jsonData)
            news = jsonPresidents
        }
        catch let jsonError as NSError{
            print("decode errossr \(jsonError.localizedDescription)")
        }
    }

}

