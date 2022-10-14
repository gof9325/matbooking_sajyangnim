//
//  KakaoPostView.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/14.
//

import SwiftUI
import WebKit
import Combine
import WebView

struct KakaoPostView: View {
    var viewModel: KakaoPostViewModel
//    @Binding var restaurantAddress: String
    
//    init() {
//        let viewModel = KakaoPostViewModel()
//        _viewModel = StateObject(wrappedValue: viewModel)
//
//    }
    
    var body: some View {
        NavigationView {
            WebView(webView: viewModel.webViewStore.webView)
                .navigationBarTitle(Text(verbatim: viewModel.webViewStore.title ?? ""), displayMode: .inline)
        }.onAppear {
            self.viewModel.webViewStore.webView.load(URLRequest(url: URL(string: "https://gof9325.github.io/Kakao-Post/")!))
        }
    }
}

class KakaoPostViewModel: NSObject, WKScriptMessageHandler, ObservableObject {
    @Published var chosenAddress: KakaoAddress?
    @Published var webViewStore: WebViewStore

    override init() {
        let userContentController = WKUserContentController() // Handler 등록 위해 생성
        let configuration = WKWebViewConfiguration() // Webview의 세팅
        configuration.userContentController = userContentController
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webViewStore = WebViewStore(webView: webView)
        super.init()
        
        userContentController.add(self, name: "chooseAddress") // chooseAddress란 handler 등록
    }
    
    // 브라우저에서 handler 통해 iOS로 데이터 보낼 때 실행됨
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "chooseAddress" {
            let decoder = JSONDecoder()
            do {
                chosenAddress = try decoder.decode(KakaoAddress.self, from: (message.body as! String).data(using: .utf8)!)
                print()
            } catch let err {
                print(err)
            }
        }
   }
}

struct KakaoPostView_Previews: PreviewProvider {
    static var previews: some View {
        KakaoPostView(viewModel: KakaoPostViewModel())
    }
}
