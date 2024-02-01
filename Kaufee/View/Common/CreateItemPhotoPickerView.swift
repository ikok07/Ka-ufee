//
//  CreateItemPhotoPickerView.swift
//  Kaufee
//
//  Created by Kaloyan Petkov on 1.02.24.
//

import SwiftUI
import PhotosUI

struct CreateItemPhotoPickerView: View {
    
    @State private var pickerItem: PhotosPickerItem?
    
    let emptyResultText: String
    let geometry: GeometryProxy?
    
    @Binding var image: Image?
    
    var body: some View {
        VStack {
            if let image = self.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: (self.geometry?.size.width ?? 30) - 30,
                        height: 200
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                CreateItemEmptyImageFieldView(text: self.emptyResultText)
            }
        }
        .frame(height: 200)
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .overlay {
            PhotosPicker("", selection: $pickerItem, matching: .images)
        }
        .onChange(of: self.pickerItem) { _, newItem in
            Task {
                if let loadedImage = try? await newItem?.loadTransferable(type: Image.self) {
                    self.image = loadedImage
                }
            }
        }

    }
}

#Preview {
    CreateItemPhotoPickerView(emptyResultText: "Click to upload image\nof your business", geometry: nil, image: .constant(nil))
}
