//
//  DetailViewController.swift
//  Project_7
//
//  Created by franklin gaspar on 23/04/23.
//

import Foundation
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView?
    var text: String?
        
    // MARK: Init
    convenience init(text: String) {
        self.init()
        self.text = text
    }
    
    // MARK: Life Cycle
    override func loadView() {
        super.loadView()
        webView = WKWebView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    
    guard let text = text else { return }

    let html = """
    <html>
    <head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style> body { font-size: 150%; } </style>
    </head>
    <body>
    \(text)
    </body>
    </html>
    """
        view.addSubview(webView!)
        webView?.frame = CGRect(
            x: view.frame.origin.x,
            y: view.frame.origin.y,
            width: view.frame.width,
            height: view.frame.height
        )
        
        webView!.loadHTMLString(html, baseURL: nil)
    }
}
