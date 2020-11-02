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
            
        UITableView.appearance().separatorStyle = .none
        
        return ZStack {
                    
            NavigationView {
                
                VStack {
                 
                    if viewModel.showEmptyView {
                    
                        Text(LocalizedStringKey("data_not_available"))
                            .padding()
                        
                    }else if viewModel.loading {
                        
                        ActivityIndicator(isAnimating: .constant(true),
                                          color: .constant(UIColor.gray),
                                          style: .large)
                            .frame(alignment: .center)
                        
                    }else {
                        
                        List(viewModel.stargazers) { stargazer in
                            StargazerCell(stargazer: stargazer)
                                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        }.accessibility(identifier: "stargazers_list")
                    }
                    
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle(LocalizedStringKey("app_name"))
                .navigationBarItems(trailing:
                    
                    Button(action: {
                        
                        // show search
                        self.showSearch.toggle()
                        
                    }) {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                        
                    }.accessibility(identifier: "search_bar_button")
                )
                
            }.alert(isPresented: $showInputAlert) { () -> Alert in
                
                Alert(title: Text(LocalizedStringKey("missing_input")),
                             message: Text(LocalizedStringKey("missing_input_text")),
                             dismissButton: .default(Text(LocalizedStringKey("Ok"))))
            }
            
            if showSearch {
                
                SearchView(results: { result in
                    
                    if let values = result {
                        
                        if values.owner.trimmingCharacters(in: .whitespaces).isEmpty ||
                            values.repository.trimmingCharacters(in: .whitespaces).isEmpty{
                                           
                            self.showInputAlert.toggle()
                            
                        }else{
                            
                            self.viewModel.getStargazers(owner: values.owner,
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
