var express = require('express');
var path = require('path');
var serveStatic = require('serve-static');

app = express();
const csp = require('express-csp-header');
app.use(csp({
    policies: {
        'default-src': [csp.SELF, csp.INLINE, csp.EVAL],
        'script-src': [csp.SELF, csp.INLINE, csp.EVAL],
        'style-src': [csp.SELF,  csp.INLINE, csp.EVAL],
        'img-src': [csp.SELF,  csp.INLINE, csp.EVAL],
        'worker-src': [csp.NONE],
        'block-all-mixed-content': true
    }
}));

// app.use(function(req, res, next){
//     res.header("Content-Security-Policy", "default-src 'earthereum.herokuapp.com/myoperation' 'self' 'unsafe-inline' 'unsafe-eval';script-src 'self' 'unsafe-inline' 'unsafe-eval 'earthereum.herokuapp.com/myoperation';object-src 'none';img-src 'self';media-src 'self';frame-src 'none';font-src 'self' data:;connect-src 'self';style-src 'self'");
//     next();
// });

// app.use(function(req, res, next) {
//     res.setHeader("Content-Security-Policy"," default-src '*localhost*' 'self' 'unsafe-inline' 'unsafe-eval'; script-src '*localhost*' 'self' 'unsafe-inline' 'unsafe-eval' ; img-src 'self'; style-src 'self' 'unsafe-inline' 'unsafe-eval'");
//     return next();
// });
app.use(serveStatic(__dirname + "/dist"));

var port = process.env.PORT || 5000;
app.listen(port);

console.log('server started '+ port);
console.log(app);
