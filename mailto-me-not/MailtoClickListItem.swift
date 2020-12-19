
import SwiftUI

struct MailtoClickListItem: View {
    let mailtoClick: MailtoClick
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.flatDarkCardBackground
            // 1
            VStack(alignment: .leading) {
                Text(mailtoClick.url ?? "")
                    .padding(.bottom, 5)
                
                /*Text(address)
                    .padding(.bottom, 5)
                
                HStack(alignment: .center) {
                    Image(systemName: "mappin")
                    Text(city)
                }
                .padding(.bottom, 5)
                
                HStack {
                    ForEach(categories, id: \.self) { category in
                        CategoryPill(categoryName: category)
                    }
                }*/
                
            }
            .padding(10)
            
            /*HStack {
              Text(movie.genre)
                .font(.caption)
              Spacer()
              Text(Self.releaseFormatter.string(from: movie.releaseDate))
                .font(.caption)*/
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
