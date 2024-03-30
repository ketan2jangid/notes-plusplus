const mongoose = require("mongoose");

const notesSchema = new mongoose.Schema({
    title: String,
    body: String,
}, {
    timestamps: true
});

const Notes = mongoose.model("Notes", notesSchema);

module.exports = {
    Notes
}