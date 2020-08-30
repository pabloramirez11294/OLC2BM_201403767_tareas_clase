const parser = require('./Gramatica/Gramatica');

const ast = parser.parse('a+b*c+(i-h)');
console.log(ast.c3d);

