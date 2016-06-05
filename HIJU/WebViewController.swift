//
//  WebViewController.swift
//  HIJU
//
//  Created by 武淅 段 on 16/6/5.
//  Copyright © 2016年 武淅 段. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate{

    var urlStr : String!
    var titleStr : String!
    @IBOutlet weak var titleTable: UILabel!
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.delegate = self
        self.titleTable.text = titleStr
        self.loadUrl(urlStr)
    }

    
    func loadUrl(urlStr : String){
        webView.loadRequest(NSURLRequest(URL: NSURL(string: urlStr)!))
    }
    
    @IBAction func didTapBack(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        print("load success!")
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("error:\(error)")
    }

}
