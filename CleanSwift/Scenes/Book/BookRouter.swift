//
//  BookRouter.swift
//  CleanSwift
//
//  Created by Furkan Eruçar on 1.08.2022.
//

import Foundation
import UIKit

//Başka sayfalara geçmemizi sağlıyor.
protocol BookRoutingLogic: AnyObject {
    func routeToNewsDetail(index: Int)
}

//Başka sayfaya geçerken yollamak istediğimiz datalar.
protocol BookDataPassing: class {
    var dataStore: BookDataStore? { get }
}

//Başka sayfaya geçerken veriyi nasıl yollıcaz? Router yardımıyla. Route: Rota demek
final class BookRouter: BookRoutingLogic, BookDataPassing {
    
    weak var viewController: BookViewController?
    var dataStore: BookDataStore?
    
    //Burada storyboard oluşturup View Controller(Destination View Controller) verdikten sonra...
    func routeToNewsDetail(index: Int) {
        let storyBoard = UIStoryboard(name: "BookDetail", bundle: nil)
        let destVc: BookDetailViewController = storyBoard.instantiateViewController(withIdentifier: "BookDetailViewController")
    }
    
    //destinationdaki View Controller'ı router'ını dataStore'una, buradaki dataStore'danki veriyi versin diyoruz.
    destVC.router.dataStore?.book = dataStore?.books?[index]
    self.viewController?.navigationController?.pushViewController(destVc, animated: true)
    
}
