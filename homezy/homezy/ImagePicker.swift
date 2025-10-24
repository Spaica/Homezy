//
//  ImagePicker.swift
//  homezy
//
//  Created by Andreina Costagliola on 20/10/25.
//

import SwiftUI

//image selector
struct ImagePicker: UIViewControllerRepresentable {
    //binding with the selected image
    @Binding var selectedImage: UIImage?
    //source of the image
    var sourceType: UIImagePickerController.SourceType
    //used to close the modal of the image selection once the selection is made
    @Environment(\.presentationMode) private var presentationMode

    //to manage the image selector: the image can't be edited and
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController() //create the selector object
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator //coordinated the selection
        return imagePicker //returns the controller
    }

    //update after changes
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    //coordinator constructor
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    //the class is a child of nsobject etc
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        //reference of the variable of the parent
        var parent: ImagePicker
        
        //costructor
        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
