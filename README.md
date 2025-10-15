# Apocalypse Now: Desire and Will

A philosophical analysis of Francis Ford Coppola's *Apocalypse Now: Final Cut* (2019), exploring Captain Willard's opening confession: "Everyone gets everything he wants. I wanted a mission, and for my sins they gave me one."

**[📄 Read the Full Essay (PDF)](./apocalypse-now-desire-and-will.pdf)**

## AI Authorship

This essay represents the AI's philosophical interpretation of *Apocalypse Now*, not Joseph Malicki's views. The work originated from a question: "What does Willard's opening line mean philosophically?" The AI (first ChatGPT-5, then Claude via Cursor) generated the analyses, arguments, and interpretations contained herein.

Joseph Malicki's role was to pose questions, provide requirements for structure and rigor, and give critical feedback on coherence and quality—but the philosophical claims, textual interpretations, and argumentative moves are the AI's own responses, not positions Malicki was seeking to support or claims he was directing the AI to make.

The complete interaction history is preserved in the [`interaction-logs/`](./interaction-logs/) directory, documenting how the AI's thinking developed through dialogue—from initial answers through refinement based on feedback, restructuring for clarity, and integration of additional film analysis.

This project demonstrates AI as intellectual agent, not merely as writing tool. See [Appendix A](./apocalypse-now-desire-and-will.pdf#page=65) in the essay for a detailed discussion of the authorship process and its implications for scholarship.

## Essay Structure

The essay examines Willard's confession through seven major lenses:

1. **Introduction**: The paradox of fulfilled desire
2. **Conrad**: *Heart of Darkness* as structural template
3. **Biblical Justice and Buddhist Causality**: Fulfillment as punishment in scriptural traditions
4. **Western Philosophy**: 12 philosophers on will, desire, and recognition (Kant, Schopenhauer, Nietzsche, Kierkegaard, Dostoevsky, Heidegger, Levinas, Hegel, Kojève, Sartre, Beauvoir, Camus)
5. **Colonial Modernity**: Critical theory perspectives (Weber, Adorno & Horkheimer, Foucault, Said & Fanon, Benjamin, Arendt)
6. **Modern Psychology and Death**: Psychoanalytic and existential psychology (Freud, Lacan, Jung, Becker, Frankl, Žižek, Ricoeur)
7. **Conclusion**: The extinction of desire

Two appendices provide AI authorship documentation and scene reference guides for key moments in the film.

## Requirements

- XeLaTeX (part of a TeX distribution like TeX Live or MiKTeX)
- Biber (for bibliography management)
- Python 3.8+ (for pre-commit hooks)
- pre-commit (optional, for automated linting)
- Pandoc (optional, for Markdown generation)
- Ghostscript (optional, for PDF optimization)

## Building the Document

### Full Compilation

To compile the essay with bibliography and all optimizations:

```bash
make
```

This produces:
- `apocalypse-now-desire-and-will.pdf` (optimized for viewing)
- `apocalypse-now-desire-and-will.md` (Markdown version for web preview)

### Other Make Targets

- `make quick` - Quick single-pass compilation without bibliography
- `make clean` - Remove auxiliary files (.aux, .log, etc.)
- `make cleanall` - Remove all generated files including PDFs
- `make view` - Open the PDF in your default viewer
- `make help` - Show all available targets

## Project Structure

```
.
├── apocalypse-now-desire-and-will.pdf    # Main output (68 pages)
├── apocalypse-now-desire-and-will.md     # Markdown version
├── paper/                                # LaTeX source files
│   ├── main.tex                          # Main document
│   ├── everyone.bib                      # Bibliography (60+ entries)
│   ├── Section_I_Intro_content.tex       # Introduction
│   ├── Section_II_Conrad_content.tex     # Conrad analysis
│   ├── Section_VII_Conclusion_content.tex # Conclusion
│   ├── Appendix_AI_Authorship.tex        # AI authorship explanation
│   ├── Appendix_Scene_Reference.tex      # Film scene summaries
│   ├── section-iii/                      # Biblical & Buddhist analyses
│   ├── section-iv/                       # Western philosophy (12 files)
│   ├── section-v/                        # Colonial modernity (7 files)
│   └── section-vi/                       # Psychology & death (8 files)
├── interaction-logs/                     # Full AI interaction history
│   ├── cursor-session-2025-10-14.md      # Claude/Cursor session
│   └── OpenAI-ChatGPT.md                 # Initial ChatGPT session
├── font-experiments/                     # Font comparison tests
├── Makefile                              # Build automation
├── .github/workflows/                    # CI/CD (LaTeX linting, PDF checks)
├── .pre-commit-config.yaml               # Pre-commit hooks
├── .gitignore                            # Git ignore patterns
└── README.md                             # This file
```

## Development Workflow

### Git Pre-commit Hooks

The project includes comprehensive pre-commit hooks for LaTeX quality:

```bash
# Install pre-commit (if not already installed)
pip install pre-commit

# Install the git hooks
pre-commit install

# (Optional) Run hooks on all files
pre-commit run --all-files
```

Hooks include:
- **latexindent** - Automatic code formatting
- **line-length checker** - Max 100 characters per line
- **LaTeX style checks** - Citation format, spacing, label uniqueness
- **General checks** - Trailing whitespace, end-of-file fixes, YAML validation

### GitHub Actions CI

Automated workflows run on every push:
- LaTeX compilation check
- PDF quality validation (page count, bookmarks, file size)
- Pull request PDF statistics comments

## Citation Philosophy

All citations link to their bibliography entries. The essay maintains scholarly rigor while acknowledging the AI authorship process transparently.

## Contributing

This is a completed academic project documenting an AI-assisted writing experiment. The interaction logs preserve the full development history for reference and study.

## License

This work is provided for academic and educational purposes. All film references are used under fair use for critical analysis.
