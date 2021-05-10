rm --verbose --force dist/*.zip
rm --verbose --force --recursive dist/thatlib/
rm --verbose --force --recursive dist/thatlib/__pycache__/
cp --verbose --recursive thatlib dist/
cd dist && zip -9 -T -v -r thatlib.zip *
