@test "node is the correct version" {
  run docker run --entrypoint "node" smizy/nodejs:${TAG} -v
  [ $status -eq 0 ]
  [ "${lines[0]:0:6}" = "v${VERSION}" ]
}