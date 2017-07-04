//
//  Receta.swift
//  RecetasCompleto
//
//  Created by Jorge MR on 18/06/17.
//  Copyright © 2017 Jorge MR. All rights reserved.
//

import Foundation
import UIKit

class Receta : NSObject {
    
    var nombre : String!
    var imagen : UIImage!
    var tiempo : Int!
    var ingredientes : [String]!
    var pasos : [String]!
    var isFavorite : Bool = false
    
    init(nombre : String, imagen : UIImage, tiempo : Int, ingredientes : [String], pasos : [String]){
        self.nombre = nombre
        self.imagen = imagen
        self.tiempo = tiempo
        self.ingredientes = ingredientes
        self.pasos = pasos
    }
    
}
