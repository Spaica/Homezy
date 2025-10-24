import SwiftUI
import CoreML
import Vision
import ImageIO

class ImageClassifier {
    
    //List of error types
    enum ClassificationError: Error {
        case modelLoadingFailed(String)
        case imageProcessingFailed(String)
        case classificationFailed(String)
    }
    
    // MARK: - Model VNCoreMLModel
    
    //lazy means that the variable will not be initialized until it's accessed, so it's better for the performances
    //also this var is for creating a request to the AI model
    private lazy var classificationRequest: VNCoreMLRequest? = {
        //do-catch construct to handle bugs
        do {
            //constant used to create a configuration for the model, default configuration
            let configuration = MLModelConfiguration() //costructor for configuration
            
            //constant used to create the generic model using the configuration created before
            let coreMLModel = try MyImageClassifier(configuration: configuration).model //costructor for model
            //try is there because we know that all the excpetions raised will be handled in the catch, try is used with the do-catch construct
            
            //create the vision model from the coremlmodel, where coreml is for all the ai usage, and vision is the specific use of this framework for dealing with images
            let model = try VNCoreMLModel(for: coreMLModel) //constructor for VNCoreMLMOdel (vision), the for represents the model's expected type
            
            //creates the object request using the vision model as a parameter of the constructor
            let request = VNCoreMLRequest(model: model) {
                request, error in //this represents the completion handler: when vision is done with processing the request, these are the parameters that are taken in input for the function between brackets, so it returns the request with the results and the possible error. in this case the function is empty so nothing happens but the constructor must have something as argument
            }
            
            //processes the image because the model can take only a specific dimension image in imput
            request.imageCropAndScaleOption = .centerCrop
            
            //returns the object request which is a request to the vision model
            return request
            
        } catch {
            //if the model loading fails:
            print("⚠️ CRITICAL ERROR: Impossible to load the ML model. The AI analysis will not be available: \(error.localizedDescription)")
            
            return nil
        }
    }()
    
    // MARK: - Classification function
    
    //Creates the actual request
    //UUImage is the object that containes the image data
    //escaping means that the completion will live more than the function
    //the completion takes the result and error in and gives back a void
    //result contains: success and successValue or failure and failureValue
    func classifyImage(_ image: UIImage, completion: @escaping (Result<[String: Float], ClassificationError>) -> Void) {
        
        //convert UIImage to CIImage, because ciimage is better for performances
        //guard is for making an assertion that the else code can be executed only if the creation of the CIImage is nil
        guard let ciImage = CIImage(image: image) else {
            completion(.failure(.imageProcessingFailed("Impossible to create CIImage from UIImage."))) //invokes the completion handler and gives it a result in the case of failure. then throws a specific error
            return //put there because we need a way to escape the function if everything works out and the else code is not executed
        }
        
        //create an handler for the image. The costruction is from the vision framework. The handler takes the data from the CIImage and prepares it for the request, no special option attached
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        //execute the classification request: it uses a dispatcher queue handled from the operating system (global), userinitiated is used for giving priority because the used is waiting for th result. async is for making the thread in the background.
        DispatchQueue.global(qos: .userInitiated).async {
            
            //i can't go on if the modell hasnt been processed before
            guard let classificationRequest = self.classificationRequest else {
                print("ML analysis skipped: model not available")
                return
            }
                
            do {
                //initiate the ml analysis. the arguement is an array of requests but we just have one request
                try handler.perform([classificationRequest])
                
                //extract the results
                //as? VNCLAssificationObservation for the casting, this type contains the identifier and the confidence of the prediction
                guard let observations = classificationRequest.results as? [VNClassificationObservation] else {
                    completion(.failure(.classificationFailed("No calssification result.")))
                    return
                }
                
                //dictionary for result: [Label: Confidence]
                let classifications = observations
                //define an empty container of string and float
                    .reduce(into: [String: Float]()) {
                        //code executed for every item in the dict
                        (dict, observation) in
                        dict[observation.identifier] = observation.confidence //the classification is used as the key of the dict
                    }
                
                completion(.success(classifications)) //send the success to the completion
                
            } catch {
                completion(.failure(.classificationFailed("Error during the execution of the request: \(error.localizedDescription)"))) //sends the failure to the completion
            }
        }
    }
}
