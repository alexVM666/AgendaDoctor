//
//  ViewControllerPacientes.swift
//  AgendaDoctor
//
//  Created by alex on 11/05/20.
//  Copyright © 2020 TecNM. All rights reserved.
//

import UIKit
import SQLite3

class ViewControllerPacientes: UIViewController {
    var db : OpaquePointer?
    var doctor = [Doctor]()
    var pacientes = [Paciente]()
    let dataJsonUrlClass = JsonClass()
    
    @IBOutlet weak var txtIdPac: UITextField!
    @IBOutlet weak var lblUsr: UILabel!
    @IBOutlet weak var txtNomPac: UITextField!
    @IBOutlet weak var txtDomPac: UITextField!
    @IBOutlet weak var txtCorreoPac: UITextField!
    @IBOutlet weak var txtTS: UITextField!
    @IBOutlet weak var txtFechNac: UITextField!
    
    @IBOutlet weak var mensajeLabel: UILabel!
    
    @IBAction func btnAgregarPac(_ sender: UIButton) {
        if txtNomPac.text!.isEmpty || txtDomPac.text!.isEmpty || txtCorreoPac.text!.isEmpty || txtTS.text!.isEmpty
        || txtFechNac.text!.isEmpty{
            mostrarAlerta(title: "Faltan datos", message: "Ingresa los Datos Faltantes")
            txtNomPac.becomeFirstResponder()
        }else{
            
            let nom = txtNomPac.text?.trimmingCharacters(in: .whitespacesAndNewlines) as! NSString
            let dom = txtDomPac.text?.trimmingCharacters(in: .whitespacesAndNewlines) as! NSString
            let corr = txtCorreoPac.text?.trimmingCharacters(in: .whitespacesAndNewlines) as! NSString
            let ts = txtTS.text?.trimmingCharacters(in: .whitespacesAndNewlines) as! NSString
            let fechN = txtFechNac.text?.trimmingCharacters(in: .whitespacesAndNewlines) as! NSString
            
            var stmt: OpaquePointer?
            let sentencia = "INSERT INTO paciente(nomPaciente,domPaciente,correo,tipoSangre,fechaNac) VALUES (?,?,?,?,?)"
            
            if sqlite3_prepare(db, sentencia, -1, &stmt, nil) != SQLITE_OK{
                mostrarAlerta(title: "Error", message: "Error al ligar sentencia")
                return
            }
            if sqlite3_bind_text(stmt, 1, nom  .utf8String, -1, nil) != SQLITE_OK{
                mostrarAlerta(title: "Error", message: "Error en el 1er parametro nomPaciente")
                return
            }
            if sqlite3_bind_text(stmt, 2, dom .utf8String, -1, nil) != SQLITE_OK{
                mostrarAlerta(title: "Error", message: "Error en el 2do parametro domPaciente")
                return
            }
            if sqlite3_bind_text(stmt, 3, corr .utf8String, -1, nil) != SQLITE_OK{
                mostrarAlerta(title: "Error", message: "Error en el 3er  parametro correo")
                return
            }
            if sqlite3_bind_text(stmt, 4, ts .utf8String, -1, nil) != SQLITE_OK{
                mostrarAlerta(title: "Error", message: "Error en el 4to  parametro tipoSangre")
                return
            }
            if sqlite3_bind_text(stmt, 5, fechN .utf8String, -1, nil) != SQLITE_OK{
                mostrarAlerta(title: "Error", message: "Error en el 5to  parametro fechaNac")
                return
            }
            if sqlite3_step(stmt) == SQLITE_DONE{
                mostrarAlerta(title: "Guardando", message: "Paciente Guardado en la base de datos")
            }else{
                mostrarAlerta(title: "Error", message: "Paciente no guardado")
            }
            txtNomPac.text = ""
            txtDomPac.text = ""
            txtCorreoPac.text = ""
            txtFechNac.text = ""
            txtTS.text = ""
            txtIdPac.text = ""
        }
    }
    @IBAction func btnActualizarPac(_ sender: UIButton) {
        if  txtIdPac.text!.isEmpty ||  txtNomPac.text!.isEmpty || txtDomPac.text!.isEmpty || txtCorreoPac.text!.isEmpty || txtTS.text!.isEmpty
        || txtFechNac.text!.isEmpty{
            mostrarAlerta(title: "Faltan datos", message: "Ingresa los Datos Faltantes")
            txtIdPac.becomeFirstResponder()
        }else{
            
            let nom = txtNomPac.text?.trimmingCharacters(in: .whitespacesAndNewlines) as! NSString
            let dom = txtDomPac.text?.trimmingCharacters(in: .whitespacesAndNewlines) as! NSString
            let corr = txtCorreoPac.text?.trimmingCharacters(in: .whitespacesAndNewlines) as! NSString
            let ts = txtTS.text?.trimmingCharacters(in: .whitespacesAndNewlines) as! NSString
            let fechN = txtFechNac.text?.trimmingCharacters(in: .whitespacesAndNewlines) as! NSString
            let id = txtIdPac.text?.trimmingCharacters(in: .whitespacesAndNewlines) as! NSString
            
            var stmt: OpaquePointer?
            let sentencia = "UPDATE paciente SET nomPaciente = ?,domPaciente = ?,correo = ?,tipoSangre =?,fechaNac =? Where idPaciente =?"
            
            if sqlite3_prepare(db, sentencia, -1, &stmt, nil) != SQLITE_OK{
                mostrarAlerta(title: "Error", message: "Error al ligar sentencia")
                return
            }
            if sqlite3_bind_text(stmt, 1, nom  .utf8String, -1, nil) != SQLITE_OK{
                mostrarAlerta(title: "Error", message: "Error en el 1er parametro nomPaciente")
                return
            }
            if sqlite3_bind_text(stmt, 2, dom .utf8String, -1, nil) != SQLITE_OK{
                mostrarAlerta(title: "Error", message: "Error en el 2do parametro domPaciente")
                return
            }
            if sqlite3_bind_text(stmt, 3, corr .utf8String, -1, nil) != SQLITE_OK{
                mostrarAlerta(title: "Error", message: "Error en el 3er  parametro correo")
                return
            }
            if sqlite3_bind_text(stmt, 4, ts .utf8String, -1, nil) != SQLITE_OK{
                mostrarAlerta(title: "Error", message: "Error en el 4to  parametro tipoSangre")
                return
            }
            if sqlite3_bind_text(stmt, 5, fechN .utf8String, -1, nil) != SQLITE_OK{
                mostrarAlerta(title: "Error", message: "Error en el 5to  parametro fechaNac")
                return
            }
            if sqlite3_bind_int(stmt, 6, (id as NSString).intValue ) != SQLITE_OK{
                mostrarAlerta(title: "Error", message: "Error en el 6to parametro idPaciente")
                return
            }
            if sqlite3_step(stmt) == SQLITE_DONE{
                mostrarAlerta(title: "Guardando", message: "Paciente Actualizado en la base de datos")
            }else{
                mostrarAlerta(title: "Error", message: "Paciente no Actualizado")
            }
            txtNomPac.text = ""
            txtDomPac.text = ""
            txtCorreoPac.text = ""
            txtFechNac.text = ""
            txtTS.text = ""
            txtIdPac.text = ""
        }
    }
    @IBAction func btnBorrarPac(_ sender: UIButton) {
    if  txtIdPac.text!.isEmpty {
            mostrarAlerta(title: "Faltan datos", message: "Ingresa los Datos Faltantes")
            txtIdPac.becomeFirstResponder()
        }else{
            let id = txtIdPac.text?.trimmingCharacters(in: .whitespacesAndNewlines) as! NSString
            
            var stmt: OpaquePointer?
            let sentencia = "DELETE FROM paciente Where idPaciente =?"
            
            if sqlite3_prepare(db, sentencia, -1, &stmt, nil) != SQLITE_OK{
                mostrarAlerta(title: "Error", message: "Error al ligar sentencia")
                return
            }
            if sqlite3_bind_int(stmt, 1, (id as NSString).intValue ) != SQLITE_OK{
                mostrarAlerta(title: "Error", message: "Error en el parametro idPaciente")
                return
            }
            if sqlite3_step(stmt) == SQLITE_DONE{
                mostrarAlerta(title: "Guardando", message: "Paciente BORRADO en la base de datos")
            }else{
                mostrarAlerta(title: "Error", message: "Paciente no Borrado")
            }
            txtNomPac.text = ""
            txtDomPac.text = ""
            txtCorreoPac.text = ""
            txtFechNac.text = ""
            txtTS.text = ""
            txtIdPac.text = ""
        }
    }
    @IBAction func btnConsultar(_ sender: UIButton) {
        pacientes.removeAll()
        let query = "select * from paciente order by nomPaciente"
        var stmt: OpaquePointer?
        if sqlite3_prepare(db, query, -1, &stmt, nil) != SQLITE_OK{
            let error = String(cString: sqlite3_errmsg(db))
            mostrarAlerta(title: "error", message: "error en la BD : \(error) ")
            return
        }
        while (sqlite3_step (stmt) == SQLITE_ROW) {
            let idP = sqlite3_column_int(stmt, 0) // CeCte
            let nomP = String(cString: sqlite3_column_text(stmt, 1))
            let domP = String(cString: sqlite3_column_text(stmt, 2))
            let cor = String(cString: sqlite3_column_text(stmt, 3))
            let ts = String(cString: sqlite3_column_text(stmt, 4))
            let fech = String(cString: sqlite3_column_text(stmt, 5))
            pacientes.append(Paciente(idPaciente: String(idP), nomPaciente: String(describing: nomP), domPaciente: String(describing: domP), correo: String(describing: cor),tipoSangre: String(describing: ts),fechaNac: String(describing: fech)))
        }
        
        self.performSegue(withIdentifier: "segueListaPac", sender: self)
    }
    
    @IBAction func btnPaciente(_ sender: UIButton) {
        txtNomPac.text=""
        txtCorreoPac.text = ""
        txtDomPac.text = ""
        txtTS.text = ""
        txtFechNac.text = ""
        if  txtIdPac.text!.isEmpty {
            mostrarAlerta(title: "Faltan datos", message: "Ingresa los Datos Faltantes")
            txtIdPac.becomeFirstResponder()
        }else{
            let id = txtIdPac.text?.trimmingCharacters(in: .whitespacesAndNewlines) as! NSString
            var stmt: OpaquePointer?
            let sentencia = "Select * FROM paciente Where idPaciente =?"
            
            if sqlite3_prepare(db, sentencia, -1, &stmt, nil) != SQLITE_OK{
                mostrarAlerta(title: "Error", message: "Error al ligar sentencia")
                return
            }
            if sqlite3_bind_int(stmt, 1, (id as NSString).intValue ) != SQLITE_OK{
                mostrarAlerta(title: "Error", message: "Error en el parametro idPaciente")
                return
            }
            if (sqlite3_step (stmt) == SQLITE_ROW){
                
                if let nomP = String(cString: sqlite3_column_text(stmt, 1))as! String?{
                    self.txtNomPac.text = nomP
                }
                if let domP = String(cString: sqlite3_column_text(stmt, 2))as! String?{
                    self.txtDomPac.text = domP
                }
                if let cor = String(cString: sqlite3_column_text(stmt, 3))as! String?{
                    self.txtCorreoPac.text = cor
                }
                if let ts = String(cString: sqlite3_column_text(stmt, 4))as! String?{
                    self.txtTS.text = ts
                }
                if let fech = String(cString: sqlite3_column_text(stmt, 5))as! String?{
                    self.txtFechNac.text = fech
                }
            }else{
                mostrarAlerta(title: "Error", message: "Paciente no Encontrado")
            }
        
        }
    }
    
    @IBAction func btnSubirPac(_ sender: UIButton) {
        if txtNomPac.text!.isEmpty || txtFechNac.text!.isEmpty || txtDomPac.text!.isEmpty ||
        txtCorreoPac.text!.isEmpty || txtTS.text!.isEmpty{
            mostrarAlerta(title: "Validacion de Entrada", message: "Error faltan de ingresar datos")
            txtNomPac.becomeFirstResponder()
            return
        }
        else{
            let nomP = txtNomPac.text
            let domP = txtDomPac.text
            let corr = txtCorreoPac.text
            let ts = txtTS.text
            let fech = txtFechNac.text

            let datos_a_enviar = ["nomPaciente":nomP!,"domPaciente":domP,"correo":corr,"tipoSangre":ts,
                                  "fechaNac":fech] as NSMutableDictionary
            dataJsonUrlClass.arrayFromJson(url:"DoctorAgenda/Paciente/insertPaciente.php",datos_enviados:datos_a_enviar){ (array_respuesta) in
                    DispatchQueue.main.async {
                        let diccionario_datos = array_respuesta?.object(at: 0) as! NSDictionary
                        
                        if let msg = diccionario_datos.object(forKey: "message") as! String?{
                            self.mostrarAlerta(title: "Paciente Guardado en WS", message: msg)
                        }
                        self.txtNomPac.text=""
                        self.txtDomPac.text = ""
                        self.txtCorreoPac.text = ""
                        self.txtTS.text = ""
                        self.txtFechNac.text = ""
                    }
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let doc : Doctor
        doc = doctor[0]
        mensajeLabel.text = ""
        lblUsr.text = String(doc.self.nomdoctor!)
       
        let fileurl = try! FileManager.default.url(for:.documentDirectory , in: .userDomainMask,  appropriateFor: nil, create: false).appendingPathComponent("BDSQLiteagenda.sqlite")
        
        if sqlite3_open(fileurl.path, &db) != SQLITE_OK{
            mostrarAlerta(title: "Error", message: "No se puede abrir la base de datos")
            return
        }
        
        let createTable = "CREATE TABLE IF NOT EXISTS paciente(idPaciente INTEGER  PRIMARY KEY AUTOINCREMENT, nomPaciente TEXT, domPaciente TEXT, correo TEXT,tipoSangre TEXT,fechaNac TEXT)"
        
        if sqlite3_exec(db, createTable,nil ,nil ,nil ) != SQLITE_OK{
            mostrarAlerta(title: "Error", message: "No se puede crear la tabla")
            return
        }
        mostrarAlerta(title: "Creacion de base de datos", message: "Base de datos creada")
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueListaPac"{
        let Lista = segue.destination as! TableViewControllerPac
            Lista.pacientes = pacientes
        }
    }
    
    func mostrarAlerta(title: String, message: String) {
        let alertaGuia = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelar = UIAlertAction(title: "Aceptar", style: .default, handler: {(action) in self.mensajeLabel.text = "" })
        alertaGuia.addAction(cancelar)
        present(alertaGuia, animated: true, completion: nil)
    }
}
