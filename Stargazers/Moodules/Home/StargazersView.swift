//
//  ContentView.swift
//  Stargazers
//
//  Created by MacOS on 10/31/20.
//

import SwiftUI

struct StargazersView: View {
        
    @ObservedObject var viewModel: StargazersViewModel
    
    @State private var showSearch = false
    @State var showInputAlert = false
    
    var body: some View {
            
        return ZStack {
                    
            NavigationView {
                
                VStack {
                 
                    if viewModel.showEmptyView {
                    
                        Text("No data, please use the search button for start a new search.")
                            .padding()
                        
                    }else {
                        
                        List(viewModel.stargazers) { stargazer in
                            StargazerCell(stargazer: stargazer)
                                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        }
                    }
                    
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("Stargazers")
                .navigationBarItems(trailing:
                    
                    Button(action: {
                        
                        // show search
                        self.showSearch.toggle()
                        
                    }) {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                )
                
            }.alert(isPresented: $showInputAlert) { () -> Alert in
                
                Alert(title: Text("Missing Input"),
                             message: Text("Please insert Repository Name AND Repository Owner"),
                             dismissButton: .default(Text("Ok")))
            }
            
            if showSearch {
                
                SearchView(results: { result in
                    
                    if let values = result {
                        
                        if values.owner.trimmingCharacters(in: .whitespaces).isEmpty ||
                            values.repository.trimmingCharacters(in: .whitespaces).isEmpty{
                                           
                            self.showInputAlert.toggle()
                            
                        }else{
                            
                            viewModel.getStargazers(owner: values.owner,
                                                    repository: values.repository)
                        }
                    }
                
                    // hide search
                    self.showSearch.toggle()
                    
                }).transition(AnyTransition.opacity
                                .animation(.easeInOut(duration: 0.2)))
                .zIndex(1)
            }
            
        }
    }
}

/*struct StargazersView_Previews: PreviewProvider {
    static var previews: some View {
                
        //StargazersView(viewModel: <#StargazersViewModel#>)
    }
}*/
