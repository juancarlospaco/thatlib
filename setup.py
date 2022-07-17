import setuptools
from nimporter import get_nim_extensions, WINDOWS, MACOS, LINUX

setuptools.setup(
  name             = 'thatlib',
  install_requires = ['nimporter'],
  py_modules       = ['thatlib.py'],
  ext_modules      = get_nim_extensions(platforms = (WINDOWS, LINUX, MACOS)),
)
