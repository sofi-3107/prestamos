const express=require('express');
const app = express();
const db=require('./models');
const bodyParser=require('body-parser');
const cors=require('cors');


app.use(bodyParser.urlencoded({ extended:true}));
app.use(bodyParser.json());
app.use(cors());


/**use es porque router es un middelware proporcionado por express, delega el manejo de rutas */
app.use('/elementos',require('./router/rutas-elemento'));
app.use('/usuarios',require('./router/rutas-usuarios'));
app.use('/prestamos',require('./router/rutas-prestamos'))

/**mostramos public y en el server es storage/img */
app.use('/public',express.static(`${__dirname}/storage/imgs`));
async function waitDb() {
    await db.sequelize.sync({force: true}).then(console.log('Modelos sincronizados'));
}

//waitDb();


app.listen(3000,()=>console.log('Server running at http://localhost:3000'));