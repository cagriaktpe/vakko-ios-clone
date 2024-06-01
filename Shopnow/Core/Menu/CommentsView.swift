//
//  CommentsView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 31.05.2024.
//

import SwiftUI

struct CommentsView: View {
    @EnvironmentObject var viewModel: ProfileViewModel
    @EnvironmentObject var productsViewModel: ProductsViewModel

    @State private var comments: [CommentModel] = []
    @State private var showAddCommentView = false
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    let product: ProductModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(comments, id: \.self) { comment in
                    CommentRowView(comment: comment)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(alignment: .topTrailing) {
                            if viewModel.user?.userId == comment.authorId {
                                Menu {
                                    Button(role: .destructive) {
                                        removeComment(comment.commentId)
                                    } label: {
                                        Label("Sil", systemImage: "trash")
                                    }
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .foregroundColor(.gray)
                                }
                                .padding(.top, 8)
                                .padding(.trailing)
                            }
                        }
                    Divider()
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            

            if comments.isEmpty {
                Text("Henüz yorum yapılmamış.")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("YORUMLAR")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .toolbar(.hidden, for: .tabBar)
        .overlay(alignment: .bottom) {
            addCommentButton
        }
        .sheet(isPresented: $showAddCommentView) {
            NavigationStack {
                AddCommentView(productId: product.productId)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Kapat") {
                                showAddCommentView.toggle()
                            }
                        }
                    }
            }
            .presentationDetents([.height(350)])
            .onDisappear {
                comments = productsViewModel.comments.filter { $0.productId == product.productId }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
        }
        .onAppear {
            comments = productsViewModel.comments.filter { $0.productId == product.productId }

            // for testing
//       comments = CommentModel.mockArray
        }
    }
}

extension CommentsView {
    func removeComment(_ commentId: String) {
        Task {
            do {
                try await productsViewModel.removeComment(commentId: commentId)
                comments = comments.filter { $0.commentId != commentId }
            } catch {
                makeAlert(title: "Hata", message: "Yorum silinemedi.")
            }
        }
    }
    
    func makeAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert.toggle()
    }
}

struct CommentRowView: View {
    let comment: CommentModel

    var body: some View {
        VStack(alignment: .leading) {
            // rating
            HStack {
                ForEach(0 ..< comment.rating, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption)
                }
            }
            
            HStack {
                Text(comment.authorName)
                    .font(.caption)
                Text("|")
                Text(comment.dateCreated, style: .date)
                    .font(.caption)
            }
            .foregroundStyle(.secondary)
            .padding(.bottom, 2)

            Text(comment.comment)
                .font(.caption)

        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        
    }
}

extension CommentsView {
    var addCommentButton: some View {
        Button {
            do {
                try handleAddCommentButtonClick()
            } catch {
                makeAlert(title: "Hata", message: error.localizedDescription)
            }
        } label: {
            Text("YORUM YAP")
                .font(.title2)
                .fontWeight(.semibold)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
    }
}

extension CommentsView {
    func handleAddCommentButtonClick() throws {
        
        guard viewModel.user != nil else {
            throw NSError(domain: "CommentsView", code: 0, userInfo: [NSLocalizedDescriptionKey: "Yorum yapabilmek için giriş yapmalısınız."])
        }
        
        showAddCommentView.toggle()
        
    }
}

#Preview {
    return NavigationStack {
        CommentsView(product: ProductModel.mockData[0])
            .environmentObject(ProfileViewModel())
            .environmentObject(ProductsViewModel())
    }
}


// for testing
//                            Menu {
//                                Button(role: .destructive) {
//                                    removeComment(comment.commentId)
//                                } label: {
//                                    Label("Sil", systemImage: "trash")
//                                }
//                            } label: {
//                                Image(systemName: "ellipsis")
//                                    .foregroundColor(.gray)
//                            }
//                            .padding(.top, 8)
//                            .padding(.trailing)
