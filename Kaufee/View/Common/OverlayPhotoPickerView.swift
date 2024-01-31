//
//  OverlayPhotoPickerView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 30.01.24.
//

import SwiftUI
import PhotosUI

struct OverlayPhotoPickerView: View {
    
    @Binding var image: Image?
    let photoUrl: String
    
    @State var photoItem: PhotosPickerItem?
    
    var body: some View {
        PhotosPicker(selection: $photoItem, matching: .images) {
            if let image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 270)
                    .clipped()
            } else {
                OverlayAsyncImageView(photoUrl: self.photoUrl)
            }
        }
        .onChange(of: self.photoItem) { _, newItem in
            Task {
                if let loadedImage = try? await newItem?.loadTransferable(type: Image.self) {
                    self.image = loadedImage
                }
            }
        }
    }
}

#Preview {
    OverlayPhotoPickerView(image: .constant(nil), photoUrl: "https://")
}
