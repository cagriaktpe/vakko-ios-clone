//
//  MenuView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 14.05.2024.
//

import SwiftUI

enum CategoryType: String, CaseIterable {
    case woman = "Kadın"
    case man = "Erkek"
}

struct CategoriesView: View {
    var body: some View {
        List {
            ForEach(CategoryType.allCases, id: \.self) { category in

                ZStack {
                    NavigationLink(destination: SubCategoriesView(category: category)) {
                        EmptyView()
                    }
                    .opacity(0)

                    HStack {
                        Text(category.rawValue.uppercased())
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
        .navigationTitle("KATEGORİLER")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .listStyle(.inset)
    }
}

#Preview {
    NavigationStack {
        CategoriesView()
    }
}
