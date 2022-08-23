//
//  MovieCellView.swift
//  Movie-IOSPractical
//
//  Created by rafiul hasan on 22/8/22.
//

import SwiftUI

struct MovieCellView: View {
    //MARK: Properties
    let movie: MovieModel
    
    //MARK: Body
    var body: some View {
        HStack(alignment: .center) {
            PosterImageView(urlString: "\(movie.posterUrl)")
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 180)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.title)
                    .font(.title3)
                
                Text(movie.overview)
                    .font(.caption)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
        }
    }
}

struct MovieCellView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCellView(movie: MockData.sampleMovie)
    }
}
