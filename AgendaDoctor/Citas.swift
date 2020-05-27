//
//  Citas.swift
//  AgendaDoctor
//
//  Created by TecNM on 06/03/20.
//  Copyright © 2020 TecNM. All rights reserved.
//

import Foundation

class Citas{
    var idcita : String?
    var fecha : String?
    var estatura : String?
    var peso : String?
    var presion : String?
    var asunto : String?
    var idpac : String?
    var iddoc : String?
    var nompac : String?
    
    
    init(idCitas :String?, fecha : String?, estatura :String?, peso: String?, presionArt: String?,asunto: String?,
         idPaciente: String?, idDoctor: String?, nomPaciente: String?) {
        self.idcita = idCitas
        self.fecha = fecha
        self.estatura = estatura
        self.peso = peso
        self.presion = presionArt
        self.asunto = asunto
        self.idpac = idPaciente
        self.iddoc = idDoctor
        self.nompac = nomPaciente
    }
}
