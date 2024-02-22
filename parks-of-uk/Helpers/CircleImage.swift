//
//  CircleImage.swift
//  parks-of-uk
//
//  Created by Mary Cherkas on 21/02/2024.
//

import SwiftUI

struct CircleImage: View {
    var image: Image?
    
    var body: some View {
        if let parkImage = image {
            parkImage
                .resizable()
                .scaledToFill()
                .frame(width: 230, height: 230)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .shadow(radius: 7)
        }
    }
}

#Preview {
    CircleImage(image: Image("park-placeholder"))
}
