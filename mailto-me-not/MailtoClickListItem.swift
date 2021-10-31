
import SwiftUI

struct MailtoClickListItem: View {
    let mailtoClick: MailtoClick
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.flatDarkCardBackground
            // 1
            VStack(alignment: .leading) {

                Label(mailtoClick.getEmail(), systemImage: "envelope.fill")
                    .padding(.bottom, 3)
                    .font(.headline)
                    .accentColor(Color.white)
                
                if (mailtoClick.getCC().isEmpty == false) {
                    Text("CC: " + mailtoClick.getCC())
                        .padding(.bottom, 3)
                        .font(.subheadline)
                        .foregroundColor(Color.secondary)
                }
                
                if (mailtoClick.getBCC().isEmpty == false) {
                    Text("BCC: " + mailtoClick.getBCC())
                        .padding(.bottom, 3)
                        .font(.subheadline)
                        .foregroundColor(Color.secondary)
                }
                
                if (mailtoClick.getSubject().isEmpty == false) {
                    Divider()
                    
                    Text(mailtoClick.getSubject())
                        .padding(.bottom, 3)
                        .font(.subheadline)
                        .foregroundColor(Color.secondary)
                }
                
                if (mailtoClick.getBody().isEmpty == false) {
                    Divider()
                    
                    Text(mailtoClick.getBody())
                        .font(.body)
                        .foregroundColor(Color.secondary)
                }
                
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
