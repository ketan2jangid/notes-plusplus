const mongoose = require("mongoose");
const bcrypt = require("bcrypt");

const SALT_ROUNDS = 8;

const userSchema = new mongoose.Schema({
    email: {
        type: String,
        lowercase: true,
        required: true,
        unique: true,
        trim: true        
    },
    password: {
        type: String,
        minLength: 6,
        required: true,
    },
    isVerified: {
        type: Boolean,
        default: false
    },
    notes: [
        {
            type: mongoose.Schema.ObjectId,
            ref: 'Notes'
        }
    ]
});

userSchema.pre('save', function(next) {
    if(this.password && this.isModified('password')) {
       const hashed = bcrypt.hashSync(this.password, bcrypt.genSaltSync(SALT_ROUNDS));

       this.password = hashed;
    }

    next();
});

userSchema.methods.checkPassword = function(pass) {
    return bcrypt.compareSync(pass, this.password);
}

const User = mongoose.model("User", userSchema);

module.exports = {
    User
}