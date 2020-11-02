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
        
    var results: (SearchResult?) -> Void
 
    var body: some View {
        
        VStack(spacing: 0) {
            
            VStack {
                
                SerachHeader()
                
                SearchOwnerField()
                
                SearchRepositoryField()
            
                SearchButton()
                            
            }
            .padding(.top, 5)
            .padding(.bottom, 10)
            .background(Color.white)
            
            VStack{
                
                Spacer()
                
            }.frame(minWidth: 0,
                       maxWidth: .infinity,
                       minHeight: 0,
                       maxHeight: .infinity)
                .background(Color.gray)
                .opacity(0.8)
            
        }
    }
    
    private func SerachHeader() -> some View {
        
        return HStack {
            
            Text(LocalizedStringKey("search"))
                .font(.system(size: 30))
            
            Spacer()
            
            Button(action: {
                
                self.results(nil)
                                
            }) {
                Text(LocalizedStringKey("close"))
            }
            
        }.padding(.horizontal)
    }
    
    private func SearchOwnerField() -> some View {
        
        return HStack {
            
            TextField(LocalizedStringKey("hint_owner"), text: $owner)
                .accessibility(identifier: "search_owner_text")
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
            
            TextField(LocalizedStringKey("hint_name"), text: $repository)
                .accessibility(identifier: "search_repository_text")
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
                
                let searchResult = SearchResult(owner: self.owner,
                                                repository: self.repository);
                
                self.results(searchResult)
                
            }) {
                
                Text(LocalizedStringKey("search"))
            
            }.frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: 40
                    
            ).cornerRadius(10)
            .accentColor(.white)
            .background(Color.blue)
            .accessibility(identifier: "search_search_button")
            
        }.padding(.horizontal, 10)
    }
}

struct SearchBar_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchView(results: { _ in
            print("hello")
        })
    }
}
