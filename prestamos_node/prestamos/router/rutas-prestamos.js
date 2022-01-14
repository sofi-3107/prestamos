const express=require('express');
const res = require('express/lib/response');
const db = require('../models');
const router=express.Router();
const moment=require('moment');





/**Rutas CRUD Elemento */

router.get('/',async(req,res) =>{
    try {
        let prestamos=await db.Prestamos.findAll();
        res.status(200).send(prestamos);
    } catch (error) {
        res.status(400).send('No se pudieron traer los prestamos, error: '+error.message);
    }
});

router.post('/new',async(req,res)=>{
    let m=moment();
    if(req.body!=null){
        console.log('POST: '+ req.body.elemento);
        try {
            b=req.body;
            let idElemento=req.body.idElemento;
            let idUser=req.body.idUser;
            let fecha=m.format('DD/MM/YYYY');
            let hora_pedido=m.format('HH:mm:ss');
            let hora_devolucion=req.body.devolucion;

            await db.Elemento.create({



            });
            res.status(201).send(`Prestamo registrado correctamente`);
    
        } catch (error) {
            res.status(400).send('Error al crear elemento: '+error.message);
        }
    }else{
        res.send('No han llegado datos al servidor');
    }

});


router.get('/one/:id',async(req,res)=>{

    console.log(`Método de consulta unitaria id: ${req.params.id}`);
    try {
        let elemento=await db.Elemento.findByPk(req.params.id);
        res.status(200).send(elemento);
    } catch (error) {
        res.status(500).send('No se ha encontrado el elemento: '+error.message);
    }
});

router.delete('/delete/:id',async(req,res)=>{

    await db.Elemento.destroy({where: {id: req.params.id}})
        .then(res.status(200).send(`Elemento borrado correctamente`))
        .catch(error=>res.status(500).send('No se ha podido borrar el elemento: '+error.message));    
});


router.put('/update/:id',async(req,res)=>{
            b=req.body;
            nom=b.nombre;
            desc=b.descripcion;
            id=b.id;
            inventario=b.inventario;
            obs=b.obs;
            serie=b.serie;
            state=b.estado;

    await db.Elemento.update({
        nombre:nom,
                descripcion:desc,
                codigo_id:id,
                num_serie:serie,
                observaciones:obs,
                estado:state,
                cod_inventario:inventario,
    },{where: {id:req.params.id}})
        .then(res.status(200).send(`Elemento actualizado correctamente`))
        .catch(error=>res.status(500).send('No se ha podido actualizar el elemento: '+error.message))
});





module.exports=router;