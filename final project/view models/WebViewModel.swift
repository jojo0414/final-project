//
//  YoutubePlayerViewModel.swift
//  final project
//
//  Created by 陳昕喬🐷 on 2022/1/11.
//

import UIKit
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable{
    
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: urlString){
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    typealias UIViewType = WKWebView
    
    
}
