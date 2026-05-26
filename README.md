# Asserts
A few asserts scripts.

---

## Release

`0.0.6`
| [GitHub](https://github.com/StanleyProjects/Asserts/releases/tag/0.0.6)
| [Key](https://StanleyProjects.github.io/release-public.pem)

### Build and Install

```
$ ./assemble.sh \
 && ./src/test/bash/unit_test.sh \
 && unzip -d /opt/Asserts-0.0.6 ./build/zip/Asserts-0.0.6.zip
```

### Download and Install

```
$ TMP_PATH="$(mktemp)"; \
 curl -L 'https://github.com/StanleyProjects/Asserts/releases/download/0.0.6/Asserts-0.0.6.zip' \
  -o "${TMP_PATH}" && unzip -d /opt/Asserts-0.0.6 "${TMP_PATH}" && rm "${TMP_PATH}"
```

---
