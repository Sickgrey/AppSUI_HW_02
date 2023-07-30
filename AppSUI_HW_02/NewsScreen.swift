//
//  NewsScreen.swift
//  AppSUI_HW_02
//
//  Created by Сергей Смирнов on 22/7/23.
//

import SwiftUI
import NewsapiNetworking

extension Article: Identifiable {
    public var id: String { url }
}

final class NewsapiVM: ObservableObject {
    @Published var articles: [Article] = []
    
    init () {
        nextPage()
    }
    
    func nextPage() {
        ArticlesAPI.everythingGet(q: "Vision Pro",
                                  from: "2023-07-01",
                                  sortBy: "publishedAt",
                                  language: "ru",
                                  apiKey: "1dd3e90294f944c98f653a218f3a8ff4",
                                  page: 1) { data, error in
            debugPrint(error ?? "")
            self.articles = data?.articles ?? []
        }
    }
}

struct NewsScreen: View {
    
    @StateObject var newsapiVM: NewsapiVM = .init()
    var pickerOptions = ["List", "Grid"]
    @State var pickerVariant = 0
    
    var body: some View {
        VStack {
            Picker("", selection: $pickerVariant) {
                ForEach(0..<pickerOptions.count, id: \.self) {i in
                    Text(self.pickerOptions[i])
                        .tag(i)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            switch pickerVariant {
            case 0:
                list
            case 1:
                grid
            default:
                EmptyView()
            }
        }
    }
    
    var grid: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: .init(), count: 2)) {
                ForEach(newsapiVM.articles) { article in
                    ListArticleCell(title: article.title ?? "",
                                    description: article.description ?? "")
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    var list: some View {
        List {
            ForEach(newsapiVM.articles) { article in
                ListArticleCell(title: article.title ?? "",
                                description: article.description ?? "")
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct ListArticleCell: View {
    
    var title: String
    var description: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.gray)
            VStack {
                Text(title.isEmpty ? description : title)
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
    }
}

struct NewsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsScreen()
    }
}
