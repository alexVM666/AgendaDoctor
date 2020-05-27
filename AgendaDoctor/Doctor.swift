//
//  Doctor.swift
//  AgendaDoctor
//
//  Created by TecNM on 10/03/20.
//  Copyright © 2020 TecNM. All rights reserved.
//

import Foundation

class Doctor{
    var idoctor : String?
    var nomdoctor : String?
    var especialidad : String?
    var horario : String?
  
    init(idDoctor :String?, nomDoctor : String?, especialidad :String?, horario :String?) {
        self.idoctor = idDoctor
        self.nomdoctor = nomDoctor
        self.especialidad = especialidad
        self.horario = horario
       
    }
}
