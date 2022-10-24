//
//  BookViewController.swift
//  CleanSwift
//
//  Created by Furkan Eruçar on 1.08.2022.
//


import UIKit

protocol BookDisplayLogic: AnyObject {
    func displayNews(viewModel: Book.Fetch.ViewModel)
}

final class BookViewController: UIViewController {
    
    var interactor: BookBusinessLogic?
    var router: (BookRoutingLogic & BookDataPassing)?
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: Book.Fetch.ViewModel?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1 numara ile başladı. ViewController Gidicek dicek ki interactor'a, git "20" tane kitabı getir.
        interactor?.fetchNews(request: Book.Fetch.Request(result: "20"))
        tableView.registerNib(BookCell.self, bundle: .main)
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = BookInteractor()
        let presenter = BookPresenter()
        let router = BookRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension BookViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.news.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(type: BookCell.self, indexPath: indexPath)
        guard model = self.viewModel.news[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configure(viewModel: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.routeToNewsDetail(index: indexPath.row)
    }
}

extension BookViewController: BookDisplayLogic {
    //5 viewModel'i göster diyip tableview'u reload ediyorum ve gösteriyor.
    func displayNews(viewModel: Book.Fetch.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
    
}
