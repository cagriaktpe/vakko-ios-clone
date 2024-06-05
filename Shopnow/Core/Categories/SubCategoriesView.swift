//
//  SubCategoriesView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 30.05.2024.
//

import SwiftUI

enum WomanSubCategoryType: String, CaseIterable {
    case dress = "Elbise & Tulum"
    case jacket = "Ceket"
    case shirt = "Gömlek & Bluz"
    case pants = "Pantolon"
}

enum ManSubCategoryType: String, CaseIterable {
    case jacket = "Ceket"
    case suit = "Takım Elbise"
    case shirt = "Gömlek"
    case pants = "Pantolon"
}

struct SubCategoriesView: View {
    let category: CategoryType // main category
    
    @EnvironmentObject var vm: ProductsViewModel

    var body: some View {
        List {
            if category == .man {
                ForEach(ManSubCategoryType.allCases, id: \.self) { subCategory in
                    ZStack {
                        NavigationLink(destination: ProductListView(category: category.rawValue, subCategory: subCategory.rawValue)) {
                            EmptyView()
                        }

                        HStack {
                            Text(subCategory.rawValue)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.gray)
                        }
                    }
                }
            } else {
                ForEach(WomanSubCategoryType.allCases, id: \.self) { subCategory in
                    ZStack {
                        NavigationLink(destination: ProductListView(category: category.rawValue, subCategory: subCategory.rawValue)) {
                            EmptyView()
                        }

                        HStack {
                            Text(subCategory.rawValue)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
        }
        .navigationTitle(category.rawValue.uppercased())
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .listStyle(.inset)
    }
}

#Preview {
    NavigationStack {
        SubCategoriesView(category: .man)
            .environmentObject(ProductsViewModel())
    }
}
