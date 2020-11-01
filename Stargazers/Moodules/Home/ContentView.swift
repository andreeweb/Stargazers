//
//  ContentView.swift
//  Stargazers
//
//  Created by MacOS on 10/31/20.
//

import SwiftUI

struct ContentView: View {
        
    @State private var showSearch = false
    
    var objects: [Int]

    var body: some View {
    
        return ZStack {
                    
            NavigationView {
                
                VStack {
                    
                    List(objects, id: \.self) { obj in
                        Text("\(obj)")
                    }.listStyle(PlainListStyle())
                    
                }.navigationBarTitle("Stargazers")
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
            }
            
            if showSearch {
                
                SearchView(results: { owner, repository in
                                     
                    print(owner)
                    print(repository)
                    
                    // hide search
                    self.showSearch.toggle()
                    
                }).transition(AnyTransition.opacity
                                .animation(.easeInOut(duration: 0.2)))
                .zIndex(1)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(objects: [1,2,3,4])
    }
}
