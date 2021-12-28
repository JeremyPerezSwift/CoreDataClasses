//
//  ContentView.swift
//  CoreDataClasses
//
//  Created by Jérémy Perez on 28/12/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var coreDM: CoreDataManager
    @State private var movieName: String = ""
    @State private var needsRefresh: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter movie name", text: $movieName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button {
                        if movieName != "" {
                            coreDM.saveMovie(title: movieName)
                            coreDM.getAllMovies()
                            movieName = ""
                        }
                    } label: {
                        Text("Save")
                    }
                }
                
                List {
                    ForEach(coreDM.movies, id: \.self) { movie in
                        NavigationLink(destination: MovieDetail(movie: movie, coreDM: coreDM, needsRefresh: $needsRefresh)) {
                            Text(movie.title ?? "")
                                .foregroundColor(.black)
                        }
                        
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let movie = coreDM.movies[index]
                            coreDM.deleteMovie(movie: movie)
                            coreDM.getAllMovies()
                        }
                    }
                }
                .cornerRadius(10)
                .accentColor(needsRefresh ? .white : .black)
                
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
//            navigationTitle("Movies")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coreDM: CoreDataManager())
    }
}
