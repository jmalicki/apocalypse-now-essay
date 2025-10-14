# Apocalypse Now Analysis

A philosophical analysis paper on Francis Ford Coppola's *Apocalypse Now*.

## Requirements

- XeLaTeX (part of a TeX distribution like TeX Live or MiKTeX)
- Biber (for bibliography management)
- Python 3 (for pre-commit hooks)
- pre-commit (optional, for automated linting)

## Setup

### Install Pre-commit Hooks (Optional but Recommended)

```bash
# Install pre-commit if you haven't already
pip install pre-commit

# Install the git hooks
pre-commit install

# (Optional) Run hooks on all files
pre-commit run --all-files
```

## Building the Document

### Full Compilation

To compile the document with bibliography:

```bash
make
```

This runs XeLaTeX and Biber in the correct sequence (3 passes total).

### Quick Compilation

For a quick single-pass compilation without updating the bibliography:

```bash
make quick
```

### Other Make Targets

- `make clean` - Remove auxiliary files (.aux, .log, etc.)
- `make cleanall` - Remove all generated files including the PDF
- `make view` - Open the PDF in your default viewer
- `make watch` - Auto-recompile when files change (requires inotify-tools)
- `make help` - Show all available targets

## Project Structure

```
.
├── paper/                    # LaTeX source files
│   ├── main.tex             # Main document file (to be created)
│   └── references.bib       # Bibliography database
├── Makefile                 # Build automation
├── .gitignore               # Git ignore patterns
├── .pre-commit-config.yaml  # Pre-commit hooks configuration
└── README.md                # This file
```

## LaTeX Linting

The pre-commit hooks include several LaTeX-specific linters:

- **latexindent** - Code formatting
- **chktex** - LaTeX semantic checker
- **pre-commit-latex-hooks** - Various LaTeX style checks

These run automatically on `git commit` if you've installed the hooks.

## Manual Commands

If you prefer to compile manually:

```bash
cd paper
xelatex -interaction=nonstopmode main.tex
biber main
xelatex -interaction=nonstopmode main.tex
xelatex -interaction=nonstopmode main.tex
```

Or from the root directory:

```bash
make
```

## License

[Add your license here]
