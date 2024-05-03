//
//  ImagePicker.swift
//  crudHTTP
//
//  Created by Enrique Sarmiento on 3/5/24.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
   

   
   @Binding var image: UIImage?
   
   //this function creates the vuiController (UIKit) that show the images
   func makeUIViewController(context: Context) -> some PHPickerViewController {
      var config = PHPickerConfiguration()
      //with this filter we filter the type of images of liveImages, norma images, videos and so on.
      config.filter = .images
      
      let picker = PHPickerViewController(configuration: config)
      picker.delegate = context.coordinator
      return picker
   }
   
   func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
      
   }
   
   func makeCoordinator() -> Coordinator {
      Coordinator(conexion: self)
   }
   

}

class Coordinator: NSObject, PHPickerViewControllerDelegate {
   let conexion: ImagePicker
   
   init(conexion: ImagePicker) {
      self.conexion = conexion
   }
   
   func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      picker.dismiss(animated: true, completion: nil)
      
      guard let provider = results.first?.itemProvider else {return}
      
      // here we take the image from the gallery.
      if provider.canLoadObject(ofClass: UIImage.self){
         provider.loadObject(ofClass: UIImage.self) { image, _ in
            self.conexion.image = image as? UIImage
         }
      }
   }
}
