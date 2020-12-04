
import SwiftUI

struct MailtoClickListItem: View {
    let mailtoClick: MailtoClick
    
    var body: some View {
      VStack(alignment: .leading) {
        // 1
        Text(mailtoClick.url ?? "");
        
        /*HStack {
          Text(movie.genre)
            .font(.caption)
          Spacer()
          Text(Self.releaseFormatter.string(from: movie.releaseDate))
            .font(.caption)*/
        }
      }
    
  /*static let releaseFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
  }()

  var body: some View {
    VStack(alignment: .leading) {
      Text(movie.title)
        .font(.title)
      HStack {
        Text(movie.genre)
          .font(.caption)
        Spacer()
        Text(Self.releaseFormatter.string(from: movie.releaseDate))
          .font(.caption)
      }
    }
  }*/
}
