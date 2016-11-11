@test "node is the correct version" {
  run docker run smizy/nodejs:${TAG} node -v
  [ $status -eq 0 ]
  [ "${lines[0]:0:5}" = "v${VERSION}" ]
}