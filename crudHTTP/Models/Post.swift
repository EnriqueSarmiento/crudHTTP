//
//  Post.swift
//  crudHTTP
//
//  Created by Enrique Sarmiento on 1/5/24.
//

import Foundation

struct Post: Codable {
   let id: String
   let titulo: String
   let contenido: String
   let imagen: String
   let nombre_imagen: String
}
