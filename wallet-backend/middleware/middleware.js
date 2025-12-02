const jwt = require('jsonwebtoken');

function authenticateToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1]; // Bearer <token>
  if (!token) {
    return res.status(401).json({ error: 'Token gerekli.' });
  }
  jwt.verify(token, process.env.JWT_SECRET || 'GIZLI_ANAHTARIN', (err, decoded) => {
    if (err) {
      return res.status(401).json({ error: 'Geçersiz veya süresi dolmuş token.' });
    }
    req.userId = decoded.id;
    next();
  });
}

module.exports = authenticateToken;
