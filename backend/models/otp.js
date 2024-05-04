const mongoose = require("mongoose");

const otpSchema = new mongoose.Schema({
    code: String,
    email: String,
    createdAt: {
        type: Date,
        expires: 300,
        default: () => Date.now()
    }
});

const Otp = mongoose.model("OTPs", otpSchema);

module.exports = {
    Otp
}