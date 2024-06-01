//
//  AddCommentView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 31.05.2024.
//

import SwiftUI

struct AddCommentView: View {
    
    @EnvironmentObject var profileViewModel: ProfileViewModel
    @EnvironmentObject var productViewModel: ProductsViewModel
    
    @Environment(\.dismiss) var dismiss
    
    let productId: String
    
    @State private var title: String = ""
    @State private var comment: String = ""
    @State private var rating: Int = 0
    
    var body: some View {
        VStack {
            TextField("Başlık", text: $title)
                .padding()
                .background(Color(.systemGray6))
                .padding(.horizontal)
            
            TextEditor(text: $comment)
                .frame(height: 80)
                .padding()
                .scrollContentBackground(.hidden)
                
                .background(Color(.systemGray6))
                
                .padding(.horizontal)
                .overlay(alignment: .topLeading) {
                    if comment.isEmpty {
                        Text("Yorumunuzu yazın...")
                            .foregroundColor(.secondary.opacity(0.5))
                            .padding(.leading, 30)
                            .padding(.top)
                            .allowsHitTesting(false)
                    }
                }
                
            
            HStack {
                Text("Puan:")
                Spacer()
                ForEach(1 ..< 6) { index in
                    Button(action: {
                        rating = index
                    }, label: {
                        Image(systemName: index <= rating ? "star.fill" : "star")
                            .foregroundColor(index <= rating ? .yellow : .gray)
                    })
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .padding(.horizontal)
            
            Button(action: {
                handleAddCommentButtonClick()
            }, label: {
                Text("Yorum Ekle")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
            })
            .padding()
        }
        .padding()
    }
}

extension AddCommentView {
    func handleAddCommentButtonClick() {
        
        guard profileViewModel.user != nil else { return }
        
        let comment = CommentModel(authorId: profileViewModel.user?.userId ?? "", productId: productId, authorName: profileViewModel.user?.name ?? "", title: title, comment: comment, rating: rating, dateCreated: Date())
        
        Task {
            do {
                try productViewModel.addComment(comment: comment)
                dismiss()
            } catch {
                print(error)
            }
        }
        
    }
}

#Preview {
    AddCommentView(productId: "123213")
        .environmentObject(ProductsViewModel())
}
