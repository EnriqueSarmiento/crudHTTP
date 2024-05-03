//
//  PostView.swift
//  crudHTTP
//
//  Created by Enrique Sarmiento on 1/5/24.
//

import SwiftUI

struct PostView: View {
   
   @StateObject private var crud = Crud()
   @State private var titulo: String = ""
   @State private var contenido: String = ""
   
   @State private var showImagePicker: Bool = false
   @State private var image: Image?
   @State private var inputImage: UIImage?
   
   func loadImage(){
      guard let inputImage = inputImage else {return}
      image = Image(uiImage: inputImage)
   }
   
    var body: some View {
       Form{
          TextField(text: $titulo) {
             Text("Titulo")
          }
          
          TextEditor(text: $contenido)
          
          Button {
             
             if image == nil {
                crud.save(titulo: titulo, contenido: contenido, id: "", editar: false)
             }else{
                crud.save2(titulo: titulo, contenido: contenido, image: inputImage!)
             }
             
             titulo = ""
             contenido = ""
             inputImage = nil
          } label: {
             Text("Guardar")
          }.alert(crud.mensaje,isPresented: $crud.show) {
             Button("Aceptar", role: .none){}
          }
          
          image?.resizable()
             .scaledToFit()

       }.navigationTitle("Crear Post")
          .toolbar{
             Button {
                showImagePicker = true
             } label: {
                Image(systemName: "camera")
             }
          }
          .onChange(of: inputImage) { _  in
             loadImage()
          }.sheet(isPresented: $showImagePicker) {
             ImagePicker(image: $inputImage)
          }
    }
}
