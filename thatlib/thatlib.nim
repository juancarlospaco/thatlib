## * Faster `pathlib` for Python.
import std/[strutils, os], nimpy

proc cwd*(): string {.exportpy.} =
  getCurrentDir()

proc home*(): string {.exportpy.} =
  getHomeDir()

proc mkdir*(s: string): string {.exportpy.} =
  createDir(s)

proc rmdir*(s: string) {.exportpy.} =
  removeDir(s)

func is_file*(s: string): bool {.exportpy.} =
  fileExists(s)

func is_dir*(s: string): bool {.exportpy.} =
  dirExists(s)

func exists*(s: string): bool {.exportpy.} =
  fileExists(s) or dirExists(s)

proc rename*(source, destination: string): bool {.exportpy.} =
  moveFile(source, destination)

proc replace*(source, destination: string): string {.exportpy.} =
  moveFile(source, destination)
  result = destination

proc resolve*(s: string): string {.exportpy.} =
  absolutePath(s)

func samefile*(pathA, pathB: string): bool {.exportpy.} =
  sameFile(pathA, pathB)

func is_absolute*(s: string): bool {.exportpy.} =
  os.isAbsolute(s)

func joinpath*(s: openArray[string]): string {.exportpy.} =
  os.joinPath(s)

func with_suffix*(s, ext: string): string {.exportpy.} =
  changeFileExt(s, ext)

func with_stem*(s, stem: string): string {.exportpy.} =
  let f = splitFile(s)
  result = f.dir / stem & f.ext

func with_name*(s, name: string): string {.exportpy.} =
  let f = splitFile(s)
  result = f.dir / name

func suffix*(s: string): string {.exportpy.} =
  splitFile(s).ext

func stem*(s: string): string {.exportpy.} =
  splitFile(s).name

func parent*(s: string): string {.exportpy.} =
  splitFile(s).dir

proc write_bytes*(path, data: string): string {.exportpy.} =
  writeFile(path, data)

proc read_bytes*(path: string): string {.exportpy.} =
  readFile(path)

proc is_relative_to*(path, base: string): bool {.exportpy.} =
  os.isRelativeTo(path, base)

proc expanduser*(s: string): string {.exportpy.} =
  os.expandTilde(s)

proc toFilePermissions(perm: Natural): set[FilePermission] =
  var perm = uint(perm)
  for permBase in [fpOthersExec, fpGroupExec, fpUserExec]:
    if (perm and 1) != 0: result.incl permBase         # Exec
    if (perm and 2) != 0: result.incl permBase.succ()  # Read
    if (perm and 4) != 0: result.incl permBase.succ(2) # Write
    perm = perm shr 3  # Shift to next permission group

proc chmod*(path: string; permissions: uint) {.exportpy.} =
  setFilePermissions(path, toFilePermissions(permissions))


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

func paths_quoted*(args: openArray[string]): string {.exportpy.} =
  quoteShellCommand(args)

proc is_file_newer*(a, b: string): bool {.exportpy.} =
  fileNewer(a, b)

func symlink_exists*(s: string): bool {.exportpy.} =
  symlinkExists(s)

proc get_exe*(s: string; followSymlinks: bool = true): string {.exportpy.} =
  findExe(s, followSymlinks)

proc get_permissions*(s: string): uint {.exportpy.} =
  fromFilePermissions(getFilePermissions(s))

proc mksymlink*(source, destination: string): uint {.exportpy.} =
  createSymlink(source, destination)

proc get_symlink*(s: string): string {.exportpy.} =
  expandSymlink(s)

proc try_rmfile*(s: string): bool {.exportpy.} =
  tryRemoveFile(s)

proc exists_create_dir*(s: string): bool {.exportpy.} =
  existsOrCreateDir(s)

proc mkhardlink*(source, destination: string) {.exportpy.} =
  createHardlink(source, destination)

proc get_size*(s: string) : BiggestInt {.exportpy.} =
  getFileSize(s)

func is_hidden_path*(s: string) : bool {.exportpy.} =
  isHidden(s)

func is_valid_path*(s: string) : bool {.exportpy.} =
  isValidFilename(s)

proc copy_file_permissions*(source, dest: string; ignore_errors: bool = true) {.exportpy.} =
  copyFileWithPermissions(source, dest, ignore_errors)

proc copy_dir_permissions(source, dest: string; ignore_errors: bool = true) {.exportpy.} =
  copyDirWithPermissions(source, dest, ignore_errors)

proc walk*(folderpath: string, extensions: seq[string] = @[""], followlinks : bool = false, yieldfiles: bool = true, debugs: bool = false, check_folders: bool = false; prealloc: Positive = 99): seq[string] {.exportpy.} =
  result = newSeqOfCap[string](prealloc)
  let extused {.noalias.} = create(bool, sizeOf(bool))  # Optimization.
  extused[] = extensions != @[""] and extensions.len > 0
  for item in walkDirRec(folderpath, {if yieldfiles: pcFile else: pcDir}, {if followlinks: pcLinkToDir else: pcDir}, checkDir=check_folders):
    if unlikely(debugs): echo item
    if unlikely(extused[]):
      for ext in extensions:
        if item.normalize.endsWith(ext): result.add item
    else: result.add item
  dealloc extused

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
