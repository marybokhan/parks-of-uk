import SwiftUI

struct ParkRow: View {
    var park: Park
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: park.imageURL)) { image in
                image.resizable()
            } placeholder: {
                Image("park-placeholder").resizable()
            }
            .frame(width: 50, height: 50)
            
            Text(park.name)
            
            Spacer()
            
            if park.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
            }
        }
    }
}

#Preview {
    ParkRow(park: ModelData.mock.parks[0])
}
