//
//  Crud.swift
//  crudHTTP
//
//  Created by Enrique Sarmiento on 1/5/24.
//

import Foundation
import Alamofire
import SwiftUI

class Crud: ObservableObject {
   @Published var mensaje: String = ""
   @Published var show: Bool = false
   @Published var posts: [Post] = [Post]()
   
   func save(titulo: String, contenido: String){
      let parametros: Parameters = [
         "titulo":titulo,
         "contenido":contenido
      ]
      
      guard let url = URL(string: "http://localhost/proyecto/crud/save.php") else {return}
      
      DispatchQueue.main.async {
         // here we use alamofire (juts like axios) to create de request post to our endpoint
         AF.request(url, method: .post, parameters: parametros).responseData { response in
            switch response.result {
               // in case of everything is fine
            case .success(let data):
               // we take the response and parsed as a Json object
               do {
                  let json = try JSONSerialization.jsonObject(with: data)
                  let resultJson = json as! NSDictionary
                  
                  // here we extract the value of the json object we transformed
                  guard let res = resultJson.value(forKey: "respuesta") else {return}
                  
                  print("DEBUG: la respuesta de la api aqui ", res)
                  
                  if res as! String == "success" {
                     self.mensaje = "Post guardado con exito"
                     self.show = true
                  }else{
                     self.mensaje = "Hubo un error, intentalo mas tarde"
                     self.show = true
                  }
                  
               } catch let error as NSError {
                  print("DEBUG: el error catch ====>", error.localizedDescription)
                  self.mensaje = "Hubo un error, intentalo mas tarde"
                  self.show = true
               }
               
            case .failure(let error):
               print("DEBUG: el error failure ====>", error.localizedDescription)
               self.mensaje = "Hubo un error, intentalo mas tarde"
               self.show = true
               break
               
            }
         }
      }
   }
   
   func save2(titulo: String, contenido: String, image: UIImage){
      let parametros: Parameters = [
         "titulo":titulo,
         "contenido":contenido,
      ]
      
      guard let url = URL(string: "http://localhost/proyecto/crud/save.php") else {return}
      
      guard let imageData = image.pngData() else {return}
      let nombreImage = UUID().uuidString
      
      DispatchQueue.main.async {
         AF.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(imageData, withName: "image", fileName: "\(nombreImage).png", mimeType: "image/png")
            
            for(key, val) in parametros {
               MultipartFormData.append((val as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
            
         }, to: url, method: .post).uploadProgress{ Progress in
            print("DEBUG: EL PRGRESS", Progress.fractionCompleted*100)
            
         }.response{ response in
            self.mensaje = "Post guardado con exito"
            self.show = true
         }
      }
      
   }
   
   func getData () {
      AF.request("http://localhost/proyecto/crud/select.php")
         .responseData { response in
            switch response.result {
            case .success(let data):
               do {
                  let json = try JSONDecoder().decode([Post].self, from: data)
                  DispatchQueue.main.async{
                     print("DEBUG: el json", json)
                     self.posts = json
                  }
               } catch let error as NSError {
                  print("DEBUG: error al mostrar el json", error.localizedDescription)
               }
               
            case .failure(let error):
               print("debug: HUBO UN ERROR", error.localizedDescription)
            }
         }
   }
   
   func delete(id: String, nombre_imagen: String){
      let parametros: Parameters = [
         "id":id,
         "nombre_imagen":nombre_imagen
      ]
      
      guard let url = URL(string: "http://localhost/proyecto/crud/delete.php") else {return}
      
      DispatchQueue.main.async {
         // here we use alamofire (juts like axios) to create de request post to our endpoint
         AF.request(url, method: .post, parameters: parametros).responseData { response in
            switch response.result {
               // in case of everything is fine
            case .success(let data):
               // we take the response and parsed as a Json object
               do {
                  let json = try JSONSerialization.jsonObject(with: data)
                  let resultJson = json as! NSDictionary
                  
                  // here we extract the value of the json object we transformed
                  guard let res = resultJson.value(forKey: "respuesta") else {return}
                  
                  print("DEBUG: la respuesta de la api aqui ", res)
                  
                  if res as! String == "success" {
                     self.mensaje = "Post eliminado con exito"
                     self.show = true
                  }else{
                     self.mensaje = "Hubo un error, intentalo mas tarde"
                     self.show = true
                  }
                  
               } catch let error as NSError {
                  print("DEBUG: el error catch ====>", error.localizedDescription)
                  self.mensaje = "Hubo un error, intentalo mas tarde"
                  self.show = true
               }
               
            case .failure(let error):
               print("DEBUG: el error failure ====>", error.localizedDescription)
               self.mensaje = "Hubo un error, intentalo mas tarde"
               self.show = true
               break
               
            }
         }
      }
   }
}
