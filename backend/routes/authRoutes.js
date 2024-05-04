const { Router } = require("express");
const controller = require("../controllers/authController");
const { authMiddleware } = require("../middlewares/auth");

const router = Router();

router.post('/register', controller.registerUser);

router.post('/login', controller.loginUser);

router.get('/verifyEmail', authMiddleware, controller.sendVerificationMail);

router.post('/verifyOtp', authMiddleware, controller.verifyOtp);

module.exports = router;