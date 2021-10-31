
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
                                let pasteboard = NSPasteboard.general
                                
                                pasteboard.declareTypes([.string], owner: nil)
                                pasteboard.setString(item.getEmail(), forType: .string)
                            } label: {
                                Label("Copy Email Address", systemImage: "none")
                            }
                            
                            Button {
                                let pasteboard = NSPasteboard.general
                                
                                pasteboard.declareTypes([.string], owner: nil)
                                pasteboard.setString(item.getCC(), forType: .string)
                            } label: {
                                Label("Copy CC", systemImage: "none")
                            }
                            
                            Button {
                                let pasteboard = NSPasteboard.general
                                
                                pasteboard.declareTypes([.string], owner: nil)
                                pasteboard.setString(item.getBCC(), forType: .string)
                            } label: {
                                Label("Copy BCC", systemImage: "none")
                            }
                            
                            Button {
                                let pasteboard = NSPasteboard.general
                                
                                pasteboard.declareTypes([.string], owner: nil)
                                pasteboard.setString(item.getSubject(), forType: .string)
                            } label: {
                                Label("Copy Subject", systemImage: "none")
                            }
                            
                            Button {
                                let pasteboard = NSPasteboard.general
                                
                                pasteboard.declareTypes([.string], owner: nil)
                                pasteboard.setString(item.getBody(), forType: .string)
                            } label: {
                                Label("Copy Body", systemImage: "none")
                            }
                            
                            Divider()
                            
                            Button {
                                context.delete(item)
                                
                                do {
                                  // 3
                                  try context.save()
                                    print("saved context");
                                } catch {
                                  // 4
                                  // The c1ontext couldn't be saved.
                                  // You should add your own error handling here.
                                  let nserror = error as NSError
                                  fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                                }
                            } label: {
                                Label("Delete", systemImage: "none")
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

