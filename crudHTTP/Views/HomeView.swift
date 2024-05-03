//
//  HomeView.swift
//  crudHTTP
//
//  Created by Enrique Sarmiento on 1/5/24.
//

import SwiftUI

struct HomeView: View {
   @StateObject private var crud = Crud()
   
   var body: some View {
      NavigationView{
         List{
            ForEach(crud.posts, id: \.id){ item in
               NavigationLink(destination: DetailView(crudItem: item)) {
                  CeldaView(titulo: item.titulo, contenido: item.contenido, image: item.imagen)
               }
            }
         }.navigationTitle("Crud")
            .listStyle(.plain)
            .toolbar{
               NavigationLink(destination: PostView()){
                  Image(systemName: "plus")
               }
            }
            .onAppear{
               crud.getData()
            }
      }
   }
}

struct CeldaView : View {
   
   var titulo: String
   var contenido: String
   var image: String
   
   var body: some View {
      VStack(alignment: .leading){
         Text(titulo)
            .font(.largeTitle).bold()
         AsyncImage(url: URL(string: image)){ image in
            image.resizable().scaledToFit()
         } placeholder: {
            Color.red
         }.clipShape(RoundedRectangle(cornerRadius: 25))
            .shadow(radius: 10)
         Text(contenido).font(.body)
      }
   }
}
