//
//  Paciente.swift
//  AgendaDoctor
//
//  Created by TecNM on 10/03/20.
//  Copyright © 2020 TecNM. All rights reserved.
//

import Foundation

class Paciente{
    var idpaciente : String?
    var nompaciente : String?
    var dompaciente : String?
    var correo : String?
    var tiposangre : String?
    var fechanac : String?
    
    
    init(idPaciente :String?, nomPaciente : String?, domPaciente :String?,
         correo :String?, tipoSangre :String?, fechaNac :String?) {
        self.idpaciente = idPaciente
        self.nompaciente = nomPaciente
        self.dompaciente = domPaciente
        self.correo = correo
        self.tiposangre = tipoSangre
        self.fechanac = fechaNac
     
    }
}
