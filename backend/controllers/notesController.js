const { Notes } = require("../models/notes");
const { User } = require("../models/user");

async function getNotes(req, res) {
    const email = req.body.email;

    try {
        const user = await User.findOne({
            email
        });

        console.log(user.notes);

        const allNotes = await Notes.find({
            _id: {
                $in: user.notes
            }
        });

        console.log(allNotes);

        res.status(200).json({
            msg: "Notes retrieved successfully",
            notes: allNotes
        })
    } catch (err) {
        console.error(err);
    }
}

async function createNotes(req, res) {
    const { title, body, email } = req.body;

    try {
        const newNote = await Notes.create({
            title,
            body
        });
        
        if(newNote) {
            const updated = await User.updateOne({
                email
            }, {
                $push: {
                    notes: newNote.id
                }
            });
            
            if(updated) {
                return res.status(201).json({
                    msg: "New note added successfully"
                });
            } else {
                return res.status(500).json({
                    msg: "Something went wrong"
                });
            }
        } else {
            return res.status(500).json({
                msg: "Something went wrong"
            });
        }
    } catch (err) {
        console.error(err);
    }
}

async function updateNotes(req, res) {
    const noteId = req.params.noteId;
    const { title, body, email } = req.body;

    try {
        const updated = await Notes.updateOne({
            _id: noteId
        }, {
            title,
            body
        })

        if(updated) {
            return res.json({
                msg: "Note updated successfully"
            });
        } else {
            return res.status(500).json({
                msg: "Something went wrong"
            });
        }
    } catch (err) {
        console.error(err);
    }
}

async function deleteNotes(req, res) {
    const noteId = req.params.noteId;
    const email = req.body.email;

    console.log(email , noteId);

    try {
        const success = await User.findOneAndUpdate({
            email
        }, {
            $pull: {
                notes: noteId
            }
        });

        console.log("##########");
        console.log(success);
            
        const del = await Notes.findByIdAndDelete(noteId);
    
        console.log("##########");
        console.log(del);


        return res.status(200).json({
            msg: "note deleted successfully"
        });
    } catch (err) {
        return console.error(err);
    }
}

module.exports = {
    getNotes,
    createNotes,
    updateNotes,
    deleteNotes
}