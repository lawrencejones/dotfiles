#!/usr/bin/env coffee
# Blocks rm -rf so I don't do something awful

fs = require 'fs'
path = require 'path'
exec = require('child_process').exec
# Reformat args
args = process.argv[2..]
[files, flags] = [[],[]]
rf = 1 < args.reduce ((a, c) ->
  if c == '-r' or c == '-f' then a++
  else if c == '-rf' then a += 2
  else if not /-.*/.test c then flags.push c
  else files.push c
  a), 0

# Takes files to proxy to rm
confirmed = []; rm = ->
  cmd = 'rm '
  if rf then cmd += '-rf'
  exec "#{cmd} #{flags.join(' ')} #{confirmed.join(' ')}", (err, streams...) ->
    for s in streams
      process.stdout.write s
  
# Prompt for confirmation
prompt = (fname, cb) ->
  require('read') {prompt: 'Sure? [y/n] '}, (err, res) ->
    if /y/i.test res
      confirmed.push fname; cb?()
    else console.log "Then THANK GOD you wrote this."; process.exit 1

# Delete a single file
deleteFile = (fname, cb) ->
  if fs.existsSync path.join(fname, '.git')
    console.log "The folder #{fname} is a git repository."
    console.log "Think CAREFULLY about whether you wish to destroy it."
    countdown = (i) ->
      console.log "   #{i}"
      if i > 0
        setTimeout (-> countdown(--i)), 1000
      else prompt fname, cb
    countdown 3
  else confirmed.push fname; cb?()

# Chain file deletion together
deleteFiles = ->
  if files.length is 0 then do rm
  else deleteFile files.shift(), deleteFiles

deleteFiles files
