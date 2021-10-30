
import SwiftUI

// swiftlint:disable multiple_closures_with_trailing_closure
struct MailtoClickList: View {
    @FetchRequest(
      // 2
      entity: MailtoClick.entity(),
      // 3
      sortDescriptors: [
        NSSortDescriptor(keyPath: \MailtoClick.created, ascending: false)
      ]
    // 4
    ) var items: FetchedResults<MailtoClick>
    
    @Environment(\.managedObjectContext) var context
    
  /*@State var movies = MovieList.makeMovieDefaults()
  @State var isPresented = false*/


    var body: some View {
        VStack {
            List {
                ForEach(items) { item in
                    MailtoClickListItem(mailtoClick: item)
                        .contextMenu {
                            Button {
                                print("Change country setting")
                            } label: {
                                Label("Copy Email", systemImage: "globe")
                            }
                            
                            
                            Button {
                                print("Enable geolocation")
                            } label: {
                                Label("Detect Location", systemImage: "location.circle")
                            }
                        }
                }
              // .onDelete(perform: deleteMovie)
            }
        }
    }
    
    func saveContext() {
      do {
        print("Saving saved");
        try context.save()
        print("Context saved");
      } catch {
        print("Error saving managed object context: \(error)")
      }
    }

  /*func deleteMovie(at offsets: IndexSet) {
    movies.remove(atOffsets: offsets)
  }

  func addMovie(title: String, genre: String, releaseDate: Date) {
    let newMovie = Movie(title: title, genre: genre, releaseDate: releaseDate)
    movies.append(newMovie)
  }*/
}

