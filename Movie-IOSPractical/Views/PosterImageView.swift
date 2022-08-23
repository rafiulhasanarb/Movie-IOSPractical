//
//  PosterImageView.swift
//  Movie-IOSPractical
//
//  Created by rafiul hasan on 22/8/22.
//

import SwiftUI

struct PosterImageView: View {
    //MARK: Properties
    @StateObject var imageLoader = ImageViewModel()
    let urlString: String
    
    //MARK: Body
    var body: some View {
        PosterImage(image: imageLoader.image)
            .onAppear {
                imageLoader.load(fromURLString: urlString)
            }
    }
}

struct PosterImageView_Previews: PreviewProvider {
    static var previews: some View {
        PosterImageView(urlString: "")
    }
}

struct PosterImage: View {
    //MARK: Properties
    var image: Image?
    
    //MARK: Body
    var body: some View {
        image?.resizable() ?? Image(systemName: "photo").resizable()
    }
}
