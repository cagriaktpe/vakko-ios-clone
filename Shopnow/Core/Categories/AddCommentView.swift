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
    
    @State private var title: String = "" // TODO: unused, delete it
    @State private var comment: String = ""
    @State private var rating: Int = 0
    
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    
    var body: some View {
        VStack {
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
                            .padding(.leading, 36)
                            .padding(.top, 25)
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
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
        })
    }
}

extension AddCommentView {
    func handleAddCommentButtonClick() {
        guard profileViewModel.user != nil else { return }
        
        do {
            try checkFields()
        } catch {
            makeAlert(title: "Hata", message: error.localizedDescription)
            return
        }
        
        let comment = CommentModel(authorId: profileViewModel.user?.userId ?? "", productId: productId, authorName: profileViewModel.user?.name ?? "", title: title, comment: comment, rating: rating, dateCreated: Date())
        
        Task {
            do {
                try productViewModel.addComment(comment: comment)
                dismiss()
            } catch {
                makeAlert(title: "Hata", message: error.localizedDescription)
            }
        }
    }
    
    func checkFields() throws {
        if comment.isEmpty || rating == 0 {
            throw NSError(domain: "Hata", code: 0, userInfo: [NSLocalizedDescriptionKey: "Yorum ve puan alanları boş bırakılamaz."])
        }
    }
    
    func makeAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

#Preview {
    AddCommentView(productId: "1")
        .environmentObject(ProfileViewModel())
        .environmentObject(ProductsViewModel())
}
