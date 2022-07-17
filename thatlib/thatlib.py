import nimporter
import thatlibcore

def cwd():
  return thatlibcore.getCurrentDir()

def home():
  return thatlibcore.home()

def mkdir(path):
  return thatlibcore.mkdir(path)

def rmdir(path, check = False):
  return thatlibcore.rmdir(path, check)

def is_file(path):
  return thatlibcore.is_file(path)

def is_dir(path):
  return thatlibcore.is_dir(path)

def exists(path):
  return thatlibcore.exists(path)

def rename(source, destination):
  return thatlibcore.rename(source, destination)

def replace(source, destination):
  return thatlibcore.replace(source, destination)

def resolve(path):
  return thatlibcore.resolve(path)

def absolute(path):
  return thatlibcore.absolute(path)

def samefile(pathA, pathB):
  return thatlibcore.samefile(pathA, pathB)

def is_absolute(path):
  return thatlibcore.is_absolute(path)

def joinpath(paths):
  return thatlibcore.joinpath(paths)

def with_suffix(path, ext):
  return thatlibcore.with_suffix(path, ext)

def with_stem(path, stem):
  return thatlibcore.with_stem(path, stem)

def with_name(path, name):
  return thatlibcore.with_name(path, name)

def suffix(path):
  return thatlibcore.suffix(path)

def stem(path):
  return thatlibcore.stem(path)

def parent(path):
  return thatlibcore.parent(path)

def write_bytes(path, data):
  return thatlibcore.write_bytes(path, data)

def read_bytes(path):
  return thatlibcore.read_bytes(path)

def is_relative_to(path, base):
  return thatlibcore.is_relative_to(path, base)

def expanduser(path):
  return thatlibcore.expanduser(path)

def as_uri(path):
  return thatlibcore.as_uri(path)

def parts(path):
  return thatlibcore.parts(path)

def chmod(path, permissions):
  return thatlibcore.chmod(path, permissions)


# ^ API mimic from Python "pathlib" ################################## v Extras


def is_root():
  return thatlibcore.is_root()

def symlink(source, destination):
  return thatlibcore.symlink(source, destination)

def hardlink(source, destination):
  return thatlibcore.hardlink(source, destination)

def env_vars_pairs():
  return thatlibcore.env_vars_pairs()

def parents(path):
  return thatlibcore.parents(path)

def is_fs_casesensitive():
  return thatlibcore.is_fs_casesensitive()

def get_dynlib_format():
  return thatlibcore.get_dynlib_format()

def lines(path, start = 0, ends = 1):
  return thatlibcore.lines(path, start, ends)

def line(path, line_number):
  return thatlibcore.line(path, line_number)

def counted_lines(path):
  return thatlibcore.counted_lines(path)

def tokenized(path):
  return thatlibcore.tokenized(path)

def replaced(path, replacements):
  return thatlibcore.replaced(path, replacements)

def normalized(path):
  return thatlibcore.normalized(path)

def is_root_dir(path):
  return thatlibcore.is_root_dir(path)

def get_suffix_index(path):
  return thatlibcore.get_suffix_index(path)

def path_splitted(path):
  return thatlibcore.path_splitted(path)

def compare_paths(pathA, pathB):
  return thatlibcore.compare_paths(pathA, pathB)

def get_conf_dir():
  return thatlibcore.get_conf_dir()

def get_temporary_dir():
  return thatlibcore.get_temporary_dir()

def paths_quoted(paths):
  return thatlibcore.paths_quoted(paths)

def is_file_newer(pathA, pathB):
  return thatlibcore.is_file_newer(pathA, pathB)

def symlink_exists(path):
  return thatlibcore.symlink_exists(path)

def get_exe(path, followSymlinks = True):
  return thatlibcore.get_exe(path, followSymlinks)

def mksymlink(source, destination):
  return thatlibcore.mksymlink(source, destination)

def get_symlink(path):
  return thatlibcore.get_symlink(path: string)

def try_rmfile(path):
  return thatlibcore.try_rmfile(path)

def exists_create_dir(path):
  return thatlibcore.exists_create_dir(path)

def mkhardlink(source, destination):
  return thatlibcore.mkhardlink(source, destination)

def get_size(path):
  return thatlibcore.get_size(path)

def get_size_human(path):
  return thatlibcore.get_size_human(path)

def is_hidden_path(path):
  return thatlibcore.is_hidden_path(path)

def is_valid_path(path):
  return thatlibcore.is_valid_path(path)

def get_md5(path):
  return thatlibcore.get_md5(path)

def get_sha1(path):
  return thatlibcore.get_sha1(path)

def copy_file_permissions(source, dest, ignore_errors = True)
  return thatlibcore.copy_file_permissions(source, dest, ignore_errors)

def copy_dir_permissions(source, dest, ignore_errors = True)
  return thatlibcore.copy_dir_permissions(source, dest, ignore_errors)

def get_file_info(path, follow_symlinks = True):
  return thatlibcore.get_file_info(path, follow_symlinks)

def get_file_times_iso(path, follow_symlinks = True):
  return thatlibcore.get_file_times_iso(path, follow_symlinks)

def get_file_times_unix(path, follow_symlinks = True):
  return thatlibcore.get_file_times_unix(path, follow_symlinks)

def walk(folderpath; extensions = [], followlinks = False, yieldfiles = True, debugs = False, check_folders = False, prealloc = 99):
  return thatlibcore.walk(folderpath, extensions, followlinks, yieldfiles, debugs, check_folders, prealloc)

def walk_glob(globpattern, prealloc = 99):
  return thatlibcore.walk_glob(globpattern, prealloc)

def walk_simple(folderpath, relative = False, check_folders = False, prealloc = 99):
  return thatlibcore.walk_simple(folderpath, relative, check_folders, prealloc)

def walk_folders(globpattern, prealloc = 99):
  return thatlibcore.walk_folders(globpattern, prealloc)

def walk_files(globpattern, prealloc = 99):
  return thatlibcore.walk_files(globpattern, prealloc)

def dotenv(path):
  return thatlibcore.dotenv(path)
