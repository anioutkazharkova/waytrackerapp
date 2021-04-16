//
//  CachedImage.swift
//  WayTrackerApp
//
//  Created by Anna Zharkova on 10.04.2021.
//

import SwiftUI
import SwiftUI

struct CachedImage : View {
    @ObservedObject var imageLoader:ImageLoader = ImageLoader()
    @State var image:UIImage = UIImage()
    private var urlPath: String = ""
    
    init(withURL url:String) {
        self.urlPath = url
    }
    
    var body: some View {
        
        Image(uiImage: imageLoader.image).resizable().onAppear{
            self.imageLoader.loadImage(url: "https://maps.googleapis.com/maps/api/staticmap?size=400x400&path=color:0xff0000ff|weight:5|53.347452, 83.685838 |53.347856, 83.685656|53.347964, 83.685742|53.349226, 83.690624|53.349405, 83.690838|53.350161, 83.691021|53.349322, 83.690742|53.349962, 83.691021|53.350646, 83.691138|53.350888, 83.692631|53.350632, 83.695839|53.350433, 83.697073|53.348563, 83.696687|53.344772, 83.695796|53.343331, 83.695045|53.343875, 83.694906&key=AIzaSyBOmw4NBRo4VkR7SRR1-O1jUejTo26I4rg")
        }
    }
    
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage = UIImage()
    
    private lazy var urlSession: URLSession = {
        return URLSession(configuration: .default)
    }()
    
    private var sessionTask: URLSessionDataTask? = nil
    
    func loadImage(url: String) {
        guard let urlPath = URL(string: url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) ?? "") else {return}
        let request = URLRequest(url: urlPath)
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            self.sessionTask = self.urlSession.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
                guard let self = self else {return}
                if let data = data {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data) ?? UIImage()
                    }
                }
            })
            self.sessionTask?.resume()
        }
        
    }
}
/*
 KFImage(URL(string: "https://maps.googleapis.com/maps/api/staticmap?size=400x400&path=color:0xff0000ff|weight:5|53.347452, 83.685838 |53.347856, 83.685656|53.347964, 83.685742|53.349226, 83.690624|53.349405, 83.690838|53.350161, 83.691021|53.349322, 83.690742|53.349962, 83.691021|53.350646, 83.691138|53.350888, 83.692631|53.350632, 83.695839|53.350433, 83.697073|53.348563, 83.696687|53.344772, 83.695796|53.343331, 83.695045|53.343875, 83.694906&key=AIzaSyBOmw4NBRo4VkR7SRR1-O1jUejTo26I4rg"))
 **/
