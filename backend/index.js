const express = require("express");
const mongoose = require("mongoose");

const authRoutes = require("./routes/authRoutes");
const notesRoutes = require("./routes/notesRoutes");

const PORT = process.env.PORT || 3000;

const app = express();

app.use(express.json());

mongoose.connect("<your_mongoDB_connection_URL>")
        .then(() => console.log("connected to MongoDB"))
        .catch(() => console.error("error while connecting to MongoDB"));

app.use('/auth', authRoutes);
app.use('/notes', notesRoutes);

app.listen(PORT, () => console.log(`Server started on port - ${PORT}`));