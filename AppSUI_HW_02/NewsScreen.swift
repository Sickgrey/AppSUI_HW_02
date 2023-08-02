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
    
    var rubric: String = "Apple"
    
    init() {
        nextPage()
   }
        
    func nextPage() {
        ArticlesAPI.everythingGet(q: rubric,
                                  from: "2023-07-10",
                                  sortBy: "publishedAt",
                                  language: "en",
                                  apiKey: "1dd3e90294f944c98f653a218f3a8ff4",
                                  page: 1) { data, error in
            debugPrint(error ?? "")
            self.articles = data?.articles ?? []
        }
    }
    
    func setRubric(newRubric: String) {
        rubric = newRubric
        nextPage()
    }
}

struct NewsScreen: View {
    
     init(rubric: String) {
        self.rubric = rubric
    }
    
    var rubric: String
    @EnvironmentObject var newsapiVM: NewsapiVM
    
    @State var isAnimation = false
    @State var isMoving = false
    
    var body: some View {
        VStack {
            List {
                ForEach(newsapiVM.articles) { article in
                    let index = newsapiVM.articles.firstIndex(of: article)
                    
                    ListArticleCell(title: article.title ?? "",
                                    description: article.description ?? "", index: index ?? 0)
                }
            }
            .listStyle(.insetGrouped)
        }
    }
}

struct ListArticleCell: View {
    
    var title: String
    var description: String
    var index: Int
    
    @EnvironmentObject var newsapiVM: NewsapiVM
    @State var isAnimation = false
    @State var isMoving = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(isAnimation ? .clear : .gray)
            VStack {
                Text(title.isEmpty ? description : title)
                    .foregroundColor(isAnimation ? .clear : .white)
                    .offset(x: isMoving ? 100 : 0)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .onTapGesture {
            withAnimation(.linear(duration: 2)) {
                isAnimation.toggle()
                isMoving.toggle()
                newsapiVM.articles.remove(at: index)
            }
        }
    }
}

