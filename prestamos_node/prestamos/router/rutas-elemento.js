const express=require('express');
const res = require('express/lib/response');
const db = require('../models');
const upload=require('../lib/storage');
const router=express.Router();



const baseStogareDir=__dirname + '../storage/imgs/';

/**Rutas CRUD Elemento */

router.get('/',async(req,res) =>{
    try {
        let elements=await db.Elemento.findAll();
        res.status(200).send(elements);
    } catch (error) {
        res.status(400).send('No se pudieron traer los elementos, error: '+error.message);
    }
});

router.post('/new',upload.single('img'),async(req,res)=>{
    //console.log(`Guardado en ${req.hostname}:3000/${req.file.path}`);
    if(req.body!=null){
        console.log('POST: '+ req.body.nombre);
        try {
            const {nombre,descripcion,observaciones,codigo_id,cod_inventario,num_serie,estado} = req.body;
            const imagen=`http://localhost:3000/public/${req.file.filename}`;
            //host:port/public/filename
            console.log('ruta imagen: '+imagen)
            await db.Elemento.create({
                nombre,
                descripcion,
                num_serie,
                codigo_id,
                cod_inventario,
                observaciones,
                estado,
                imagen
            });
            res.status(201).send(`Elemento ${nombre} ${codigo_id} y ${imagen} creado correctamente`);
    
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


router.put('/update/:id',upload.single('img'),async(req,res)=>{
    const {nombre,descripcion,observaciones,codigo_id,cod_inventario,num_serie,estado} = req.body;
    const imagen=req.file.filename;
    await db.Elemento.update({
        nombre,
        descripcion,
        num_serie,
        codigo_id,
        cod_inventario,
        observaciones,
        estado,
        imagen
    },{where: {id:req.params.id}})
        .then(res.status(200).send(`Elemento actualizado correctamente`))
        .catch(error=>res.status(500).send('No se ha podido actualizar el elemento: '+error.message))
});





module.exports=router;