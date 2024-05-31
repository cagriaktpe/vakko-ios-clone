//
//  AddCommentView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 31.05.2024.
//

import SwiftUI

struct AddCommentView: View {
    
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
                .frame(height: 50)
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
                // add comment
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

#Preview {
    AddCommentView()
}
