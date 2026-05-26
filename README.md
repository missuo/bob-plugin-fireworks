# bob-plugin-fireworks

A [Bob](https://bobtranslate.com/) translation plugin powered by [Fireworks AI](https://fireworks.ai/), defaulting to Moonshot's Kimi K2.6 Turbo via the Fireworks router.

## Features

- Streaming output for real-time translation
- Four modes: Translation, Polishing, Q&A, and Custom Prompt
- Five translation styles: Default, Formal, Casual, Literal, and Natural
- Fine-grained control over model reasoning, with thinking disabled by default for low-latency translation
- Optional custom model override for users who wish to route to a different Fireworks model

## Installation

1. Install [Bob](https://apps.apple.com/cn/app/id1630034110#?platform=mac) for macOS.
2. Download the latest `.bobplugin` from the [Releases](https://github.com/missuo/bob-plugin-fireworks/releases) page.
3. Double-click the downloaded file to install it into Bob.
4. Obtain a Fireworks API key from the [Fireworks Dashboard](https://fireworks.ai/account/api-keys) and paste it into the plugin settings.

## Configuration

| Option | Description |
| --- | --- |
| **API URL** | Fireworks inference endpoint. Defaults to `https://api.fireworks.ai/inference/v1` and rarely needs to be changed. |
| **API Key** | Your Fireworks API key (begins with `fpk_`). |
| **Model** | Choose between the bundled `Kimi K2.6 Turbo` or `Custom`. Fire Pass subscribers should keep the default, since Kimi K2.6 Turbo is already covered by the plan. |
| **Custom Model** | The fully-qualified Fireworks model identifier, used only when **Model** is set to `Custom`. Note that custom models are billed at the standard Fireworks per-token rate and are not covered by Fire Pass. |
| **Mode** | The operating mode: Translation, Polishing, Q&A, or Custom. |
| **Translation Style** | Tone preset applied in Translation mode only. |
| **Custom Prompt** | A free-form system prompt, used only when **Mode** is set to `Custom`. |
| **Thinking** | Whether the model should produce a reasoning trace. Disabled by default; recommended for translation workloads where latency and cost matter more than depth of analysis. |
| **Reasoning Effort** | The depth of reasoning to apply when **Thinking** is enabled. Has no effect when thinking is disabled. |

### A note on Thinking and Reasoning Effort

On Fireworks, `reasoning_effort` and "thinking" describe the same underlying capability. Setting **Thinking** to `Disabled` is equivalent to sending `reasoning_effort: "none"`, which suppresses the reasoning trace entirely. For translation, this typically reduces both latency and token consumption by an order of magnitude, which is why it is the default in this plugin.

## Development

```bash
npm install
npm run build           # compile TypeScript with esbuild into build/
zip -j -r dist/bob-plugin-fireworks.bobplugin build/*   # package locally
```

Tagged releases are produced automatically by GitHub Actions. Push a SemVer tag (for example, `v1.0.2`) to the `main` branch and the workflow will build the `.bobplugin`, attach it to a GitHub Release, and update `appcast.json` so that existing installations can pick up the new version through Bob's update mechanism.

## License

GPL-3.0 © [Vincent Young](https://github.com/missuo)
