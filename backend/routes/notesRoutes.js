const { Router } = require("express");
const controller = require("../controllers/notesController");
const { authMiddleware }= require("../middlewares/auth");

const router = Router();

// router.use();

router.get("/all", authMiddleware, controller.getNotes);

router.post("/", authMiddleware, controller.createNotes);

router
.route("/:noteId")
.put(authMiddleware, controller.updateNotes)
.delete(authMiddleware, controller.deleteNotes);


module.exports = router;