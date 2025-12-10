# Environment Variables

Below is a table of the current environment variables for the project. Example values can be found inside of `.envrc.example`.

| Name                     | Description                                                           | Default      | Type   | Notes                                                                                                                                                                 |
|--------------------------|-----------------------------------------------------------------------|--------------|--------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| NVIM_COLOR_SCHEME        | Set the colour scheme used in the editor on startup.                  | "tokyonight" | string | In the case that the colour scheme cannot be applied, the default "tokyonight" theme is applied instead.                                                              |
| NVIM_DEBUG_RUST_BINARY   | The name of the Rust binary to use when debugging a Rust project.     | N/A          | string | The binary must be inside of "/target/debug". If this value is not set, the user will instead be prompted to manually provide the name when starting a debug session. |
| NVIM_PROJECT_CONFIG_NAME | The name of a lua module to load from "/lua/myconfig/projectconfigs". | N/A          | string | The lua module must export a "setup" function in order to be loaded.                                                                                                  |

