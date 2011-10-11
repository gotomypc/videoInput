from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

setup(
    name = "videoInput",
    version = "0.0.1",
    ext_modules = [Extension(
      "videoInput",
      ["videoInput.pyx", "../libs/videoInput/videoInput.cpp"],
      language="c++",
      include_dirs=["../libs/DShow/Include", "../libs/videoInput"],
      library_dirs=["../libs/DShow/lib"],
      libraries=["ole32", "oleaut32", "strmbasd", "uuid"]
      )],
    cmdclass={"build_ext": build_ext})
