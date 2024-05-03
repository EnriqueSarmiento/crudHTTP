//
//  DetailView.swift
//  crudHTTP
//
//  Created by Enrique Sarmiento on 1/5/24.
//

import SwiftUI

struct DetailView: View {
   
   var crudItem: Post
   @StateObject var crud = Crud()
   
    var body: some View {
       VStack{
          CeldaView(titulo:"", contenido: crudItem.contenido, image: crudItem.imagen)
          HStack {
             Button {
                <#code#>
             } label: {
                Text("Editar")
             }.buttonStyle(BorderedButtonStyle())

             Button {
                crud.delete(id: crudItem.id, nombre_imagen: crudItem.nombre_imagen)
             } label: {
                Text("Eliminar")
             }.buttonStyle(BorderedButtonStyle()).tint(.red)
          }
          Spacer()
       }.padding(.all)
          .navigationTitle(crudItem.titulo)
          .alert(crud.mensaje,isPresented: $crud.show) {
             Button("Aceptar", role: .none){}
          }
    }
}
