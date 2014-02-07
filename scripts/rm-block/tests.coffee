#!/usr/bin/env coffee
# Tests for the rm-block

fs = require 'fs'
exec = (require 'child_process').exec
path = require 'path'

makeGitFolder = (fname, cb) ->
  try
    fs.rmdirSync fname
  catch e
  fs.mkdirSync path.normalize fname
  exec "cd #{fname} && cd #{fname} && git init && cd ..", cb

test = (fname, shouldBeDeleted, input, mssg) ->
  makeGitFolder fname, ->
    cb = (err, streams...) ->
      fnameExists = fs.existsSync path.normalize fname
      if shouldBeDeleted is fnameExists
        process.stderr.write mssg
        process.exit 1
      else console.log 'Passed'
    c = (exec "coffee #{script} -rf #{fname}", cb).stdin.write "#{input}\n"
    c.stdout.read


testYes = -> test(
  '/tmp/testYes', yes
  'Y', 'When given yes folder is not deleted')

testNo = -> test(
  '/tmp/testNo', no
  'N', 'When given no the folder was deleted')

script = path.join __dirname, 'rm-block.coffee'
exec 'rm -rf /tmp/test*', ->
  do testNo
  # TODO - get testYes working
