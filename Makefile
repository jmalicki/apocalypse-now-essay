# Makefile for LaTeX compilation with XeLaTeX and Biber
# For Apocalypse Now Analysis Paper

# Main document name (without .tex extension)
# Source file in paper/ directory
MAIN_TEX = main
# Output file names (more descriptive)
MAIN = apocalypse-now-desire-and-will

# Paper source directory
PAPER_DIR = paper

# LaTeX compiler
LATEX = xelatex
BIBTEX = biber

# Compiler flags
LATEX_FLAGS = -interaction=nonstopmode -halt-on-error -file-line-error

# Output directory
OUT_DIR = build

# Source files (including subdirectories)
TEX_FILES = $(shell find $(PAPER_DIR) -name '*.tex')
BIB_FILES = $(wildcard $(PAPER_DIR)/*.bib)

.PHONY: all clean cleanall view help watch markdown optimize-pdf

# Default target
all: $(MAIN).pdf

# Full compilation with bibliography (using latexmk for automatic dependency handling)
$(MAIN).pdf: $(TEX_FILES) $(BIB_FILES)
	@echo "==> Compiling with latexmk (auto-detects passes needed)..."
	@cd $(PAPER_DIR) && latexmk -xelatex -bibtex -interaction=nonstopmode -halt-on-error $(MAIN_TEX).tex
	@echo "==> Generating Google Books page links..."
	@if [ -f .venv/bin/gbfind ]; then \
		.venv/bin/gbfind --make-links $(PAPER_DIR)/$(MAIN_TEX) 2>/dev/null || echo "Note: No Google Books links generated"; \
	elif command -v gbfind >/dev/null 2>&1; then \
		gbfind --make-links $(PAPER_DIR)/$(MAIN_TEX) 2>/dev/null || echo "Note: No Google Books links generated"; \
	else \
		echo "Note: gbfind not installed, skipping Google Books links"; \
	fi
	@echo "==> Final LaTeX pass with links..."
	@cd $(PAPER_DIR) && xelatex -interaction=nonstopmode -halt-on-error $(MAIN_TEX).tex
	@cp $(PAPER_DIR)/$(MAIN_TEX).pdf $(MAIN).pdf
	@rm -f $(PAPER_DIR)/$(MAIN_TEX).pdf
	@echo "==> PDF compilation complete: $(MAIN).pdf"

# Quick compile (single pass, no bibliography)
quick: $(TEX_FILES)
	@echo "==> Quick XeLaTeX compile (single pass)..."
	@cd $(PAPER_DIR) && $(LATEX) $(LATEX_FLAGS) $(MAIN_TEX).tex
	@cp $(PAPER_DIR)/$(MAIN_TEX).pdf $(MAIN).pdf
	@rm -f $(PAPER_DIR)/$(MAIN_TEX).pdf

# Generate Markdown from LaTeX (optimized for VSCode preview)
markdown: $(MAIN).pdf
	@echo "==> Converting to Markdown..."
	@cd $(PAPER_DIR) && pandoc $(MAIN_TEX).tex \
		--from=latex \
		--to=gfm \
		--standalone \
		--bibliography=everyone.bib \
		--citeproc \
		--wrap=preserve \
		--markdown-headings=atx \
		--output=$(MAIN).md
	@cp $(PAPER_DIR)/$(MAIN).md .
	@echo "==> Markdown file created: $(MAIN).md"
	@echo "    Open in VSCode with: code $(MAIN).md"

# Optimize PDF for better viewer compatibility (optional)
optimize-pdf: $(MAIN).pdf
	@if command -v gs >/dev/null 2>&1; then \
		echo "==> Optimizing PDF with Ghostscript for better compatibility..."; \
		gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.7 -dPDFSETTINGS=/prepress \
		   -dNOPAUSE -dQUIET -dBATCH \
		   -sOutputFile=$(MAIN)-optimized.pdf $(MAIN).pdf; \
		mv $(MAIN)-optimized.pdf $(MAIN).pdf; \
		echo "==> PDF optimized: $(MAIN).pdf"; \
	else \
		echo "Error: ghostscript (gs) not found. Install with: sudo apt install ghostscript"; \
		exit 1; \
	fi

# Clean auxiliary files
clean:
	@echo "==> Cleaning auxiliary files..."
	@cd $(PAPER_DIR) && latexmk -c $(MAIN_TEX).tex
	@echo "==> Clean complete"

# Clean everything including PDF
cleanall:
	@echo "==> Cleaning all generated files..."
	@cd $(PAPER_DIR) && latexmk -C $(MAIN_TEX).tex
	@rm -f $(MAIN).pdf $(MAIN).md
	@rm -f $(PAPER_DIR)/$(MAIN).md $(PAPER_DIR)/$(MAIN_TEX).pdf
	@echo "==> Full clean complete"

# View the PDF (tries common PDF viewers)
view: $(MAIN).pdf
	@if command -v xdg-open >/dev/null 2>&1; then \
		xdg-open $(MAIN).pdf; \
	elif command -v evince >/dev/null 2>&1; then \
		evince $(MAIN).pdf & \
	elif command -v okular >/dev/null 2>&1; then \
		okular $(MAIN).pdf & \
	elif command -v zathura >/dev/null 2>&1; then \
		zathura $(MAIN).pdf & \
	else \
		echo "No PDF viewer found. Please open $(MAIN).pdf manually."; \
	fi

# Watch mode (requires inotify-tools)
watch:
	@if ! command -v inotifywait >/dev/null 2>&1; then \
		echo "Error: inotifywait not found. Install inotify-tools package."; \
		exit 1; \
	fi
	@echo "==> Watching for changes to .tex and .bib files in $(PAPER_DIR)/..."
	@echo "==> Press Ctrl+C to stop"
	@while true; do \
		inotifywait -qe modify $(PAPER_DIR)/*.tex $(PAPER_DIR)/*.bib 2>/dev/null || true; \
		echo "==> Change detected, recompiling..."; \
		$(MAKE) --no-print-directory all; \
	done

# Display help
help:
	@echo "LaTeX Makefile for Apocalypse Now Essay"
	@echo ""
	@echo "Usage:"
	@echo "  make          - Full compilation with bibliography (3 passes)"
	@echo "  make quick    - Quick single-pass compilation (no bibliography)"
	@echo "  make markdown - Convert to GitHub-flavored Markdown with citations"
	@echo "  make optimize-pdf - Optimize PDF for better viewer compatibility (requires gs)"
	@echo "  make clean    - Remove auxiliary files"
	@echo "  make cleanall - Remove all generated files including PDF and Markdown"
	@echo "  make view     - Open the PDF in default viewer"
	@echo "  make watch    - Auto-recompile on file changes (requires inotify-tools)"
	@echo "  make help     - Show this help message"
	@echo ""
	@echo "Configuration:"
	@echo "  LaTeX Compiler: $(LATEX)"
	@echo "  Bibliography:   $(BIBTEX)"
	@echo "  Markdown:       pandoc with citeproc"
	@echo "  Source dir:     $(PAPER_DIR)/"
	@echo "  Source file:    $(PAPER_DIR)/$(MAIN_TEX).tex"
	@echo "  Output PDF:     $(MAIN).pdf"
