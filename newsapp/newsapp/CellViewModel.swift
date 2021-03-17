//
//  CellViewModel.swift
//  newsapp
//
//  Created by Arnold Mitricã on 15.03.2021.
//

import Foundation

class CellViewModel: RowViewModel{
    let artTitle:String
    let artDescription:String
    let urlImg:String?
    let publishedAt:String
    let category:String?
    
    init(artTitle:String, artDescription:String, urlImg:String?, publishedAt:String, category:String?) {
        self.artTitle = artTitle
        self.artDescription = artDescription
        self.urlImg = urlImg
        self.publishedAt = publishedAt
        self.category = category
    }
}

protocol RowViewModel { }

protocol CellConfigurable {
    func setup(viewModel: RowViewModel)
}
