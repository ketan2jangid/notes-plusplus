const z = require("zod");
const jwt = require("jsonwebtoken");
const nodemailer = require("nodemailer");
const { User } = require("../models/user");
const { Otp } = require("../models/otp");

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
                success: false,
                msg: "User with email already exists"
            });
        } else {
            const e = emailSchema.safeParse(email);
            const p = passSchema.safeParse(password);

            console.log(e, p);

            if (!e.success || !p.success) {
                return res.status(400).json({
                    success: false,
                    msg: "check email/password format"
                });
            }

            await User.create({
                email,
                password
            });

            res.status(201).json({
                success: true,
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
                success: false,
                msg: "user not found"
            });
        } else {
            const valid = user.checkPassword(password);

            if (valid) {
                const token = jwt.sign({
                    email
                }, USER_SECRET);

                return res.status(200).json({
                    success: true,
                    msg: "login successful",
                    data: {
                        userData: {
                            "id": user._id,
                            "token": token,
                            "email": user.email,
                            "isVerified": user.isVerified,
                            "notes": user.notes
                        }
                    }
                });
            } else {
                return res.status(400).json({
                    success: false,
                    msg: "incorrect password"
                })
            }
        }
    } catch (err) {
        console.error(err);
    }
}

async function sendVerificationMail(req, res) {
    const { email } = req.body;

    try {
        const sender = process.env.SENDER;
        const transport = nodemailer.createTransport({
            host: "smtp-relay.brevo.com",
            port: 587,
            secure: false, 
            auth: {
              user: sender,
              pass: process.env.KEY
            },
        });
    
        const OTP = Math.floor(Math.random()*1000000);
        
        const otpRes = await Otp.create({
            email: email,
            code: OTP
        });
    
        console.log(otpRes);
    
        const mailOptions = {
            from: sender,
            to: email,
            subject: 'verify your mail',
            html: `This is verification mail from notes++. Enter the below OTP to verify your email.<br> <h4>OTP: ${OTP}</h4> <br>This OTP is valid only for 5 minutes`
        };
    
        const mail = await transport.sendMail(mailOptions);

        console.log(mail.response);
    
        return res.json({
            success: true,
            msg: "OTP sent to your email"
        });
    } catch (err) {
        console.error(err);
    }
}

async function verifyOtp(req, res) {
    const { email, otp } = req.body;

    try {
        const found = await Otp.findOne({
            email: email,
            code: otp
        });

        console.log(found);

        if(found) {
            const del = await Otp.deleteOne({
                email: email,
                code: otp
            });

            const status = await User.updateOne({
                email
            }, {
                isVerified: true
            });

            console.log(status);

            return res.json({
                success: true,
                msg: "OTP verified"
            });
        } else {
            return res.json({
                success: false,
                msg: "Invalid OTP"
            });
        }
    } catch (err) {
        console.error(err);
    }
}

module.exports = {
    registerUser,
    loginUser,
    sendVerificationMail,
    verifyOtp
}