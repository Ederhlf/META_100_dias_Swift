//
//  TabBArController.swift
//  Project_7
//
//  Created by franklin gaspar on 24/04/23.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    // MARK: Variables
    var urlString: URL?
    let news = NewsListViewController()
    let test = Test()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ListNews"
        view.backgroundColor = .red
        delegate = self
        
        test.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        news.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
        
        tabBarController?.viewControllers?.append(test)
        tabBarController?.viewControllers?.append(news)
        setViewControllers([news, test], animated: true)
        
        if selectedViewController?.tabBarItem.tag == 0 {
                urlString = NetWorkManager.Constant.newAPI
        
                guard let url = urlString else { return }
              newsAPi(url: url)
            
            } else {
                showError()
            }
    }
    
    func newsAPi(url: URL) {
        NetWorkManager.shared.getNews(url: url) { news in
            switch news {
            
            case .success(let articles):
                self.news.articles = articles
                DispatchQueue.main.async {
                    self.news.tableView.reloadData()
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showError() {
        let ac = UIAlertController(
            title: "Loading error",
            message: "There was content.",
            preferredStyle: .alert
        )
        
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        if viewController.tabBarItem.tag  == 0 {
            self.urlString = NetWorkManager.Constant.newAPI
           
            newsAPi(url:urlString!)
            
        } else {
            showError()
        }
    }
  }

