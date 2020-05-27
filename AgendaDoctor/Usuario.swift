//
//  Usuario.swift
//  AgendaDoctor
//
//  Created by TecNM on 10/03/20.
//  Copyright © 2020 TecNM. All rights reserved.
//

import Foundation

class Usuario{
    var idusuario : String?
    var correo : String?
    var contrasena : String?
    var tipousr : String?
   
    init(idUsuario :String?, correo : String?, contrasena :String?,
         tipoUsr:String?) {
        self.idusuario = idUsuario
        self.correo = correo
        self.contrasena = contrasena
        self.tipousr = tipoUsr
    }
}
