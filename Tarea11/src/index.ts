const parser = require('./Gramatica/Gramatica');

const ast = parser.parse('a+b*c+(i-h)/t');

console.log(ast.c3d);

