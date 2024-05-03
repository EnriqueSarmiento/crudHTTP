//
//  Crud.swift
//  crudHTTP
//
//  Created by Enrique Sarmiento on 1/5/24.
//

import Foundation
import Alamofire

class Crud: ObservableObject {
   @Published var mensaje: String = ""
   @Published var show: Bool = false
   
   func save(titulo: String, contenido: String){
      let parametros: Parameters = [
         "titulo":titulo,
         "contenido":contenido
      ]
      
      guard let url = URL(string: "http://localhost/proyecto/crud.save.php") else {return}
      
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
}
