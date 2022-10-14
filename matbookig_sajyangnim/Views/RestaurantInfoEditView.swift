//
//  SettingRestaurant.swift
//  matbookig_sajyangnim
//
//  Created by 황경원 on 2022/10/07.
//

import SwiftUI
import WebKit
import Combine
import WebView


struct RestaurantInfoEditView: View {
    @EnvironmentObject var ownerVM: OwnerViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var isCancle = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                PictureContentView()
                VStack(alignment: .leading) {
                    InPutFieldsView()
                }
                .padding()
                buttonGroup
            }
            .navigationTitle("가게 정보 설정")
        }
    }
    
    var buttonGroup: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink("다음") {
                    ReservationEditView()
                }
                .padding()
                .frame(width: 100)
                .background(Color.matNature)
                .cornerRadius(10)
                .foregroundColor(.white)
                Spacer()
                Button("취소") {
                    isCancle = true
                }
                .matbookingButtonStyle(width: 100, color: Color.matNature)
                .alert("가게 정보 설정을 취소하시겠습니까?", isPresented: $isCancle) {
                    Button("네", role: .cancel){
                        ownerVM.joinCancel()
                        self.dismiss()
                    }
                    Button("아니오") {
                        isCancle = false
                    }
                }
                Spacer()
            }
        }
    }
    
}

struct PictureContentView: View {
    
    var pictureList = [
        "person", "shield"
    ]
    
    var body: some View {
        VStack {
            Text("가게 이미지")
                .font(.largeTitle)
                .padding(.top)
            ImageSlider(images: pictureList)
                .background(.green)
                .cornerRadius(10)
                .padding(5)
                .frame(minHeight: 300)
        }
    }
}

struct KakaoAddress: Codable {
    let jibunAddress: String
    let roadAddress: String
    let zonecode: String
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
            } catch let err {
                print(err)
            }
        }
   }
}

struct KakaoPostView: View {
    @StateObject private var viewModel: KakaoPostViewModel
    init() {
        let viewModel = KakaoPostViewModel()
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            WebView(webView: viewModel.webViewStore.webView)
                .navigationBarTitle(Text(verbatim: viewModel.webViewStore.title ?? ""), displayMode: .inline)
        }.onAppear {
            self.viewModel.webViewStore.webView.load(URLRequest(url: URL(string: "https://gof9325.github.io/Kakao-Post/")!))
        }
    }
}

struct InPutFieldsView: View {
    
    @State var restaurantName = ""
    @State var restaurantAddress = ""
    @State var restaurantDescription = ""
    @State var openTimeDescription = ""
    
    @State var addressSearch = false
    
    var body: some View {
        VStack {
            InputFieldContentView(title: "가게 이름", placeHolder: "가게 이름", inputContent: $restaurantName)
            ZStack(alignment: .bottomTrailing) {
                InputFieldContentView(title: "가게 주소", placeHolder: "00시 00동 000-000", inputContent: $restaurantName)
                Button(action: {
                    addressSearch = true
                }, label: {
                    Image(systemName: "magnifyingglass")
                })
                .padding([.bottom, .trailing], 25)
                .foregroundColor(Color.matHavyGreen)
            }
            
            InputFieldContentView(title: "가게 번호", placeHolder: "000-0000-0000", inputContent: $restaurantName)

            DescriptionContentView(title: "가게 설명", placeHolder: "가게에 대한 설명을 200자 이내로 서술하세요")
            DescriptionContentView(title: "영업 설명", placeHolder: "영업과 관련된 설명을 200자 이내로 서술하세요")
        }
        .sheet(isPresented: $addressSearch) {
            KakaoPostView()
                .padding()
        }
    }
}

struct InputFieldContentView: View {
    let title: String
    let placeHolder: String
    @Binding var inputContent: String
    
    var body: some View {
        VStack {
            Text(title)
                .padding(.top)
            TextField(title, text: $inputContent)
                .underlineTextField(color: Color.matHavyGreen)
        }
    }
}

struct DescriptionContentView: View {
    
    let title: String
    @State var description: String = ""
    let placeHolder: String
    
    var body: some View {
        VStack {
            Text(title)
                .padding(.top)
            ZStack(alignment: .topLeading) {
                TextEditor(text: $description)
                    .padding()
                    .frame(height: 200, alignment: .leading)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.matHavyGreen)
                    )
                if description.isEmpty  {
                    Text(placeHolder)
                        .foregroundColor(Color.gray.opacity(0.5))
                        .padding(.horizontal, 25)
                        .padding(.vertical, 22)
                }
            }
        }
    }
}

struct SettingRestaurant_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantInfoEditView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
