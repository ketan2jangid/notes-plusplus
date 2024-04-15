const z = require("zod");
const jwt = require("jsonwebtoken");
const { User } = require("../models/user");

const USER_SECRET = require("../secrets");

const emailSchema = z.string().email();
const passSchema = z.string().min(6);

async function registerUser(req, res) {
    const { email, password } = req.body;

    console.log(email, password);

    try {
        const exist = await User.findOne({
            email: email
        });

        if (exist) {
            return res.status(409).json({
                msg: "User with email already exists"
            });
        } else {
            const e = emailSchema.safeParse(email);
            const p = passSchema.safeParse(password);

            console.log(e, p);

            if (!e.success || !p.success) {
                return res.status(400).json({
                    msg: "check email or password format"
                });
            }

            await User.create({
                email,
                password
            });

            res.status(201).json({
                msg: "User created successfully"
            });
        }
    } catch (err) {
        console.error(err);
    }
}

async function loginUser(req, res) {
    const { email, password } = req.body;

    try {
        const user = await User.findOne({
            email
        });

        if (!user) {
            return res.status(404).json({
                msg: "user not found"
            });
        } else {
            const valid = user.checkPassword(password);

            if (valid) {
                const token = jwt.sign({
                    email
                }, USER_SECRET);

                return res.status(200).json({
                    msg: "login successful",
                    userData: {
                        "id": user._id,
                        "token": token,
                        "email": user.email,
                        "isVerified": user.isVerified,
                        "notes": user.notes
                    }
                });
            } else {
                return res.status(400).json({
                    msg: "incorrect password"
                })
            }
        }
    } catch (err) {
        console.error(err);
    }
}

async function verifyUser(req, res) {
    // TODO: USE EMAIL OTP USING NODEMAILER TO VERIFY USER
}

module.exports = {
    registerUser,
    loginUser,
    verifyUser
}