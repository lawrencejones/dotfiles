#!/usr/bin/env node

var input = "";

function lexisort(obj) {
  if (obj instanceof Array) return obj.map(lexisort);
  if ('object' != typeof obj) return obj;

  var sortedObj = {};
  Object.keys(obj).sort().map(function(key) {
    sortedObj[key] = lexisort(obj[key]);
  });

  return sortedObj;
};

process.stdin.resume();

process.stdin.on('data', function(data) {
  input = input + data;
});

process.stdin.on('end', function() {
  try {
    var json = JSON.parse(input.toString());
    console.log(JSON.stringify(lexisort(json), null, 2));
  } catch(err) {
    console.log(input.toString());
  }
});

process.stdin.on('end', function() { process.exit(0) });
