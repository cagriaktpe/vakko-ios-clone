//
//  SignInView.swift
//  Shopnow
//
//  Created by Samet Çağrı Aktepe on 16.05.2024.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        ScrollView {
            VStack {
                emailSection
            }
        }
        .navigationTitle("Giriş")
    }
}

extension SignInView {
    var emailSection: some View {
        Section {
            VStack(spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("E-posta")
                        .font(.subheadline)
                    
                    TextField("", text: .constant(""))
                        .padding()
                        .background(Color(.systemGray6))
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text("Şifre")
                        .font(.subheadline)
                    
                    SecureField("Şifre", text: .constant(""))
                        .padding()
                        .background(Color(.systemGray6))
                }
                .padding(.horizontal)
                
                Button(action: {
                    print("Giriş Yapıldı")
                }, label: {
                    Text("Giriş Yap")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemBlue))
                        .cornerRadius(8)
                        .padding(.horizontal)
                })
            }
            

            
            
            
            
            
            // Forgot password
            Button(action: {
                print("Şifremi Unuttum")
            }, label: {
                Text("Şifremi Unuttum")
                    .foregroundColor(.blue)
                    .padding(.top)
            })
        }
    }
}

#Preview {
    NavigationStack {
        SignInView()
    }
}
