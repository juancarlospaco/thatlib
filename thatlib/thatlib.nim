## .. image:: https://raw.githubusercontent.com/juancarlospaco/thatlib/nim/results_graph.png
import std/[strutils, os, sha1, md5, json, parseutils, times], nimpy

proc cwd*(): string {.exportpy.} =
  getCurrentDir()

proc home*(): string {.exportpy.} =
  getHomeDir()

proc mkdir*(path: string) {.exportpy.} =
  createDir(path)

proc rmdir*(path: string; check: bool = false) {.exportpy.} =
  removeDir(path, check)

proc is_file*(path: string): bool {.exportpy.} =
  fileExists(path)

proc is_dir*(path: string): bool {.exportpy.} =
  dirExists(path)

proc exists*(path: string): bool {.exportpy.} =
  fileExists(path) or dirExists(path)

proc rename*(source, destination: string) {.exportpy.} =
  moveFile(source, destination)

proc replace*(source, destination: string): string {.exportpy.} =
  moveFile(source, destination)
  result = destination

proc resolve*(path: string): string {.exportpy.} =
  absolutePath(path)

proc absolute*(path: string): string {.exportpy.} =
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

proc as_uri*(path: string): string {.exportpy.} =
  (when defined(windows): "file:///" else: "file://") / absolutePath(path)

proc parts*(path: string): seq[string] {.exportpy.} =
  absolutePath(path).split(DirSep)

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


proc is_root*(): bool {.exportpy.} =
  when compiles(os.isAdmin): os.isAdmin()

proc symlink*(source, destination: string) {.exportpy.} =
  os.createSymlink(source, destination)

proc hardlink*(source, destination: string) {.exportpy.} =
  os.createHardlink(source, destination)

proc env_vars_pairs*(): seq[(string, string)] {.exportpy.} =
  for item in os.envPairs(): result.add item

func parents*(path: string): string {.exportpy.} =
  parentDir(path)

func is_fs_casesensitive*(): bool {.exportpy.} =
  os.FileSystemCaseSensitive

func get_dynlib_format*(): string {.exportpy.} =
  os.DynlibFormat

proc lines*(path: string; start: int = 0; ends: int = 1): seq[string] {.exportpy.} =
  readFile(path).splitLines[start .. ^ends]

proc line*(path: string; line_number: Natural): string {.exportpy.} =
  readFile(path).splitLines[line_number]

proc counted_lines*(path: string): int {.exportpy.} =
  readFile(path).countLines

proc tokenized*(path: string): seq[tuple[token: string, isSep: bool]] {.exportpy.} =
  for item in tokenize(readFile(path)): result.add item

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

proc get_size*(path: string): BiggestInt {.exportpy.} =
  getFileSize(path)

template divmod(a, b): array[2, int] =
  [int(int(a) / int(b)), int(a mod b)]

template abytes(stringy: var string; unit: static[string]) =
  when len(unit) > 0:
    stringy.add unit # "SOMETHINGbytes"
    stringy.add 'b'
  else:
    stringy.add 'B'  # Just "Bytes"
  stringy.add 'y'
  stringy.add 't'
  stringy.add 'e'
  stringy.add 's'
  stringy.add ' '

template bytes2human(integer_bytes: int64; result: var string) =
  var bite, kilo, mega, giga, tera, peta, exa, zetta, yotta: int64
  (kilo, bite) = divmod(integer_bytes, int64(1_024))
  (mega, kilo) = divmod(kilo, int64(1_024))
  (giga, mega) = divmod(mega, int64(1_024))
  (tera, giga) = divmod(giga, int64(1_024))
  (peta, tera) = divmod(tera, int64(1_024))
  (exa, peta) = divmod(peta, int64(1_024))
  (zetta, exa) = divmod(exa, int64(1_024))
  (yotta, zetta) = divmod(zetta, int64(1_024))
  var thisByteUnit = newStringOfCap(80)
  if unlikely(zetta > 0):
    thisByteUnit = $zetta
    abytes(thisByteUnit, "Zetta")
    result.add thisByteUnit
  if unlikely(exa > 0):
    thisByteUnit = $exa
    abytes(thisByteUnit, "Exa")
    result.add thisByteUnit
  if unlikely(peta > 0):
    thisByteUnit = $peta
    abytes(thisByteUnit, "Peta")
    result.add thisByteUnit
  if tera > 0:
    thisByteUnit = $tera
    abytes(thisByteUnit, "Tera")
    result.add thisByteUnit
  if giga > 0:
    thisByteUnit = $giga
    abytes(thisByteUnit, "Giga")
    result.add thisByteUnit
  if mega > 0:
    thisByteUnit = $mega
    abytes(thisByteUnit, "Mega")
    result.add thisByteUnit
  if kilo > 0:
    thisByteUnit = $kilo
    abytes(thisByteUnit, "Kilo")
    result.add thisByteUnit
  result.add $bite
  abytes(result, "")

proc get_size_human*(path: string): string {.exportpy.} =
  bytes2human(getFileSize(path), result)

proc is_hidden_path*(path: string) : bool {.exportpy.} =
  isHidden(path)

func is_valid_path*(path: string) : bool {.exportpy.} =
  isValidFilename(path)

proc get_md5*(path: string): string {.exportpy.} =
  md5.getMD5(readFile(path))

proc get_sha1*(path: string): string {.exportpy.} =
  $secureHashFile(path)

proc copy_file_permissions*(source, dest: string; ignore_errors: bool = true) {.exportpy.} =
  copyFileWithPermissions(source, dest, ignore_errors)

proc copy_dir_permissions*(source, dest: string; ignore_errors: bool = true) {.exportpy.} =
  copyDirWithPermissions(source, dest, ignore_errors)

func fromFilePermissions(perm: set[FilePermission]): uint {.inline.} =
  if fpUserExec in perm:    inc result, 0o100  # User
  if fpUserWrite in perm:   inc result, 0o200
  if fpUserRead in perm:    inc result, 0o400
  if fpGroupExec in perm:   inc result, 0o010  # Group
  if fpGroupWrite in perm:  inc result, 0o020
  if fpGroupRead in perm:   inc result, 0o040
  if fpOthersExec in perm:  inc result, 0o001  # Others
  if fpOthersWrite in perm: inc result, 0o002
  if fpOthersRead in perm:  inc result, 0o004

proc get_file_info*(path: string; follow_symlinks: bool = true): tuple[size, link_count, block_size, permissions: int64] {.exportpy.} =
  let f = os.getFileInfo(path, follow_symlinks)
  result = (
    size: int64(f.size), link_count: int64(f.linkCount - 1),
    block_size: int64(when compiles(f.blockSize): f.blockSize else: 0),
    permissions: int64(fromFilePermissions(f.permissions)),  # Permissions are Octal Unix.
  )

proc get_file_times_iso*(path: string; follow_symlinks: bool = true): tuple[last_access, last_write, creation: string] {.exportpy.} =
  let f = os.getFileInfo(path, follow_symlinks)
  result = (last_access: $f.lastAccessTime, last_write: $f.lastWriteTime, creation: $f.creationTime)

proc get_file_times_unix*(path: string; follow_symlinks: bool = true): tuple[last_access, last_write, creation: int64] {.exportpy.} =
  let f = os.getFileInfo(path, follow_symlinks)
  result = (last_access: toUnix(f.lastAccessTime), last_write: toUnix(f.lastWriteTime), creation: toUnix(f.creationTime))

proc walk*(folderpath: string; extensions: seq[string] = @[""]; followlinks : bool = false; yieldfiles: bool = true; debugs: bool = false; check_folders: bool = false; prealloc: Positive = 99): seq[string] {.exportpy.} =
  result = newSeqOfCap[string](prealloc)
  let extused {.noalias.} = create bool
  extused[] = extensions != @[""] and extensions.len > 0
  for item in walkDirRec(folderpath, {if yieldfiles: pcFile else: pcDir}, {if followlinks: pcLinkToDir else: pcDir}, checkDir = check_folders):
    if unlikely(debugs): echo item
    if unlikely(extused[]):
      for ext in extensions:
        if item.normalize.endsWith(ext): result.add absolutePath(item)
    else: result.add absolutePath(item)
  if extused != nil: dealloc extused

proc walk_glob*(globpattern: string; prealloc: Positive = 99): seq[string] {.exportpy.} =
  result = newSeqOfCap[string](prealloc)
  for item in walkPattern(globpattern): result.add absolutePath(item)

proc walk_simple*(folderpath: string; relative: bool = false; check_folders: bool = false; prealloc: Positive = 99): seq[string] {.exportpy.} =
  result = newSeqOfCap[string](prealloc)
  for item in walkDirRec(folderpath, relative=relative, checkDir=check_folders): result.add absolutePath(item)

proc walk_folders*(globpattern: string; prealloc: Positive = 99): seq[string] {.exportpy.} =
  result = newSeqOfCap[string](prealloc)
  for item in walkDirs(globpattern): result.add absolutePath(item)

proc walk_files*(globpattern: string; prealloc: Positive = 99): seq[string] {.exportpy.} =
  result = newSeqOfCap[string](prealloc)
  for item in walkFiles(globpattern): result.add absolutePath(item)

proc parseBool(s: string): bool {.inline.} =
  case s
  of "y", "Y", "1",  "ON", "On", "oN", "on",
     "yes", "YES", "YEs", "YeS", "Yes", "yES", "yEs", "yeS",
     "TRUE", "TRUe", "TRuE", "TRue", "TrUE", "TrUe", "TruE", "True", "tRUE",
     "tRUe", "tRuE", "tRue", "trUE", "trUe", "truE", "true": result = true
  of "n", "N", "0", "NO", "No", "nO", "no", "",
     "OFF", "OFf", "OfF", "Off", "oFF", "oFf", "ofF", "off",
     "FALSE", "FALSe", "FALsE", "FALse", "FAlSE", "FAlSe", "FAlsE", "FAlse",
     "FaLSE", "FaLSe", "FaLsE", "FaLse", "FalSE", "FalSe", "FalsE", "False",
     "fALSE", "fALSe", "fALsE", "fALse", "fAlSE", "fAlSe", "fAlsE", "fAlse",
     "faLSE", "faLSe", "faLsE", "faLse", "falSE", "falSe", "falsE", "false": result = false
  else: doAssert false, "cannot interpret as a bool"

func strip(s: var string) =
  var first = 0
  var last = s.high
  while first <= last  and s[first] in {' ', '\t'}: inc first
  while last  >= first and s[last]  in {' ', '\t'}: dec last
  if unlikely(first > last):
    s.setLen 0
    return
  template impl =
    for index in first .. last: s[index - first] = s[index]
  if first > 0:
    when nimvm: impl()
    else:
      when not declared(moveMem): impl()
      else:
        when defined(nimSeqsV2) and declared(prepareMutation): prepareMutation(s)
        moveMem(addr s[0], addr s[first], last - first + 1)
  s.setLen last - first + 1

func validateKey(s: string): bool {.inline.} =
  result = true
  for c in s:
    if c notin {'a'..'z', 'A'..'Z', '0'..'9', '_'}: return false

proc dotenv*(path: string): string {.exportpy.} =
  var s = readFile(path)
  var temp = newJObject()
  if likely(s.len > 1):
    for zz in s.split('\n'):        # Split by lines
      var z = zz                    # k= is the shortest possible
      strip(z)
      if z.len > 1 and z[0] != '#': # No comment lines, no empty lines
        let k_v = z.split('=')
        if k_v.len >= 2:            # k sep v
          var k = k_v[0]            # Key name
          strip(k)
          doAssert validateKey(k), "DotEnv key must be a non-empty ASCII string ([a-zA-Z0-9_])"
          var v = k_v[1].split('#')[0] # remove inline comments
          strip(v)
          var tipe = k_v[^1].split('#')[1]  # Get type annotation
          strip(tipe)
          if k.len > 0:   # k must not be empty string
            case tipe
            of "bool":   temp.add k, newJBool(parseBool(v))
            of "string": temp.add k, newJString(v)
            of "json":   temp.add k, parseJson(v)
            of "int":
              var i = 0
              discard parseSaturatedNatural(v, i)
              temp.add k, newJInt(i)
            of "float":
              var f = 0.0
              discard parseFloat(v, f)
              temp.add k, newJFloat(f)
            else: doAssert false, "Type must be 1 of int, float, bool, string, json"
  result = temp.pretty
