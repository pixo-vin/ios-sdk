codesign() {
  echo "Code signing $1 with identity: ${EXPANDED_CODE_SIGN_IDENTITY_NAME}"
  /usr/bin/codesign --force --sign ${EXPANDED_CODE_SIGN_IDENTITY} --preserve-metadata=identifier,entitlements "$1"
}

strip() {
    if ! [[ "$(file "$1")" == *"dynamically linked shared library"* ]]; then
      echo "Skipping non-dynamic library $1"
      return 0
    fi

    archs="$(lipo -info "$1" | rev | cut -d ':' -f1 | rev)"
    stripped_archs=""
    for arch in $archs; do
      if ! [[ "${VALID_ARCHS}" == *"$arch"* ]]; then
        lipo -remove "$arch" -output "$1" "$1" || exit 1
        stripped_archs="$stripped_archs $arch"
      fi
    done
    if [[ "$stripped_archs" != "" ]]; then
      echo "Stripped $1"
      if [ "${CODE_SIGNING_REQUIRED}" == "YES" ]; then
        codesign "$1"
      fi
    fi
}

echo "Stripping frameworks"
cd "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}"

for file in $(find . -type f -perm +111); do
  strip "${file}"
done
