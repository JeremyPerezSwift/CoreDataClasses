//
//  CoreDataManager.swift
//  CoreDataClasses
//
//  Created by Jérémy Perez on 28/12/2021.
//

import CoreData

class CoreDataManager: ObservableObject {
    
    let persistentContainer: NSPersistentContainer
    @Published var movies: [Movie] = [Movie]()
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("DEBUG: CoreData store failed to initialise \(error.localizedDescription)")
            }
        }
        
        getAllMovies()
    }
    
    func saveMovie(title: String) {
        let movie = Movie(context: persistentContainer.viewContext)
        movie.title = title
        
        do {
            try persistentContainer.viewContext.save()
            print("DEBUG: Movie saved")
        } catch {
            print("DEBUG: Movie failed to save \(error)")
        }
    }
    
    func getAllMovies() {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do {
            movies = try persistentContainer.viewContext.fetch(fetchRequest)
            print("DEBUG: Movie fetch \(movies)")
        } catch {
            print("DEBUG: Movie failed to fetch \(error)")
        }
    }
    
//    func getAllMovies() -> [Movie] {
//        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
//
//        do {
//            return try persistentContainer.viewContext.fetch(fetchRequest)
//        } catch {
//            return []
//        }
//    }
    
    func updateMovie() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
    }
    
    func deleteMovie(movie: Movie) {
        persistentContainer.viewContext.delete(movie)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("DEBUG: Movie failed to delete \(error)")
        }
    }
    
}
