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
             
                Text(stargazer.repositoryOwner)
                    .font(.title)
                    .foregroundColor(Color.white)
                    .padding(.leading, 10)
                
                Text(stargazer.repositoryName)
                    .font(.subheadline)
                    .foregroundColor(Color.white)
                    .padding(.leading, 15)
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
        
        let owner = "Hello!"
        let image = #imageLiteral(resourceName: "avatar-placeholder")
        let repository = "Repository"
        
        let stargazer = Stargazer(repositoryName: repository,
                                  repositoryOwner: owner,
                                  image: image,
                                  isLoadingImage: false)
        
        StargazerCell(stargazer: stargazer)
    }
}
