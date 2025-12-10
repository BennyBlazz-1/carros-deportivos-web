const express = require("express");
const app = express();
const PORT = process.env.PORT || 8080;

// Servir carpeta pública
app.use(express.static("public"));

app.listen(PORT, () => {
    console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
