//
//  BookModels.swift
//  CleanSwift
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation

// swiftlint:disable nesting
enum Book {
    
    enum Fetch {
        
        struct Request {
            let result: String
        }
        
        struct Response {
            var books: [Books]
        }
        
        struct ViewModel {
            let news: [Book.Fetch.ViewModel.New]
            
            struct New {
                let date: String?
                let title: String?
                let image: String?
            }
        }
        
    }
    
}
// swiftlint:enable nesting
