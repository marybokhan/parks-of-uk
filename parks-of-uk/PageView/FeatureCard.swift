import SwiftUI

struct FeatureCard: View {
    var park: Park
    
    var body: some View {
        AsyncImage(url: URL(string: park.imageURL)) { image in
            image.resizable()
                .overlay {
                    TextOverlay(park: park)
                }
        } placeholder: {
            Image("park-placeholder").resizable()
        }
    }
}

struct TextOverlay: View {
    var park: Park
    
    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center
        )
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text(park.name)
                    .font(.title)
                    .bold()
                Text(park.country)
            }
            .padding()
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    FeatureCard(park: ModelData.mock.parks[1])
        .aspectRatio(3/2, contentMode: .fit)
}
