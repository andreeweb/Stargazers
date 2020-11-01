//
//  ContentView.swift
//  Stargazers
//
//  Created by MacOS on 10/31/20.
//

import SwiftUI

struct ContentView: View {
        
    @State private var showSearch = false
    
    @State var showInputAlert = false
    
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
                
            }.alert(isPresented: $showInputAlert) { () -> Alert in
                
                Alert(title: Text("Missing Input"),
                             message: Text("Please insert Repository Name AND Repository Owner"),
                             dismissButton: .default(Text("Ok")))
            }
            
            if showSearch {
                
                SearchView(results: { result in
                    
                    if result.owner.trimmingCharacters(in: .whitespaces).isEmpty ||
                        result.repository.trimmingCharacters(in: .whitespaces).isEmpty{
                                       
                        self.showInputAlert.toggle()
                        
                    }else{
                        
                        // view model request data
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(objects: [1,2,3,4])
    }
}
