# opencode

This is a container image that contains OpenCode and additional software that I
use for development. [OpenCode](https://opencode.ai/) is the open source AI
coding agent that works with numerous LLM providers.

## Supported tags and respective `Dockerfile` links

- [`latest`](https://github.com/cavcrosby/opencode/blob/main/Dockerfile)

## How to use this image

### With [microsandbox](https://microsandbox.dev/)

Since the size of this image is expected to be rather large (talking greater
than 2 GB), it's recommended to build and load the image locally. microsandbox
provides instructions on how todo this in their associated
[guide](https://docs.microsandbox.dev/examples/docker/local-images#local-registry-alternative).

```shell
temp_dir_path="$(mktemp --directory)"
printf "\nOpenCode's scratch directory: %s\n" "${temp_dir_path}"
sleep 5

msb run --tty --net-default "deny" --net-rule "allow@public:tcp:443" --net-rule "allow@private:tcp:443" --net-rule "allow@dns" --net-rule "allow@192.168.0.0/16" --mount-file "${HOME}/.config/opencode/opencode.json:/home/opencode/.config/opencode/opencode.json" --mount-dir "${temp_dir_path}:/mnt" --memory "2G" "cavcrosby/opencode:latest"
```

## License

See LICENSE.
