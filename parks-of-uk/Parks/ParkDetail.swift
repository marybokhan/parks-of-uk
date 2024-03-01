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
                    .offset(y: -120)
                    .padding(.bottom, -100)
            } placeholder: {
                let placeholder = Image("park-placeholder")
                CircleImage(image: placeholder)
                    .offset(y: -120)
                    .padding(.bottom, -100)
            }
            
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
                Link("Visit park's website", destination: URL(string: park.website)!)
            }
            .padding()
        }
    }
}

#Preview {
    let modelData = ModelData()
    return ParkDetail(park: modelData.parks[12])
        .environment(modelData)
}
