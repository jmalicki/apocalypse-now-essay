# Makefile for LaTeX compilation with XeLaTeX and Biber
# For Apocalypse Now Analysis Paper

# Main document name (without .tex extension)
MAIN = Master_Apocalypse_Now_Essay

# Paper source directory
PAPER_DIR = paper

# LaTeX compiler
LATEX = xelatex
BIBTEX = biber

# Compiler flags
LATEX_FLAGS = -interaction=nonstopmode -halt-on-error -file-line-error

# Output directory
OUT_DIR = build

# Source files
TEX_FILES = $(wildcard $(PAPER_DIR)/*.tex)
BIB_FILES = $(wildcard $(PAPER_DIR)/*.bib)

.PHONY: all clean cleanall view help watch

# Default target
all: $(MAIN).pdf

# Full compilation with bibliography
$(MAIN).pdf: $(TEX_FILES) $(BIB_FILES)
	@echo "==> First XeLaTeX pass..."
	@cd $(PAPER_DIR) && $(LATEX) $(LATEX_FLAGS) $(MAIN).tex
	@if grep -q '\\citation' $(PAPER_DIR)/$(MAIN).aux 2>/dev/null; then \
		echo "==> Running Biber..."; \
		cd $(PAPER_DIR) && $(BIBTEX) $(MAIN); \
		echo "==> Second XeLaTeX pass..."; \
		cd $(PAPER_DIR) && $(LATEX) $(LATEX_FLAGS) $(MAIN).tex; \
	fi
	@echo "==> Final XeLaTeX pass..."
	@cd $(PAPER_DIR) && $(LATEX) $(LATEX_FLAGS) $(MAIN).tex
	@cp $(PAPER_DIR)/$(MAIN).pdf .
	@echo "==> PDF compilation complete: $(MAIN).pdf"

# Quick compile (single pass, no bibliography)
quick: $(TEX_FILES)
	@echo "==> Quick XeLaTeX compile (single pass)..."
	@cd $(PAPER_DIR) && $(LATEX) $(LATEX_FLAGS) $(MAIN).tex
	@cp $(PAPER_DIR)/$(MAIN).pdf .

# Clean auxiliary files
clean:
	@echo "==> Cleaning auxiliary files..."
	@cd $(PAPER_DIR) && rm -f *.aux *.log *.bbl *.blg *.bcf *.run.xml *.toc *.out
	@cd $(PAPER_DIR) && rm -f *.lof *.lot *.fls *.fdb_latexmk *.synctex.gz *.xdv
	@cd $(PAPER_DIR) && rm -f *.nav *.snm *.vrb
	@echo "==> Clean complete"

# Clean everything including PDF
cleanall: clean
	@echo "==> Removing PDF output..."
	@rm -f $(MAIN).pdf
	@rm -f $(PAPER_DIR)/$(MAIN).pdf
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
	@echo "LaTeX Makefile for $(PAPER_DIR)/$(MAIN).tex"
	@echo ""
	@echo "Usage:"
	@echo "  make          - Full compilation with bibliography (3 passes)"
	@echo "  make quick    - Quick single-pass compilation (no bibliography)"
	@echo "  make clean    - Remove auxiliary files"
	@echo "  make cleanall - Remove all generated files including PDF"
	@echo "  make view     - Open the PDF in default viewer"
	@echo "  make watch    - Auto-recompile on file changes (requires inotify-tools)"
	@echo "  make help     - Show this help message"
	@echo ""
	@echo "Configuration:"
	@echo "  LaTeX Compiler: $(LATEX)"
	@echo "  Bibliography:   $(BIBTEX)"
	@echo "  Source dir:     $(PAPER_DIR)/"
	@echo "  Main file:      $(PAPER_DIR)/$(MAIN).tex"
