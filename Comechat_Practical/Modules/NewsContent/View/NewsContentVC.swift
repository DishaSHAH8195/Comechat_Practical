//
//  NewsContentVC.swift
//  Comechat_Practical
//
//  Created by Disha Shah on 02/12/21.
//

import UIKit
import WebKit

class NewsContentVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblTitle         : UILabel!
    @IBOutlet weak var webViewContent   : WKWebView!

    //MARK: - Variables
    var objNewsData : Article?
    
    //MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    //MARK: - setupData
    func setupData() {
        lblTitle.text = objNewsData?.title

        let url = URL(string: objNewsData?.url ?? "")
        let request = URLRequest(url: url!)
        webViewContent.navigationDelegate = self
        webViewContent.load(request)
    }
    
    //MARK: - UIBUtton Action
    @IBAction func btnCloseAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension NewsContentVC: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Started to load")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished loading")
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
}
