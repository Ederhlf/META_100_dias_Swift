//
//  ViewController.swift
//  Project_4
//
//  Created by franklin gaspar on 16/04/23.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var webSites = ["github.com", "www.hackingwithswift.com"]

    var progressView: UIProgressView = {
        var pgView = UIProgressView()
        pgView = UIProgressView(progressViewStyle: .default)
        pgView.frame = CGRect(x: 0, y: 0, width: 100, height: 7)
        return pgView
    }()
    
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        view = webView
        webView?.navigationDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
        title = "Web Test"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Open",
            style: .plain,
            target: self,
            action: #selector(tapOnBtn)
        )
                        
        // set ToolBar Button
        let progressBtn = UIBarButtonItem(customView: progressView)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView?.reload))
        let goBack = UIBarButtonItem(title:"GoBack", style: .plain, target: webView, action: #selector(webView.goBack))
        let goForward = UIBarButtonItem(title:"GoForward", style: .plain, target: webView, action: #selector(webView.goForward))

        toolbarItems = [progressBtn, spacer, goBack, goForward, refresh]
        navigationController?.isToolbarHidden = false
        navigationController?.tabBarController?.tabBar.sizeToFit()

        // Observable
        webView?.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }

    override  func observeValue(forKeyPath keyPath: String?, of object: Any?,
                                change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    @objc func tapOnBtn() {
        let alertVc = UIAlertController(
            title: "Sites",
            message: "Escolha uma das opcoes",
            preferredStyle: .actionSheet
        )
        
        for webSite in webSites {
            alertVc.addAction(UIAlertAction(title: webSite, style: .default, handler: openPage))
        }
        
        alertVc.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        alertVc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(alertVc, animated: true, completion: nil)
        
    }
    
    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://\(actionTitle)") else { return }
        
        webView.load(URLRequest(url: url))
     //   webView?.allowsBackForwardNavigationGestures = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url

        if let host = url?.host {
            for webSite in webSites {
                if host.contains(webSite) {

                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
    }
}

