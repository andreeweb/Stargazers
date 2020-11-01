//
//  StargazerCell.swift
//  Stargazers
//
//  Created by MacOS on 11/1/20.
//

import SwiftUI

struct StargazerCell: View {
    
    let stargazer: Stargazer
    
    var body: some View {
        
        HStack {
                                    
            Image(uiImage: stargazer.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70, alignment: .center)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 5))
                .padding(.leading, 20)
            
            VStack {
             
                Text(stargazer.name)
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .padding(.leading, 10)
            }
            
        }.frame(minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: 100.0,
                alignment: .leading)
        .padding(.bottom, 5)
        .background(Color.random)

    }
}

struct StargazerCell_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let name = "baiyunping333"
        let image = #imageLiteral(resourceName: "avatar-placeholder")
        
        let stargazer = Stargazer(name: name,
                                  image: image,
                                  isLoadingImage: false)
        
        StargazerCell(stargazer: stargazer)
    }
}
