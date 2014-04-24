#!/usr/bin/coffee
fs = require 'fs'
path = require 'path'
cheerio = require 'cheerio'
request = require 'request'
stringTable = require 'string-table'
growl = require 'growl'
$q = require 'q'

# Date constants
DAY = 1000 * 60 * 60 * 24
MIDNIGHT = Math.floor(Date.now() / DAY)*DAY

Array::contains = (str) ->
  if str instanceof RegExp
    for e in this
      return true if str.test e
    return false
  else
    @indexOf(str) != -1

args = process.argv[2..]

getStudentDetails = (login, deferred = $q.defer()) ->
  studentUrl = (login) ->
    "https://teachdb.doc.ic.ac.uk/db/viewtab?table=Student&arg1=#{login}"
  options = auth: {user: user, pass: pass}, url: studentUrl login
  request options, (err, res, body) ->
    if err? or res.statusCode != 200
      return growl 'Error scraping users!!!',
        sticky: true, title: 'Doc Exams - ERROR'
    $ = cheerio.load body
    cells = $('table').eq(2).find('tr').last().find('td')[2..]
    [login, fname, lname, _, klass] = cells.map -> $(@).text()
    deferred.resolve
      login: login, fname: fname, lname: lname, klass: klass
  deferred.promise

classProfile = (users) ->
  profile = new Object()
  for user in users
    profile[user.klass] ?= 0
    ++profile[user.klass]
  Object.keys(profile)
    .map (k) -> class: k, count: profile[k]
    .sort (a,b) -> a.class.localeCompare b.class

class User
  constructor: (data) ->
    @[k] = v for own k,v of data
    @lastseen ?= (@seen ?= Date.now())

  @make: (login) ->
    defer = $q.defer()
    getStudentDetails(login).then (data) ->
      defer.resolve new User data
    defer.promise

  # Class method to allow formatting
  @timeSince: (seen) ->
    elapsed = Date.now() - seen
    minutes = 60*(hours = 24*(days = elapsed / (1000*60*60*24)))
    if days >= 1 then "#{Math.floor days}d"
    else if hours >= 1 then "#{Math.floor hours}h"
    else "#{Math.floor minutes}m"

  # Returns true if the user has been seen since midnight today
  seenToday: ->
    @lastseen > MIDNIGHT
    
[user, pass] =
  fs.readFileSync('/Users/lawrencejones/.imp', 'utf8').split '\n'

FILE = path.join __dirname, 'users.json'
try
  users = JSON.parse fs.readFileSync FILE, 'utf8'
  users[l] = new User u for own l,u of users
catch err
  users = {}

count = Object.keys(users).length

request 'https://doc-exams.herokuapp.com/users', (err, data, body) ->
  logins = new Array()
  for l in JSON.parse body
    if users[l]? then users[l].lastseen = Date.now()
    else logins.push l
  logins = (l for l in JSON.parse body when !users[l]?)
  details = $q.all(logins.map (l) -> User.make l)
  details.then (records) ->
    users[u.login] = u for u in records when u?.login?
  details.finally ->
    fs.writeFileSync FILE, JSON.stringify users, 'utf8'
    records = Object.keys(users)
      .map (l) -> users[l]
      .sort (a,b) ->
        return a.seen - b.seen if args.contains 'seen'
        return a.lastseen - b.lastseen if args.contains /lastseen|today/
        if a.klass == b.klass
          a.fname.localeCompare b.fname
        else a.klass.localeCompare b.klass
    # Generate metrics
    noOfUsers = records.length
    # Adjust records for args
    todays = records.filter (r) -> r.seenToday()
    records = todays if args.contains 'today'
    classTbl = stringTable.create classProfile records
    # Generate table for todays/all
    fullTbl = stringTable.create records, formatters: {
      seen: User.timeSince
      lastseen: User.timeSince
    }
    console.log """
    #{fullTbl}\n
    #{classTbl}\n
    Currently at #{noOfUsers} users.
    Seen #{todays.length} since midnight.\n"""
    if (c = Object.keys(users).length) != count
      growl "#{c - count} new users!", title: 'Doc Exams', sticky: true
  
