const jwt = require("jsonwebtoken");
const USER_SECRET = require("../secrets");


function authMiddleware(req, res, next) {
    const token = req.headers.authentication;

    try {
        const valid = jwt.verify(token, USER_SECRET);
        
        if(valid.email) {
            req.body['email'] = valid.email;

            next();
        } else {
            return res.status(401).json({
                msg: "User not authorized"
            });
        }
    } catch (err) {
        return console.error(err);
    }
}


module.exports = {
    authMiddleware
}