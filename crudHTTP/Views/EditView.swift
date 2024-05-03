//
//  EditView.swift
//  crudHTTP
//
//  Created by Enrique Sarmiento on 1/5/24.
//

import SwiftUI

struct EditView: View {
   var crudItem: Post
   
   @State private var titulo: String = ""
   @State private var contenido: String = ""
   @StateObject private var crud = Crud()
   
    var body: some View {
       Form{
          TextField("Titulo", text: $titulo)
             .onAppear{
                titulo = crudItem.titulo
             }
         
          TextEditor(text: $contenido)
             .onAppear{
                contenido = crudItem.contenido
             }
          
          Button {
             crud.save(titulo: titulo, contenido: contenido, id: crudItem.id, editar: true)
          } label: {
             Text("Editar Post")
          }

       }
    }
}
