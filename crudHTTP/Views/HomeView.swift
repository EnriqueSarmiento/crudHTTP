//
//  HomeView.swift
//  crudHTTP
//
//  Created by Enrique Sarmiento on 1/5/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
       NavigationView{
          Text("Hola")
             .toolbar{
                NavigationLink(destination: PostView()){
                   Image(systemName: "plus")
                }
             }
       }
    }
}
