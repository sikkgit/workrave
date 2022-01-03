string(REPLACE "/" "\\" INSTALL_WIN_PATH "${INSTALL_PATH}")

set(LIBS_ISS "${DIST_PATH}/libraries.iss")

file(WRITE ${LIBS_ISS} "; 64 bit\n")
file(GLOB FILES64BIT "${INSTALL_PATH}/lib/*.dll")
foreach(file ${FILES64BIT})
  get_filename_component(file ${file} NAME)
  if (${file} MATCHES "applet.*\\.dll$")
    set(flags "${flags} restartreplace uninsrestartdelete regserver; Components: applet")
  endif()
  if (${file} MATCHES "^harpoon64\\.dll$")
    set(flags "${flags} recursesubdirs restartreplace uninsrestartdelete")
  endif()
  file(APPEND ${LIBS_ISS} "Source: \"${INSTALL_WIN_PATH}\\lib\\${file}\"; DestDir: \"{app}\\lib\"; Flags: ignoreversion ${flags};\n")
endforeach()

file(APPEND ${LIBS_ISS} "\n; 32 bit\n")
file(GLOB FILES32BIT "${INSTALL_PATH}/lib32/*.*")
foreach(file ${FILES32BIT})
  get_filename_component(file ${file} NAME)
  set(flags "ignoreversion 32bit")
  if (${file} MATCHES "applet.*\\.dll$")
    set(flags "${flags} restartreplace uninsrestartdelete regserver; Components: applet")
  endif()
  if (${file} MATCHES "^harpoon\\.dll$")
    set(flags "${flags} restartreplace uninsrestartdelete")
  endif()
  if (${file} MATCHES "^WorkraveHelper.exe$")
    set(flags "${flags} restartreplace uninsrestartdelete regserver")
  endif()
  file(APPEND ${LIBS_ISS} "Source: \"${INSTALL_WIN_PATH}\\lib32\\${file}\"; DestDir: \"{app}\\lib32\"; Flags: ${flags};\n")
endforeach()