//
//  PopularArticlesVC.swift
//  Sample
//
//  Created by Prabhat Pandey on 10/02/23.
//

import UIKit

let kEstimatedNewsRableRowHeight:CGFloat = 100.0

class ArticlesVC: UIViewController {
    
    @IBOutlet weak var articleTableView: UITableView!
    
    var dataSource = ArticleDataSource()
    
    lazy var viewModel : ArticleViewModel = {
        let viewModel = ArticleViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = kNewsTitleString
        setUpIntials()
    }
    
    //MARK:- UI setu methods
    func setUpIntials() {
        Setup UI
        self.articleTableView.rowHeight = UITableView.automaticDimension
        self.articleTableView.estimatedRowHeight = kEstimatedNewsRableRowHeight
        //Setup datasource
        self.articleTableView.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.articleTableView.reloadData()
        }
        // Fetch article if network available
        Utils.isConnectedToNetwork() ? fetchArticle() : showAlertWithMessgae(message: kNoNetworkErrorMessgae)
    }
    
    func fetchArticle() {
        Spinner.useContainerView(view)
        Spinner.show("Please wait loading popular articles ....")
        self.viewModel.fetchArticles({[weak self] result in
            Spinner.hide()
            switch result {
            case .failure(let error):
                self?.showAlertWithMessgae(message: error.localizedDescription)
            default:
                NSLog("sucess")
                // NETWORK
                
            }
        })
    }
}

//MARK:- Extension for TableViewDelegate handling
extension ArticlesVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: kNewDetailSegue, sender: self.dataSource.data.value[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return 1 // Here also
    }
    
}

extension ArticlesVC {
    
    //MARK:- Alert
    func showAlertWithMessgae(message:String) {
        
        let alertView = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
        let action = UIAlertAction(title: kOkButtonTitle, style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kNewDetailSegue {
            let newsDetailVC = segue.destination as? ArticleDetailVC
            newsDetailVC?.detailNews = (sender as! ArticleCellViewModel).captionInfo
            newsDetailVC?.detailNewsImageUrl = (sender as! ArticleCellViewModel).imageUrl
            
        }
    }
}

