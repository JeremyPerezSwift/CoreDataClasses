//
//  MovieDetail.swift
//  CoreDataClasses
//
//  Created by Jérémy Perez on 28/12/2021.
//

import SwiftUI

struct MovieDetail: View {
    let movie: Movie
    @State private var movieName: String = ""
    let coreDM: CoreDataManager
    @Binding var needsRefresh: Bool
    
    var body: some View {
        VStack {
            HStack {
                TextField(movie.title ?? "", text: $movieName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button {
                    if movieName != "" {
                        movie.title = movieName
                        coreDM.updateMovie()
                        movieName = ""
                        needsRefresh.toggle()
                    }
                } label: {
                    Text("Update")
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

//struct MovieDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetail()
//    }
//}
