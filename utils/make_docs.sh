#!/bin/sh

PATH=$PATH:"/c/Program Files (x86)/NaturalDocs-1.52"
NATURALDOCS=`which NaturalDocs 2>/dev/null`

if [ -z "$NATURALDOCS" ]
then
  echo "Could not find NaturalDocs in the PATH. Install it or adjust the PATH environment variable."
  exit 1
fi

echo -e "\n=== Compiling documentation ===\n"
if [ ! -d ../store/function_library ]
then
  mkdir ../store/function_library
fi

"$NATURALDOCS" -i "../addons" -o HTML "../store/function_library" -p "ndocs-project" -s Default alive -r

echo -e "\n=== Packaging documentation ===\n"
cd ../store
rm -f function_library.tar
tar -cf function_library.tar function_library

exit 0
