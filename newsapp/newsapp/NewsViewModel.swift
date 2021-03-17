//
//  NewsViewModel.swift
//  newsapp
//
//  Created by Arnold Mitricã on 15.03.2021.
//

import Foundation
import UIKit

class NewsViewModel {
    private var news: [Welcome] = [Welcome]()
    private var link = ""
    private var startingPage = 1
    
    private var cellViewModels: [RowViewModel] = [RowViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var reloadTableViewClosure: (()->())?
    
//    init(url link: String) {
//        self.link = link
//    }
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func initFetch() {
        request(startingPage)
    }
    
    func increasePage(){
        startingPage += 1
        initFetch()
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> RowViewModel {
        return cellViewModels[indexPath.row]
    }
    
//    func cellIdentifier(for viewModel: RowViewModel) -> String {
//        switch viewModel {
//        case is FirstCell:
//            return FirstCell.reuseIdentifier
//        case is NewsCell:
//            return NewsCell.reuseIdentifier
//        default:
//            fatalError("Unexpected view model type: \(viewModel)")
//        }
//    }
    
    func cellIdentifier(for indexPath: IndexPath) -> String {
        //if indexPath.row == 0
        switch indexPath {
        case _ where indexPath.row == 0:
            return FirstCell.reuseIdentifier
        case _ where indexPath.row > 0:
            return NewsCell.reuseIdentifier
        default:
            fatalError("Unexpected indexpath")
        }
    }
    
    private func request(_ page: Int){
        link = "https://newsapi.org/v2/everything?q=tesla&page=\(page)&pageSize=10&sortBy=publishedAt&apiKey=f71af7261c434b5d8be60816ed910d8b"
        guard let url = URL(string: link) else { print("URL is invalid"); return }
        URLSession.shared.dataTask(with: url, completionHandler: { (datawrapped, response, error) in
            guard let data = datawrapped, error == nil, response != nil else {
                print("Something went wrong")
                return
            }
            //print("test")
            self.parse(jsonData: data)
            

        }).resume()
    }
    
    func dequeCellTypeAt(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell{
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: FirstCell.reuseIdentifier, for: indexPath) as! FirstCell
            cell.tablecellViewModel = cellViewModels[0] as? CellViewModel
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseIdentifier, for: indexPath) as! NewsCell
        cell.tablecellViewModel = cellViewModels[indexPath.row] as? CellViewModel
        return cell
    }
    
    func createCellViewModel( newsArticle: Article ) -> CellViewModel {

        var content = "Any details are missing"
        if let descriptionUnwrapped = newsArticle.content {
            content = descriptionUnwrapped
        }
        // For this endpoint in JSON there is no category but the screenshots seem to have, I guess there is another interface for another endpoint and I left category with the title String
        return CellViewModel(artTitle: newsArticle.title, artDescription: content, urlImg: newsArticle.urlToImage, publishedAt: newsArticle.publishedAt, category: newsArticle.title)
    }
    
    private func processFetchedPhoto( newsArticles: Welcome ) {
        self.news.append(newsArticles) // Cache
        for newsArticle in newsArticles.articles {
            cellViewModels.append( createCellViewModel(newsArticle: newsArticle) )
        }
        //print(newsArticles)
    }
    
    private func parse(jsonData: Data) {
        //print(jsonData)
        do{
            let jsonDecoded = try JSONDecoder().decode(Welcome.self, from: jsonData)
            processFetchedPhoto(newsArticles: jsonDecoded)
        }
        catch let jsonError as NSError{
            print("decode errossr \(jsonError)")
        }
    }
}
