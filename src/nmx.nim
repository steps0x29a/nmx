import os
import strformat

proc info(msg: string, prefix:string="") =
  echo(prefix, "[*] ", msg)

proc warn(msg: string, prefix:string="") =
  echo(prefix, "[!] ", msg)

proc error(msg: string, prefix:string="") =
  echo(prefix, "[x] ", msg)

proc is_node_modules_dir(path: string): bool = 
  lastPathPart(path) == "node_modules" and dirExists(path)

proc is_in_node_modules(path: string): bool =
  for p in path.parentDirs(fromRoot=false, inclusive=false):
    if is_node_modules_dir(p):
      return true
  false

proc find_node_modules_directories(path: string): seq[string] =
  for p in walkDirRec(path, yieldFilter={pcDir}):
    if splitPath(p).tail == "node_modules" and not is_in_node_modules(p):
      result.add(p)

if paramCount() < 1:
  warn("[!] I need a directory to search. Exiting.")
  quit(QuitSuccess)

if paramCount() >= 1:
  let targetPath = commandLineParams()[0]
  let isDirAndExists = dirExists(targetPath)
  if not isDirAndExists:
    error("Provided path either doesn't exist or is not a directory")
  else:
    info(fmt"Searching {targetPath} for node_modules directories...")
    let targets: seq[string] = find_node_modules_directories(targetPath)
    info(fmt"There are {targets.len()} node_module folders in {targetPath}")
    for target in targets:
      info(fmt"  -> Removing {target}...")
      try:
        removeDir(target)
      except OSError:
        error(fmt"Unable to remove {target}")
        quit(QuitFailure)
    info("Done")
   