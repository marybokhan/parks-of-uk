import SwiftUI

struct ParkDetail: View {
    @Environment(ModelData.self) var modelData
    var park: Park
    
    var parkIndex: Int {
        modelData.parks.firstIndex(where: { $0.id == park.id })!
    }
    
    var body: some View {
        @Bindable var modelData = modelData
        
        ScrollView {
            MapView(cooordinate: park.locationCoordinate)
                .frame(height: 300)
            
            AsyncImage(url: URL(string: park.imageURL)) { image in
                CircleImage(image: image)
            } placeholder: {
                CircleImage(image: Image("park-placeholder"))
            }
            .offset(y: -120)
            .padding(.bottom, -100)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(park.name)
                        .font(.title)
                    FavoriteButton(isSet: $modelData.parks[parkIndex].isFavorite)
                }
                
                Text(park.country)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Divider()
                
                Text("About")
                    .bold()
                Text(park.description)
                    .padding(.bottom, 5)
                Text("Key Activities")
                    .bold()
                Text(park.keyActivities)
                    .padding(.bottom, 5)
                
                HStack {
                    Image(systemName: "link")
                        .foregroundStyle(.blue)
                    
                    let website = "\(park.website)".replacingOccurrences(of: "https://www.", with: "")
                    Link(website, destination: URL(string: park.website)!)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ParkDetail(park: ModelData.mock.parks[1])
        .environment(ModelData())
}
