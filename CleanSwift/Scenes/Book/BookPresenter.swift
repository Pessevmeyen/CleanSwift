//
//  BookPresenter.swift
//  CleanSwift
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation

protocol BookPresentationLogic: AnyObject {
    func presentNews(response: Book.Fetch.Response)
}

final class BookPresenter: BookPresentationLogic {
    
    weak var viewController: BookDisplayLogic? //Presenter ile View arasındaki bağlantıyı weak yapıyoruz.
    
    //4 worker tarafından kitaplarımız geldi. Burada formatlayıp, istediğimiz şekli verip...
    func presentNews(response: Book.Fetch.Response) {
        var news: [Book.Fetch.ViewModel.New] = []
        response.books.forEach {
            news.append(Book.Fetch.ViewModel.New(date: $0.releaseDate,
                                                 title: $0.name,
                                                 image: $0.artworkUrl100))
        }
        viewController?.displayNews(viewModel: Book.Fetch.ViewModel(news: news)) //viewController'ın display'ine yollıcaz.
    }
    
}
