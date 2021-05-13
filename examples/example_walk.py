from thatlib import walk
print(walk(
  folderpath    = ".",
  extensions    = [".py", ".nim"],
  followlinks   = False,
  yieldfiles    = True,
  debugs        = True,
  check_folders = False,
  prealloc      = 9,
))
