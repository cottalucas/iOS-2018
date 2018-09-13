//
//  ViewController.swift
//  which-flower-app
//
//  Created by Lucas Cotta on 9/6/18.
//  Copyright © 2018 Lucas Cotta. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Variables
    let imagePicker = UIImagePickerController()
    var wikipediaURL = "https://en.wikipedia.org/w/api.php"
    
    //MARK: IBOutlets
    

    @IBOutlet weak var UIImageViewFromCamera: UIImageView!
    @IBOutlet weak var UIImageViewFromWikipedia: UIImageView!
    @IBOutlet weak var flowerDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Camera methods
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imageFromCamera = info[UIImagePickerControllerEditedImage] as? UIImage {
            UIImageViewFromCamera.image = imageFromCamera
        
            //Convert UIImage to CIImage
            guard let ciImage = CIImage(image: imageFromCamera) else {
                fatalError("Error converting image to ciImage format")
            }
            
            //Predict
            detect(image: ciImage)
            
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    @IBAction func cameraButtonTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: ML Prediction
    func detect(image: CIImage){
        // Instatiate method inside a container
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            fatalError("Error creating model")
        }
        
        //Request
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let classification = request.results?.first as? VNClassificationObservation else {
                fatalError("Error classifying image")
            }
            
            self.getWikipediaData(searchExpression: classification.identifier)
        }
        
        //Request handler
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            fatalError("Error handling request: \(error)")
        }
    }
    
    //MARK: Wikipedia Parser
    func getWikipediaData(searchExpression: String){
        //Parameters
        let wikipediaAPIParam : [String: String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts|pageimages",
            "exintro" : "",
            "explaintext" : "",
            "titles" : searchExpression,
            "indexpageids" : "",
            "redirects" : "1",
            "pithumbsize": "500"
            
        ]
        
        //Fetch data
        Alamofire.request(wikipediaURL, method: .get, parameters: wikipediaAPIParam).responseJSON { (response) in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                
                let id = json["query"]["pageids"][0].stringValue
                let title = json["query"]["pages"][id]["title"].stringValue
                let description = json["query"]["pages"][id]["extract"].stringValue
                
                self.flowerDescription.text = title + "\n" +  description
                
                let wikipediaImageURL = json["query"]["pages"][id]["thumbnail"]["source"].stringValue
                
                self.UIImageViewFromWikipedia.sd_setImage(with: URL(string: wikipediaImageURL))
            }
        }
    }
}

