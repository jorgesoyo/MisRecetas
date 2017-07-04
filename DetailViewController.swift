//
//  DetailViewController.swift
//  RecetasCompleto
//  Pequeño cambio
//  Created by Jorge MR on 01/07/17.
//  Copyright © 2017 Jorge MR. All rights reserved.
//  Que clase es esta?

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var recetaImageView: UIImageView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var ratedButton: UIButton!
    
    var receta : Receta!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.estimatedRowHeight = 47.5
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.recetaImageView.image = self.receta.imagen
        //Cambia el color de la tableView, incluso cambia el color de las secciones, pero no de las celdas, esas tienen su propio backgroundColor
        self.tableview.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        //Titulo de la barra de la receta
        self.title = receta.nombre!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Cada que va a aparecer la vista:
        //Ocultar la barra de navegacion al arrastrar hacia abajo = false
        //Poner la barra de navegacion oculta = false
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func close(segue: UIStoryboardSegue){
        if let reviewVC = segue.source as? ReviewViewController {
            if let ratingName = reviewVC.ratingSelected {
                ratedButton.setImage(UIImage(named: ratingName), for: [])
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else if section == 1 {
            //Seccion de ingredientes
            return receta.ingredientes.count
        } else if section == 2 {
            //Seccion de pasos
            return receta.pasos.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 3{
            let alertController = UIAlertController(title:  receta.nombre, message: "Valora este plato", preferredStyle: .alert)  //.actionSheet es para una alerta tipo footer
            //Accion de cancelar para la alerta (botón en alerta)
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            //agregar la accion de cancelar a la alerta
            alertController.addAction(cancelAction)
        
            //if para cambiar el color y texto al favorito
            var tituloFavorito = "Favorito"
            var estilo = UIAlertActionStyle.default
            if receta.isFavorite{
                tituloFavorito = "No favorito"
                estilo = UIAlertActionStyle.destructive
            }
        
            //Accion de favorito (boton en alerta)
            let favoriteAction = UIAlertAction(title: tituloFavorito, style: estilo) {
                action in
                //Estoy en otro closure
                self.receta.isFavorite = !self.receta.isFavorite
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        
            //Agregar la acción (boton) a la alerta
            alertController.addAction(favoriteAction)
            //Presentar la alerta al usuario
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recetaCeldaDetallada", for: indexPath) as! RecetaDetailTableViewCell
        //UIColor.clear hace que el color de la celda sea transparente
        //cell.backgroundColor = UIColor.clear
        switch(indexPath.section){
            case 0:
                if indexPath.row == 0 {
                    cell.keyLabel.text = "nombre"
                    cell.valueLabel.text = receta.nombre
                } else if indexPath.row == 1 {
                    cell.keyLabel.text = "tiempo"
                    cell.valueLabel.text = "\(receta.tiempo!) minutos"
                }else if indexPath.row == 2 {
                    cell.keyLabel.text = "Ingredientes"
                    cell.valueLabel.text = "\(receta.ingredientes.count)"
                }else if indexPath.row == 3 {
                    cell.keyLabel.text = "Favorita"
                    if receta.isFavorite {
                        cell.valueLabel.text = "Sí 👌🏼"
                    }else{
                        cell.valueLabel.text = "No ✌🏼"
                    }
                }
        case 1:
            if indexPath.row == 0 {
                cell.keyLabel.text = "Ingredientes"
            }else{
                cell.keyLabel.text = ""
            }
            cell.valueLabel.text = receta.ingredientes[indexPath.row]
            break;
        case 2:
            if indexPath.row == 0 {
                cell.keyLabel.text = "Pasos"
            }else{
                cell.keyLabel.text = ""
            }
            cell.valueLabel.text = receta.pasos[indexPath.row]
            break;
            
        default:
            break;
            
    
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Receta"
        } else if section == 1 {
            //Seccion de ingredientes
            return "Ingredientes"
        } else if section == 2 {
            //Seccion de pasos
            return "Pasos"
        }else {
            return ""
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
