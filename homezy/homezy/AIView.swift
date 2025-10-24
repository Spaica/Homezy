//
//  AIView.swift
//  homezy
//
//  Created by Riccardo Puggioni on 15/10/25.
//

import SwiftUI

struct AIView: View {
    // MARK: - PROPERTIES
    let todoItem: ToDo?
    @Binding var popToHome: Bool
    
    @State private var inputImage: UIImage?
    @State private var classificationLabel = "No image selected"
    @State private var showingImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showingPhotoOptions = false
    @State private var showAlert = false
    @State private var hasCompleted = false
    
    private let imageClassifier = ImageClassifier()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                
                // MARK: - TITLE
                Text("Show your results!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 16)
                
                // MARK: - IMAGE DISPLAY
                Group {
                    if let inputImage = inputImage {
                        Image(uiImage: inputImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )
                            .shadow(radius: 4)
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.gray.opacity(0.1))
                                .frame(width: 300, height: 300)
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.system(size: 48))
                                .foregroundColor(.gray)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                
                // MARK: - CLASSIFICATION TEXT
                Text(classificationLabel)
                    .font(.title3)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                
                // MARK: - UPLOAD BUTTON
                Button(action: {
                    showingPhotoOptions = true
                }) {
                    Label("Upload image", systemImage: "camera.fill")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.cyan)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                }
                .padding(.horizontal)
                .confirmationDialog("Choose an option", isPresented: $showingPhotoOptions, titleVisibility: .visible) {
                    Button("Camera") {
                        sourceType = .camera
                        showingImagePicker = true
                    }
                    Button("Photo library") {
                        sourceType = .photoLibrary
                        showingImagePicker = true
                    }
                    Button("Cancel", role: .cancel) {}
                }
                
                // MARK: - COMPLETE CHALLENGE BUTTON
                Button(action: {
                    guard !hasCompleted else { return }
                    
                    if classificationLabel.lowercased().contains("clean") ||
                        classificationLabel.lowercased().contains("pulito") {
                        hasCompleted = true
                        showAlert = true
                    } else {
                        classificationLabel = "The plate doesn't look clean yet 😅"
                    }
                }) {
                    Text(hasCompleted ? "Challenge completed ✅" : "Complete challenge")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(hasCompleted ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                }
                .padding(.horizontal)
                .disabled(hasCompleted)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("🎉 Challenge completed!"),
                        message: Text("Great job! You’ve successfully completed your challenge."),
                        dismissButton: .default(Text("Go to HomePage")) {
                            if let todo = todoItem {
                                ToDoViewModel.shared.complete(todo)
                            }
                            // MARK: - Tell parent to return to HomePage
                            popToHome = true
                        }
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        // MARK: - IMAGE PICKER
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(selectedImage: $inputImage, sourceType: sourceType)
        }
    }
    
    // MARK: - FUNCTIONS
    private func loadImage() {
        guard let inputImage = inputImage else { return }
        classifyImage(image: inputImage)
    }
    
    private func classifyImage(image: UIImage) {
        imageClassifier.classifyImage(image) { result in
            switch result {
            case .success(let classification):
                DispatchQueue.main.async {
                    self.classificationLabel = "Plate: \(classification.first?.key ?? "Not recognized")"
                }
            case .failure:
                DispatchQueue.main.async {
                    self.classificationLabel = "Error during classification"
                }
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    AIView(
        todoItem: ToDo(
            title: "Wash the dishes",
            icon: "fork.knife.circle.fill",
            detail: "Take a picture of your clean dishes to complete the challenge.",
            date: Date(),
            category: .cleaning
        ),
        popToHome: .constant(false)
    )
}
