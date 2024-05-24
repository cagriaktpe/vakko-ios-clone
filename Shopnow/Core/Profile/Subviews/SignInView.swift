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
            VStack(spacing: 20) {
                emailSection
                
                registerSection
            }
            .padding(.top)
        }
        .navigationTitle("Giriş")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension SignInView {
    var emailSection: some View {
        Section {
            VStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("E-posta")
                        .font(.subheadline)
                        .fontWeight(.light)

                    TextField("", text: .constant(""))
                        .padding(12)
                        .border(Color.gray, width: 1)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .textContentType(.emailAddress)
                        .disableAutocorrection(true)
                }
                

                VStack(alignment: .leading, spacing: 4) {
                    Text("Şifre")
                        .font(.subheadline)
                        .fontWeight(.light)

                    SecureField("", text: .constant(""))
                        .padding(12)
                        .border(Color.gray, width: 1)
                        .textContentType(.password)
                        .disableAutocorrection(true)
                        .keyboardType(.default)
                }
                
                .padding(.bottom)

                Button(action: {
                    print("Giriş Yapıldı")
                }, label: {
                    Text("GİRİŞ YAP")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        
                })
                
                Button(action: {
                    print("Şifremi Unuttum")
                }, label: {
                    Text("Şifremi Unuttum")
                        .foregroundColor(.primary)
                        .font(.subheadline)
                        .fontWeight(.light)
                        .padding(4)
                })
            }
            .padding()
            .padding(.top)
            .border(Color.gray.opacity(0.4), width: 1)
            .padding(.horizontal)
        }
    }
    
    var registerSection: some View {
        Section {
            VStack(spacing: 10) {
                Text("ARAMIZA KATILMAK İSTER MİSİN?")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                Text("Sipariş takibi, kolay iade ve daha fazlası için bir hesap oluşturun.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .fontWeight(.light)
                    .padding(.bottom)
                
                Button(action: {
                    
                }, label: {
                    Text("ÜYE OL")
                        .fontWeight(.bold)
                        .font(.headline)
                        .foregroundColor(.accentColor)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .border(Color.accentColor, width: 1)
                })
            }
            .padding()
            .padding(.top)
            .border(Color.gray.opacity(0.4), width: 1)
            .padding(.horizontal)
        }
    }
}

#Preview {
    NavigationStack {
        SignInView()
    }
}
