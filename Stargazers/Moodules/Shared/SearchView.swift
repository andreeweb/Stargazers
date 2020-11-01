//
//  SearchBar.swift
//  Stargazers
//
//  Created by MacOS on 11/1/20.
//

import SwiftUI

struct SearchView: View {
    
    @State private var owner = ""
    @State private var repository = ""
 
    @State private var isEditing = false
        
    var results: (String, String) -> Void
 
    var body: some View {
        
        VStack {
            
            VStack {
                
                SerachHeader()
                
                SearchOwnerField()
                
                SearchRepositoryField()
            
                SearchButton()
                            
            }.background(Color.white)
            
            VStack{}
                .frame(minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity
            )
            .background(Color.gray)
            .ignoresSafeArea()
            .opacity(0.8)   
        }
    }
    
    private func SerachHeader() -> some View {
        
        return HStack {
            
            Text("Search")
                .font(.system(size: 30))
            
            Spacer()
            
            Button(action: {
                
                self.results("", "")
                
            }) {
                Text("Close")
            }
            
        }.padding(.horizontal)
        .padding(.top)
    }
    
    private func SearchOwnerField() -> some View {
        
        return HStack {
            
            TextField("Repository owner...", text: $owner)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.owner = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
        }
    }
    
    private func SearchRepositoryField() -> some View {
        
        return HStack {
            
            TextField("Repository name...", text: $repository)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.repository = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
        }
    }
    
    private func SearchButton() -> some View {
        
        return HStack {
            
            Button(action: {
                
                self.results(self.owner, self.repository)
                
            }) {
                Text("Search")
            }.frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: 40
                    
            ).cornerRadius(10)
            .accentColor(.white)
            .background(Color.blue)
            
        }.padding(.horizontal, 10)
        .frame(alignment: .leading)
    }
}

struct SearchBar_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchView(results: { _,_ in
            print("hello")
        })
    }
}
