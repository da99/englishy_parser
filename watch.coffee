
spawn  = require('child_process').spawn
fs     = require 'fs'
this_folder = process.cwd()

buff = (buffer) ->
  console.log buffer.toString()
  
runCommand = (name, str_args, f, after) ->
  console.log "running: #{name} #{str_args}"
  proc = spawn name, str_args.split(' ')
  proc.stdout.on 'data', (buffer) -> 
    buff(buffer)
    f?(buffer)
  proc.stderr.on 'data', buff
  proc.on 'exit', (status) -> 
    process.exit(1) if status != 0
    after?()

# ============ Check for files that need compilation.

watch_files = () ->
  past = {}

  runCommand 'coffee', '--output lib/ -cw src/', (buffer) ->
    if buffer.toString().indexOf('compiled') is -1
      return false

    date = buffer.toString().split(' ')[0]
    if date.length is 8 and past[date]
      return false

    past[date] = buffer.toString()
    runCommand "mocha", '-c --compilers coffee:coffee-script'

#  ============ Check if node_modules dir needs to be created.


node_modules = "#{this_folder}/node_modules"

if fs.existsSync("package.json") and !fs.existsSync(node_modules)
  runCommand "npm", "install", null, () ->
    for name in fs.readdirSync(node_modules) 
      path = "#{node_modules}/#{name}"
      if fs.existsSync("../#{name}/package.json")
        fs.rmdirSync   path
        fs.symlinkSync "#{fs.realpathSync '..'}/#{name}", path
        
    fs.symlinkSync this_folder, "#{node_modules}/#{this_folder.split("/").pop()}"
    watch_files()

else
  watch_files()
  

