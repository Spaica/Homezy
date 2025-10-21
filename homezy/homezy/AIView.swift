import SwiftUI

struct AIView: View {
    @State private var inputImage: UIImage?
    @State private var classificationLabel = "No image selected"
    @State private var showingImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showingActionSheet = false

    private let imageClassifier = ImageClassifier()

    var body: some View {
        VStack(spacing: 20) {
            Text("Did you completed the challenge?")
                .font(.largeTitle)
                .fontWeight(.bold)

            if let inputImage = inputImage {
                Image(uiImage: inputImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    .shadow(radius: 5)
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.1))
                        .frame(width: 300, height: 300)
                    
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
            }

            Text(classificationLabel)
                .font(.title2)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(action: {
                self.showingActionSheet = true
            }) {
                HStack {
                    Image(systemName: "camera.fill")
                    Text("Upload image")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(radius: 3)
            }
            .padding(.horizontal)
        }
        .padding()
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(selectedImage: self.$inputImage, sourceType: self.sourceType)
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Choose an option"), buttons: [
                .default(Text("Camera")) {
                    self.sourceType = .camera
                    self.showingImagePicker = true
                },
                .default(Text("Photos library")) {
                    self.sourceType = .photoLibrary
                    self.showingImagePicker = true
                },
                .cancel()
            ])
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        classifyImage(image: inputImage)
    }

    private func classifyImage(image: UIImage) {
        do {
            try self.imageClassifier.classifyImage(image) { result in
                switch result {
                case .success(let classification):
                    DispatchQueue.main.async {
                        // Formatta il risultato per visualizzarlo
                        let formattedResult = classification
                            .map { "\($0.key) (\(String(format: "%.2f", $0.value * 100))%)" }
                            .joined(separator: "\n")
                        self.classificationLabel = "Plate: \(classification.first?.key ?? "Not recognized")"
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.classificationLabel = "Error in the classification"
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.classificationLabel = "Error in the elaborarion"
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    AIView()
}
