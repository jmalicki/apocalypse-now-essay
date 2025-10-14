# Citation Enhancement Plan

## Goal
Add Google Books links to public domain works while maintaining classical print citation style.

**Note**: Research confirms that **no existing LaTeX package provides this functionality**.
The standard approach is manual `\href` commands, which is tedious and error-prone. Our custom
`\gbparencite` command automates this process and is a novel contribution to the LaTeX citation ecosystem.

## Approach

### Two-Level Linking Strategy

#### 1. Bibliography Links (Basic)
- Add `url` field to bibliography entries
- Links to the book's main Google Books page
- Appears in the reference list

#### 2. Inline Page Links (Advanced) ⭐
**This is the key feature**: Make page numbers in citations clickable!

When you cite `\parencite[p.~27]{KantGroundwork1996}`, the "27" becomes a link to:
`https://books.google.com/books?id=BOOK_ID&pg=PA27`

### Implementation Strategy

**Option A: Custom Citation Command** (Recommended)
1. Create new citation commands: `\gbcite`, `\gbparencite`, etc.
2. Store Google Books ID in a custom field: `googlebooksid = {abc123}`
3. Command constructs page-specific URL automatically
4. Falls back to regular citation if no Google Books ID

**Option B: BibLaTeX Format Override**
1. Override APA citation format hooks
2. Detect when `googlebooksid` field exists
3. Wrap page numbers in `\href` automatically
4. More seamless but more complex

**Starting with Option A** for proof of concept, then consider Option B.

### Google Books URL Structure
- Base: `https://books.google.com/books?id=BOOK_ID`
- Specific page: `https://books.google.com/books?id=BOOK_ID&pg=PA123`
- Page prefixes: `PA` (page A), `PR` (roman numerals), `PP` (preliminaries)
- For simplicity, we'll use `PA` for arabic numerals (most common)

## Public Domain Works to Enhance

### Definitely Public Domain (pre-1928):
- Augustine - Confessions (~400 CE)
- Augustine - City of God (~426 CE)
- Aquinas - Summa Theologiae (1265-1274)
- Schopenhauer - World as Will and Representation (1818)
- Kant - Groundwork (1785), Critique of Practical Reason (1788)
- Hegel - Phenomenology of Spirit (1807)
- Kierkegaard - Sickness Unto Death (1849)
- Dostoevsky - Notes from Underground (1864)
- Nietzsche - Beyond Good and Evil (1886), Genealogy of Morals (1887)
- Conrad - Heart of Darkness (1899)

### Modern Translations (check case-by-case):
- May have copyright on translation even if source is public domain
- Focus on well-known, widely available editions

## Example Enhancement

Before:
```bibtex
@book{SchopenhauerWWR1969,
  author    = {Arthur Schopenhauer},
  year      = {1969},
  title     = {The World as Will and Representation},
  volume    = {1},
  translator= {E. F. J. Payne},
  address   = {New York},
  publisher = {Dover}
}
```

After:
```bibtex
@book{SchopenhauerWWR1969,
  author    = {Arthur Schopenhauer},
  year      = {1969},
  title     = {The World as Will and Representation},
  volume    = {1},
  translator= {E. F. J. Payne},
  address   = {New York},
  publisher = {Dover},
  url           = {https://books.google.com/books?id=abc123xyz},
  googlebooksid = {abc123xyz},
  note          = {Original work published 1818}
}
```

Usage in text:
```latex
% Old way (still works):
\parencite[p.~312]{SchopenhauerWWR1969}
% Renders: (Schopenhauer, 1969, p. 312)

% New way (page number is clickable):
\gbparencite[p.~312]{SchopenhauerWWR1969}
% Renders: (Schopenhauer, 1969, p. 312) [with "312" as a link]
% Links to: https://books.google.com/books?id=abc123xyz&pg=PA312
```

## Testing Plan

1. Add URLs to 3-5 entries as proof of concept
2. Rebuild PDF and verify:
   - Citations maintain classical format
   - URLs appear in bibliography
   - Links are clickable in PDF viewers
3. If successful, systematically add URLs to all public domain works

## Future Enhancements

- Add DOIs for modern academic works
- Consider Internet Archive links as backup
- Add links to Stanford Encyclopedia of Philosophy for philosophical concepts
