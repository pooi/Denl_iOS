//
//  ViewController.swift
//  Denl_iOS
//
//  Created by 유태우 on 2018. 5. 30..
//  Copyright © 2018년 유태우. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    

    var webView: WKWebView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func loadView() {
        super.loadView()
        
        let statusBarHeight : Int = Int(UIApplication.shared.statusBarFrame.height)
        print(statusBarHeight)
        
//        webView = WKWebView(frame: self.view.frame)
//        webView.uiDelegate = self
//        webView.navigationDelegate = self
//
//        self.view = self.webView!
        
        let webConfiguration = WKWebViewConfiguration()
        
        webView = WKWebView(frame:.zero , configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        webView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        //view = webView
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        let wvf : String = "V:|-\(statusBarHeight)-[v0]|"
        print(wvf)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":webView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: wvf, options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":webView]))
        
        
//        let webConfiguration = WKWebViewConfiguration()
//
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        webView.navigationDelegate = self
//        self.view = webView
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.url) {
//            let path = webView.url?.lastPathComponent
//            if(path=="/"){
//                UIApplication.shared.statusBarView?.backgroundColor = .white
//                UIApplication.shared.statusBarStyle = .default
//            }else{
//                UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 216.0/255.0, green: 67.0/255.0, blue: 21.0/255.0, alpha: 1)
//                UIApplication.shared.statusBarStyle = .lightContent
//            }
            print("### URL:", self.webView.url!)
        }
        
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            // When page load finishes. Should work on each page reload.
            if (self.webView.estimatedProgress == 1) {
                let path = webView.url?.lastPathComponent
                if(path=="/"){
                    UIApplication.shared.statusBarView?.backgroundColor = .white
                    UIApplication.shared.statusBarStyle = .default
                }else{
                    UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 216.0/255.0, green: 67.0/255.0, blue: 21.0/255.0, alpha: 1)
                    UIApplication.shared.statusBarStyle = .lightContent
                }
                print("### URL2:", self.webView.url!)
                print("### EP:", self.webView.estimatedProgress)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 216.0/255.0, green: 67.0/255.0, blue: 21.0/255.0, alpha: 1)
//        UIApplication.shared.statusBarStyle = .lightContent
    
        // Do any additional setup after loading the view, typically from a nib.
        let myBlog = "http://beta.denl.xyz"
        let url = URL(string: myBlog)
        let request = URLRequest(url: url!)
        webView.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Swift.Void){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let otherAction = UIAlertAction(title: "OK", style: .default, handler: {action in completionHandler()})
        alert.addAction(otherAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Swift.Void){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "CANCEL", style: .cancel, handler: {(action) in completionHandler(false)})
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action) in completionHandler(true)})
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.frame = CGRect(x: view.frame.midX-50, y: view.frame.midY-50, width: 100, height: 100)
        activityIndicator.color = UIColor.red
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
    }
    
    
    @available(iOS 8.0, *)
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        //activityIndicator.stopAnimating()
        self.activityIndicator.removeFromSuperview()
    }


}

