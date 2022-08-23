//
//  MovieListView.swift
//  Movie-IOSPractical
//
//  Created by rafiul hasan on 22/8/22.
//

import SwiftUI

struct MovieListView: View {
    //MARK: Properties
    @StateObject var viewModel = MovieListViewModel()
    @State private var searchText: String = ""
    
    //MARK: Body
    var body: some View {
        NavigationView {
            List(viewModel.movies, id: \.self) { movie in
                MovieCellView(movie: movie)
                    .listRowInsets(EdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4))
            }
            .navigationTitle("Movie List")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Search for Movie")
            .onChange(of: searchText) { newValue in
                if !newValue.isEmpty && newValue.count > 2 {
                    print(newValue)
                    viewModel.fetchMovieData(urlEndpoint: newValue)
                }
            }
        }.onAppear {
            viewModel.fetchMovieData(urlEndpoint: "marvel")//getMovies()
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
