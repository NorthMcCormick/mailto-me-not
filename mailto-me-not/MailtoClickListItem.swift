
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
            }
            .padding(10)
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
