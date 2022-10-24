//
//  BookInteractor.swift
//  CleanSwift
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation

// interactor viewcontrollerdan kitap request'i aldı. interactor emri aldıktan sonra, önce bu foonksiyona ulaşıyor. Bu logic diyor ki, bilgileri çek. Burası çağrılınca...
protocol BookBusinessLogic: AnyObject {
    func fetchNews(request: Book.Fetch.Request)
}

//Bu da yollayacağımız dataları tutuyor.
protocol BookDataStore: AnyObject {
    var books: [Books]?{get}
}

final class BookInteractor: BookBusinessLogic, BookDataStore {
    
    var presenter: BookPresentationLogic?
    var worker: BookWorkingLogic = BookWorker()
    
    var books: [Books]?
    
    
    //Bu fonksiyon tetikleniyor.
    func fetchNews(request: Book.Fetch.Request) {
        //2 interactor da worker'a diyecek ki benden şu kadar kitap istendi, worker şu kitapları getirsene.
        worker.getNews(request: BookRequestModel(result: request.result)) { [weak self] result in
            switch result {
            case .success(let response): // worker kitapları getirdikten sonra success olursa eğer...
                self.books = response.feed?.results
                guard let news = self.books else { return }
                self.presenter.presentNews(response: Book.Fetch.Response(books: news)) //presenter'ı bu func ile çağırıp...
            case .failure(let error):
                break
            }
        }
    }
    
}
