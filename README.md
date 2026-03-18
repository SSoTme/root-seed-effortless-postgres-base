# Effortless Bases

A seed repository that transforms any Airtable base into a complete, synchronized tech stack using the [Effortless](https://github.com/eejai42/effortless-rulebooks) toolchain.

## The Core Idea

**Change one thing, everything follows.**

This project treats your Airtable base as the single source of truth for business intent. That intent flows through an intermediate representation (`effortless-rulebook.json`) and materializes into:

- PostgreSQL schemas and migrations
- Documentation
- Any other execution substrate you need

The same pattern powers the [effortless-rulebooks](https://github.com/eejai42/effortless-rulebooks) project, which generates 13 execution substrates (Python, English, Go, RDF/OWL/SHACL, XLSX, ARM64 assembler, COBOL, and more) from a single definition.

## How It Works

```
┌─────────────┐      airtable-to-rulebook      ┌─────────────────────┐
│   Airtable  │ ─────────────────────────────► │ effortless-rulebook │
│    Base     │ ◄───────────────────────────── │       .json         │
└─────────────┘      rulebook-to-airtable      └─────────────────────┘
                                                          │
                     ┌────────────────────────────────────┼────────────────────────────────────┐
                     │                                    │                                    │
                     ▼                                    ▼                                    ▼
          ┌──────────────────┐                 ┌──────────────────┐                 ┌──────────────────┐
          │  rulebook-to-    │                 │  rulebook-to-    │                 │  rulebook-to-    │
          │    postgres      │                 │      docs        │                 │      ...         │
          └──────────────────┘                 └──────────────────┘                 └──────────────────┘
                     │                                    │                                    │
                     ▼                                    ▼                                    ▼
             /postgres/*                           /docs/*                              (your target)
```

### The Transformations

| Command | Description |
|---------|-------------|
| `airtable-to-rulebook` | Exports your Airtable base to `effortless-rulebook.json` |
| `rulebook-to-airtable` | Pushes rulebook changes back to Airtable (for AI/agent workflows) |
| `rulebook-to-postgres` | Generates PostgreSQL schema, migrations, and queries |
| `rulebook-to-docs` | Generates documentation from your business rules |

### Bidirectional Sync

The magic is in the round-trip capability:

1. **Airtable → Rulebook**: Your team edits in Airtable's familiar UI. Changes flow downstream automatically.

2. **Rulebook → Airtable**: AI agents or automated processes can modify `effortless-rulebook.json`. On demand, those changes push back to Airtable, which resumes as the (now fully informed) single source of truth.

This means Claude, or any agent, can reason about and modify your business rules programmatically—then sync those changes back to where your team works.

## Installation

```bash
# Clone this seed repository
$ effortless -cloneseed

# Select "effortless-rulebook" from the menu
# You'll be prompted for:
#   - base-id: Your Airtable base ID (e.g., appF5XTR7XzrfTgqs)
#   - project-name: Lowercase project identifier
#   - project-name-title: Human-readable project title
```

## Usage

```bash
# Build/rebuild everything from your Airtable base
$ ./build.sh
```

This single command:
1. Pulls the current state from Airtable
2. Generates the intermediate rulebook
3. Propagates changes to PostgreSQL, docs, and all other targets

Run it whenever your Airtable base evolves. Your entire stack stays synchronized.

## Airtable Authentication

The build process requires an Airtable Personal Access Token (PAT) to access your base.

### Setup

1. **Create a PAT** at [airtable.com/create/tokens](https://airtable.com/create/tokens)
   - Add scope: `data.records:read` (and `data.records:write` if using `rulebook-to-airtable`)
   - Grant access to your specific base

2. **Set the environment variable**:
   ```bash
   export AIRTABLE_API_KEY="patXXXXXXXXXXXXXX"
   ```

   Or add to your shell profile (`~/.bashrc`, `~/.zshrc`):
   ```bash
   export AIRTABLE_API_KEY="patXXXXXXXXXXXXXX"
   ```

3. **Run the build**:
   ```bash
   ./build.sh
   ```

The `build.sh` script temporarily injects the key into `ssotme.json` during the build, then restores the placeholder afterward. This keeps credentials out of version control.

## Configuration

The `ssotme-seed.json` defines the configurable parameters:

| Parameter | Description |
|-----------|-------------|
| `base-id` | Your Airtable base ID |
| `project-name` | Lowercase project identifier |
| `project-name-title` | Display name for the project |
| `view` | Airtable view to export (default: "Grid view") |

**The key insight**: Swap out `base-id` and you have an entirely different application. The entire tech stack reconfigures itself around your new source of truth.

## Related Projects

- [effortless-rulebooks](https://github.com/eejai42/effortless-rulebooks) - The reference implementation generating 13 execution substrates from a single definition

## License

See [LICENSE](LICENSE) for details.
