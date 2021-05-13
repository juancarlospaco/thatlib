## * Faster `pathlib` for Python.
import std/[strutils, os], nimpy

proc cwd*(): string {.exportpy.} =
  getCurrentDir()

proc home*(): string {.exportpy.} =
  getHomeDir()

proc mkdir*(path: string): string {.exportpy.} =
  createDir(path)

proc rmdir*(path: string) {.exportpy.} =
  removeDir(path)

proc is_file*(path: string): bool {.exportpy.} =
  fileExists(path)

proc is_dir*(path: string): bool {.exportpy.} =
  dirExists(path)

proc exists*(path: string): bool {.exportpy.} =
  fileExists(path) or dirExists(path)

proc rename*(source, destination: string): bool {.exportpy.} =
  moveFile(source, destination)

proc replace*(source, destination: string): string {.exportpy.} =
  moveFile(source, destination)
  result = destination

proc resolve*(path: string): string {.exportpy.} =
  absolutePath(path)

func samefile*(pathA, pathB: string): bool {.exportpy.} =
  sameFile(pathA, pathB)

func is_absolute*(path: string): bool {.exportpy.} =
  os.isAbsolute(path)

func joinpath*(paths: openArray[string]): string {.exportpy.} =
  os.joinPath(paths)

func with_suffix*(path, ext: string): string {.exportpy.} =
  changeFileExt(path, ext)

func with_stem*(path, stem: string): string {.exportpy.} =
  let f = splitFile(path)
  result = f.dir / stem & f.ext

func with_name*(path, name: string): string {.exportpy.} =
  let f = splitFile(path)
  result = f.dir / name

func suffix*(path: string): string {.exportpy.} =
  splitFile(path).ext

func stem*(path: string): string {.exportpy.} =
  splitFile(path).name

func parent*(path: string): string {.exportpy.} =
  splitFile(path).dir

proc write_bytes*(path, data: string): string {.exportpy.} =
  writeFile(path, data)

proc read_bytes*(path: string): string {.exportpy.} =
  readFile(path)

proc is_relative_to*(path, base: string): bool {.exportpy.} =
  os.isRelativeTo(path, base)

proc expanduser*(path: string): string {.exportpy.} =
  os.expandTilde(path)

proc chmod*(path: string; permissions: uint) {.exportpy.} =
  var results: set[FilePermission]
  var perm = permissions
  for permBase in [fpOthersExec, fpGroupExec, fpUserExec]:
    if (perm and 1) != 0: results.incl permBase         # Exec
    if (perm and 2) != 0: results.incl permBase.succ()  # Read
    if (perm and 4) != 0: results.incl permBase.succ(2) # Write
    perm = perm shr 3  # Shift to next permission group
  setFilePermissions(path, results)


# ^ API mimic from Python "pathlib" ################################## v Extras


func parents*(path: string): string {.exportpy.} =
  parentDir(path)

proc lines*(path: string; start: int = 0; ends: int = 1): seq[string] {.exportpy.} =
  readFile(path).splitLines[start .. ^ends]

proc line*(path: string; line_number: Natural): string {.exportpy.} =
  readFile(path).splitLines[line_number]

proc counted_lines*(path: string): int {.exportpy.} =
  readFile(path).countLines

func tokenized*(path: string): seq[tuple[token: string, isSep: bool]] {.exportpy.} =
  for item in strutils.tokenize(path): result.add item

func replaced*(path: string; replacements: openArray[(string, string)]): string {.exportpy.} =
  path.multiReplace(replacements)

func normalized*(path: string): string {.exportpy.} =
  path.strip.normalize

func is_root_dir*(path: string): bool {.exportpy.} =
  isRootDir(path)

func get_suffix_index*(path: string): int {.exportpy.} =
  searchExtPos(path)

func path_splitted*(path: string): tuple[dir, name, ext: string] {.exportpy.} =
  splitFile(path)

func compare_paths*(pathA, pathB: string): int {.exportpy.} =
  cmpPaths(pathA, pathB)

proc get_conf_dir*(): string {.exportpy.} =
  getConfigDir()

proc get_temporary_dir*(): string {.exportpy.} =
  getTempDir()

func paths_quoted*(paths: openArray[string]): string {.exportpy.} =
  quoteShellCommand(paths)

proc is_file_newer*(pathA, pathB: string): bool {.exportpy.} =
  fileNewer(pathA, pathB)

func symlink_exists*(path: string): bool {.exportpy.} =
  symlinkExists(path)

proc get_exe*(path: string; followSymlinks: bool = true): string {.exportpy.} =
  findExe(path, followSymlinks)

proc mksymlink*(source, destination: string): uint {.exportpy.} =
  createSymlink(source, destination)

proc get_symlink*(path: string): string {.exportpy.} =
  expandSymlink(path)

proc try_rmfile*(path: string): bool {.exportpy.} =
  tryRemoveFile(path)

proc exists_create_dir*(path: string): bool {.exportpy.} =
  existsOrCreateDir(path)

proc mkhardlink*(source, destination: string) {.exportpy.} =
  createHardlink(source, destination)

proc get_size*(path: string) : BiggestInt {.exportpy.} =
  getFileSize(path)

proc is_hidden_path*(path: string) : bool {.exportpy.} =
  isHidden(path)

func is_valid_path*(path: string) : bool {.exportpy.} =
  isValidFilename(path)

proc copy_file_permissions*(source, dest: string; ignore_errors: bool = true) {.exportpy.} =
  copyFileWithPermissions(source, dest, ignore_errors)

proc copy_dir_permissions(source, dest: string; ignore_errors: bool = true) {.exportpy.} =
  copyDirWithPermissions(source, dest, ignore_errors)

proc walk*(folderpath: string; extensions: seq[string] = @[""]; followlinks : bool = false; yieldfiles: bool = true; debugs: bool = false; check_folders: bool = false; prealloc: Positive = 99): seq[string] {.exportpy.} =
  result = newSeqOfCap[string](prealloc)
  let extused {.noalias.} = create bool
  extused[] = extensions != @[""] and extensions.len > 0
  for item in walkDirRec(folderpath, {if yieldfiles: pcFile else: pcDir}, {if followlinks: pcLinkToDir else: pcDir}, checkDir = check_folders):
    if unlikely(debugs): echo item
    if unlikely(extused[]):
      for ext in extensions:
        if item.normalize.endsWith(ext): result.add item
    else: result.add item
  if extused != nil: dealloc extused

proc walk_glob*(globpattern: string; prealloc: Positive = 99): seq[string] {.exportpy.} =
  result = newSeqOfCap[string](prealloc)
  for item in walkPattern(globpattern): result.add item

proc walk_simple*(folderpath: string; relative: bool = false; check_folders: bool = false; prealloc: Positive = 99): seq[string] {.exportpy.} =
  result = newSeqOfCap[string](prealloc)
  for item in walkDirRec(folderpath, relative=relative, checkDir=check_folders): result.add item

proc walk_folders*(globpattern: string; prealloc: Positive = 99): seq[string] {.exportpy.} =
  result = newSeqOfCap[string](prealloc)
  for item in walkDirs(globpattern): result.add item

proc walk_files*(globpattern: string; prealloc: Positive = 99): seq[string] {.exportpy.} =
  result = newSeqOfCap[string](prealloc)
  for item in walkFiles(globpattern): result.add item
