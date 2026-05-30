# Asserts
A few asserts scripts.

---

## Release

`0.0.9`
| [GitHub](https://github.com/StanleyProjects/Asserts/releases/tag/0.0.9)
| [Key](https://StanleyProjects.github.io/release-public.pem)

### Build and Install

```
$ ./assemble.sh \
 && ./src/test/bash/unit_test.sh \
 && unzip -d /opt/Asserts-0.0.9 ./build/zip/Asserts-0.0.9.zip
```

### Download and Install

```
$ TMP_PATH="$(mktemp)"; \
 curl -L 'https://github.com/StanleyProjects/Asserts/releases/download/0.0.9/Asserts-0.0.9.zip' \
  -o "${TMP_PATH}" && unzip -d /opt/Asserts-0.0.9 "${TMP_PATH}" && rm "${TMP_PATH}"
```

---
