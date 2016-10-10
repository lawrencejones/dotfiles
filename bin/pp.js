#!/usr/bin/env node

// Determines if the keys should be sorted in the output
let sortOutputKeys = process.argv.indexOf('-u') == -1;

let input = "";

const lexisort = (obj) => {
  if (obj instanceof Array) return obj.map(lexisort);
  if (obj === null) return null;
  if ('object' !== typeof obj) return obj;

  var sortedObj = {};
  Object.keys(obj).sort().map(function(key) {
    sortedObj[key] = lexisort(obj[key]);
  });

  return sortedObj;
};

process.stdin.setEncoding('utf8');

process.stdin.on('readable', (data) => {
  let chunk = process.stdin.read();
  if (chunk !== null) {
    input = input + chunk.toString();
  }
});

process.stdin.on('end', () => {
  try {
    var json = JSON.parse(input.toString());
    /* This blocks! */
    process.stdout.write(JSON.stringify(sortOutputKeys ? lexisort(json) : json, null, 2));
    process.stdin.on('end', () => { process.exit(0) });
  } catch(err) {
    console.log(err);
    process.exit(255);
  }
});
