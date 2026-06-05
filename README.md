# Asserts
A few asserts scripts.

---

## Release

`0.1.0`
| [GitHub](https://github.com/StanleyProjects/Asserts/releases/tag/0.1.0)
| [Key](https://StanleyProjects.github.io/release-public.pem)

### Build and Install

```
$ ./assemble.sh \
 && ./src/test/bash/unit_test.sh \
 && unzip -d /opt/Asserts-0.1.0 ./build/zip/Asserts-0.1.0.zip
```

### Download and Install

```
$ TMP_PATH="$(mktemp)"; \
 curl -L 'https://github.com/StanleyProjects/Asserts/releases/download/0.1.0/Asserts-0.1.0.zip' \
  -o "${TMP_PATH}" && unzip -d /opt/Asserts-0.1.0 "${TMP_PATH}" && rm "${TMP_PATH}"
```

---
