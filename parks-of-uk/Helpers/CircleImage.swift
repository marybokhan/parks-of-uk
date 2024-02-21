//
//  CircleImage.swift
//  parks-of-uk
//
//  Created by Mary Cherkas on 21/02/2024.
//

import SwiftUI

struct CircleImage: View {
    var image = Image("broads")
    
    var body: some View {
        image
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

#Preview {
    CircleImage(image: Image("broads"))
}
