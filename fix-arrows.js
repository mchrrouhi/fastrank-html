const fs = require('fs');
const path = 'c:\\Users\\Mouhsine\\Documents\\GitHub\\fastrank-html\\blog\\index.html';

// Read file
let content = fs.readFileSync(path, 'utf8');

// Replace malformed arrows with proper Unicode arrow
content = content.replace(/â†'/g, '→');

// Write back
fs.writeFileSync(path, content, 'utf8');

console.log('✅ Fixed all arrows in blog/index.html');
