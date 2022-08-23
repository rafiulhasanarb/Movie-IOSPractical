//
//  ImageViewModel.swift
//  Movie-IOSPractical
//
//  Created by rafiul hasan on 22/8/22.
//

import Foundation
import SwiftUI

class ImageViewModel: ObservableObject {
    //MARK: Properties
    @Published var image: Image? = nil
    
    //MARK: Methods
    func load(fromURLString urlString: String) {
        NetworkManager.shared.downloadImage(fromURLString: urlString) { uiImage in
            guard let uiImage = uiImage else { return }
            DispatchQueue.main.async {
                self.image = Image(uiImage: uiImage)
            }
        }
    }
}
