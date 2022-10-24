//
//  BookWorker.swift
//  CleanSwift
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation

protocol BookWorkingLogic: AnyObject {
    func getNews(request: BookRequestModel, completion: @escaping ((Result<BookResponseModel, Error>) -> Void))
}

final class BookWorker: BookWorkingLogic {
    
    //3 worker burada bizim istediğimiz 20 taneyi getirecek, ama getiremezse 10 tane getirecek.
    func getNews(request: BookRequestModel, completion: @escaping ((Result<BookResponseModel, Error>) -> Void)) {
        API.Book.getBook(result: request.result ?? "10").fetch(BookResponseModel.self) { result in
            switch result {
            case let .success(response):
                completion(.success(response)) // Success olursa getirdiklerini geri döndürüyor, nereye presenter'a.
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
