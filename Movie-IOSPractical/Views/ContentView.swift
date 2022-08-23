//
//  ContentView.swift
//  Movie-IOSPractical
//
//  Created by rafiul hasan on 22/8/22.
//

import SwiftUI

struct ContentView: View {
    //MARK: Properties
    @StateObject var viewModel = MovieListViewModel()
    
    //MARK: Body
    var body: some View {
        MovieListView(viewModel: viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
