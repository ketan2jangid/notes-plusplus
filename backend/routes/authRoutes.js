const { Router } = require("express");
const controller = require("../controllers/authController");

const router = Router();

router.post('/register', controller.registerUser);

router.post('/login', controller.loginUser);

// router.post('/verify', controller.verifyUser);

module.exports = router;