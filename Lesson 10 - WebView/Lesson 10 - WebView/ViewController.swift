//
//  ViewController.swift
//  Lesson 10 - WebView
//
//  Created by Alex on 14/08/2016.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,WKNavigationDelegate {

    var webView: WKWebView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let preferences = WKPreferences();
        preferences.javaScriptEnabled = true;
        
        let configuration = WKWebViewConfiguration();
        
        webView = WKWebView(frame: CGRect(x: 0, y: 30, width: view.frame.width, height: view.frame.height - 30), configuration: configuration);
        
        let url = NSURL(string: "http://www.ynet.co.il");
        let urlRequest = NSURLRequest(URL: url!);
        webView.loadRequest(urlRequest);
        
        //webView.loadHTMLString("<html><head><body><h1>Hello!!!</h1></body></head></html>", baseURL: nil);
        
        webView.navigationDelegate = self;
        view.addSubview(webView);
        
    }
    
    //hide status bar
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

