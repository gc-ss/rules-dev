# Rules Development

Rule Development Workspace

## Requirements

The following tools need to be available on your system:

 * Python 3.6+
 * GNU Make
 * [OPA](https://www.openpolicyagent.org/docs/latest/#1-download-opa)
 * [Regula](https://regula.dev/getting-started.html#installation)

This has been tested on MacOS and should also work fine on Linux. If working on
Windows, you may have the best results using the Windows Subsystem for Linux (WSL).

## Generating Rule Skeletons

Run the following to generate rule and test skeletons for all rules declared in
[metadata.yaml](./metadata.yaml).

```
make gen
```

As you can see in the Makefile, this uses the script [generate.py](./bin/generate.py).
