import SwiftUI

struct CategoryRow: View {
    var categoryName: String
    var parks: [Park]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(parks) { park in
                        NavigationLink {
                            ParkDetail(park: park)
                        } label: {
                            CategoryItem(park: park)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

#Preview {
    let parks = ModelData().parks
    return CategoryRow(categoryName: parks[8].country, parks: Array(parks.prefix(4)))
}
