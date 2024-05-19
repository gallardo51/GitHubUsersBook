//
//  ContentView.swift
//  GitHubUsersBook
//
//  Created by Александр Соболев on 19.05.2024.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var fetch = FetchUsers()
    
    var body: some View {
        if (fetch.items.count == 0) {
            ProgressView().onAppear() {
                fetch.loadData()
            }
        }
        else {
            List(fetch.items, id: \.login) { user in
                Link(destination: URL(string: user.html_url)!) {
                    HStack(alignment: .top) {
                        AsyncImage(url: URL(string: user.avatar_url)) { image in
                            image.image?.resizable()
                                .frame(width: 50, height: 50)
                        }
                        VStack(alignment: .leading) {
                            Text(user.login)
                            Text("\(user.url)")
                                .font(.system(size: 11))
                                .foregroundStyle(Color.gray)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
