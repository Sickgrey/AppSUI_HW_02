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
    
    var rubric: String = ""
        
    func nextPage() {
        ArticlesAPI.everythingGet(q: rubric,
                                  from: "2023-07-01",
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
    
    @StateObject var newsapiVM: NewsapiVM = .init()
    var rubric: String
    
    var body: some View {
        newsapiVM.setRubric(newRubric: rubric)
        return VStack {
            List {
                ForEach(newsapiVM.articles) { article in
                    ListArticleCell(title: article.title ?? "",
                                    description: article.description ?? "")
                }
            }
            .listStyle(.insetGrouped)
        }
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
        NewsScreen(rubric: "")
    }
}
