"""
Convert presentation files to PDF
Generates PDFs for all 3 files in the presentation folder
Uses fpdf2 + markdown for reliable PDF generation
"""

import os
import re
import unicodedata
from pathlib import Path
from fpdf import FPDF
from fpdf.enums import XPos, YPos

# Get the presentation directory
PRESENTATION_DIR = Path(__file__).parent


def sanitize_text(text: str) -> str:
    """Remove or replace Unicode characters that aren't supported"""
    # Replace common Unicode symbols with ASCII equivalents
    replacements = {
        '→': '->',
        '←': '<-',
        '↔': '<->',
        '⟺': '<=>',
        '⟹': '=>',
        '⟸': '<=',
        '∈': ' in ',
        '∉': ' not in ',
        '≤': '<=',
        '≥': '>=',
        '≠': '!=',
        '≈': '~=',
        '×': 'x',
        '÷': '/',
        '±': '+/-',
        '•': '*',
        '·': '.',
        '…': '...',
        '—': '-',
        '–': '-',
        '"': '"',
        '"': '"',
        ''': "'",
        ''': "'",
        '✓': '[OK]',
        '✗': '[X]',
        '⚠': '[!]',
        'α': 'alpha',
        'β': 'beta',
        'γ': 'gamma',
        'δ': 'delta',
        'ε': 'epsilon',
        'θ': 'theta',
        'λ': 'lambda',
        'μ': 'mu',
        'π': 'pi',
        'σ': 'sigma',
        'ω': 'omega',
        'Ω': 'Omega',
        '∞': 'infinity',
        '∑': 'Sum',
        '∏': 'Product',
        '∫': 'Integral',
        '∂': 'd',
        '∇': 'nabla',
        '⊗': '(x)',
        '⊕': '(+)',
        '†': '+',
        '‡': '++',
        'ℝ': 'R',
        'ℂ': 'C',
        'ℤ': 'Z',
        'ℕ': 'N',
        'ℚ': 'Q',
        '𝔤': 'g',
        '⊂': 'subset',
        '⊃': 'superset',
        '∪': 'union',
        '∩': 'intersection',
        '∀': 'for all',
        '∃': 'exists',
        '¬': 'not',
        '∧': 'and',
        '∨': 'or',
        'ł': 'l',  # Polish l
        'ń': 'n',  # Polish n
        'ś': 's',
        'ź': 'z',
        'ż': 'z',
        'ą': 'a',
        'ę': 'e',
        'ć': 'c',
        'ó': 'o',
        'č': 'c',  # Czech
        'ř': 'r',
        'š': 's',
        'ž': 'z',
        'ě': 'e',
        'ů': 'u',
        'ý': 'y',
        'á': 'a',
        'í': 'i',
        'é': 'e',
        'ú': 'u',
        'ň': 'n',
        'ť': 't',
        'ď': 'd',
    }
    
    for old, new in replacements.items():
        text = text.replace(old, new)
    
    # Remove any remaining non-ASCII characters
    result = []
    for char in text:
        if ord(char) < 128:
            result.append(char)
        else:
            # Try to normalize
            try:
                normalized = unicodedata.normalize('NFKD', char)
                ascii_char = normalized.encode('ascii', 'ignore').decode('ascii')
                result.append(ascii_char if ascii_char else ' ')
            except:
                result.append(' ')
    
    return ''.join(result)


class MarkdownPDF(FPDF):
    """Custom PDF class for markdown rendering"""
    
    def __init__(self):
        super().__init__()
        self.add_page()
        self.set_auto_page_break(auto=True, margin=25)
        self.set_font("Helvetica", size=10)
        self.set_left_margin(15)
        self.set_right_margin(15)
        
    def header(self):
        pass
        
    def footer(self):
        self.set_y(-15)
        self.set_font("Helvetica", "I", 8)
        self.set_text_color(128, 128, 128)
        self.cell(0, 10, f"Page {self.page_no()}", align="C")
        self.set_text_color(0, 0, 0)

    def chapter_title(self, title, level=1):
        """Add a chapter/section title"""
        title = sanitize_text(title)
        sizes = {1: 16, 2: 13, 3: 11, 4: 10}
        colors = {
            1: (26, 84, 144),
            2: (44, 111, 170),
            3: (61, 138, 196),
            4: (74, 154, 212),
        }
        
        size = sizes.get(level, 10)
        color = colors.get(level, (0, 0, 0))
        
        self.set_font("Helvetica", "B", size)
        self.set_text_color(*color)
        self.ln(6 if level == 1 else 4)
        
        # Truncate very long titles
        if len(title) > 80:
            title = title[:77] + "..."
        
        self.multi_cell(0, size * 0.45, title)
        
        if level <= 2:
            self.set_draw_color(*color)
            self.line(15, self.get_y() + 1, 195, self.get_y() + 1)
            self.ln(2)
        
        self.set_text_color(0, 0, 0)
        self.set_font("Helvetica", "", 10)
        self.ln(2)

    def add_paragraph(self, text):
        """Add a paragraph of text"""
        text = sanitize_text(text)
        if not text.strip():
            return
            
        self.set_font("Helvetica", "", 10)
        
        # Truncate extremely long paragraphs
        if len(text) > 500:
            text = text[:497] + "..."
        
        self.multi_cell(0, 5, text)
        self.ln(1)

    def add_list_item(self, text, indent=0):
        """Add a list item"""
        text = sanitize_text(text)
        self.set_font("Helvetica", "", 10)
        prefix = "  " * min(indent, 3) + "* "
        
        # Truncate long items
        if len(text) > 200:
            text = text[:197] + "..."
        
        self.multi_cell(0, 5, prefix + text)

    def add_code_block(self, code):
        """Add a code block"""
        code = sanitize_text(code)
        self.set_fill_color(244, 244, 244)
        self.set_font("Courier", "", 8)
        self.ln(2)
        
        lines = code.split('\n')[:20]  # Limit to 20 lines
        for line in lines:
            if line.strip():
                line_text = "  " + line[:80]  # Limit line length
                self.cell(0, 4, line_text, fill=True, new_x=XPos.LMARGIN, new_y=YPos.NEXT)
        
        self.set_font("Helvetica", "", 10)
        self.ln(2)

    def add_table_row(self, cells, is_header=False):
        """Add a table row - simplified for reliability"""
        num_cols = max(len(cells), 1)
        
        # Always render as simple text to avoid width issues
        clean_cells = [sanitize_text(str(c))[:30] for c in cells]
        text = " | ".join(clean_cells)
        
        if is_header:
            self.set_font("Helvetica", "B", 9)
            self.set_text_color(26, 84, 144)
        else:
            self.set_font("Helvetica", "", 9)
            self.set_text_color(0, 0, 0)
        
        self.multi_cell(0, 5, text)
        self.set_text_color(0, 0, 0)

    def add_horizontal_rule(self):
        """Add a horizontal rule"""
        self.ln(4)
        self.set_draw_color(26, 84, 144)
        self.set_line_width(0.5)
        self.line(15, self.get_y(), 195, self.get_y())
        self.ln(4)


def parse_markdown_to_pdf(md_content: str, pdf: MarkdownPDF):
    """Parse markdown content and add to PDF"""
    lines = md_content.split('\n')
    in_code_block = False
    code_buffer = []
    in_table = False
    table_rows = []
    
    i = 0
    while i < len(lines):
        line = lines[i]
        
        # Code block handling
        if line.strip().startswith('```'):
            if in_code_block:
                pdf.add_code_block('\n'.join(code_buffer))
                code_buffer = []
                in_code_block = False
            else:
                in_code_block = True
            i += 1
            continue
        
        if in_code_block:
            code_buffer.append(line)
            i += 1
            continue
        
        # Table handling
        if '|' in line and line.strip().startswith('|'):
            cells = [c.strip() for c in line.split('|')[1:-1]]
            if cells and not all(c.replace('-', '').replace(':', '') == '' for c in cells):
                if not in_table:
                    in_table = True
                    pdf.add_table_row(cells, is_header=True)
                else:
                    pdf.add_table_row(cells, is_header=False)
            i += 1
            continue
        else:
            in_table = False
        
        # Headers
        if line.startswith('####'):
            pdf.chapter_title(line[4:].strip(), level=4)
        elif line.startswith('###'):
            pdf.chapter_title(line[3:].strip(), level=3)
        elif line.startswith('##'):
            pdf.chapter_title(line[2:].strip(), level=2)
        elif line.startswith('#'):
            pdf.chapter_title(line[1:].strip(), level=1)
        
        # Horizontal rule
        elif line.strip() in ['---', '***', '___']:
            pdf.add_horizontal_rule()
        
        # List items
        elif line.strip().startswith('- ') or line.strip().startswith('* '):
            indent = (len(line) - len(line.lstrip())) // 2
            pdf.add_list_item(line.strip()[2:], indent)
        elif re.match(r'^\d+\.', line.strip()):
            pdf.add_list_item(re.sub(r'^\d+\.\s*', '', line.strip()))
        
        # Regular paragraph
        elif line.strip():
            # Clean markdown formatting for display
            text = line.strip()
            text = re.sub(r'\*\*([^*]+)\*\*', r'\1', text)  # Bold
            text = re.sub(r'\*([^*]+)\*', r'\1', text)      # Italic
            text = re.sub(r'`([^`]+)`', r'\1', text)        # Code
            text = re.sub(r'\[([^\]]+)\]\([^)]+\)', r'\1', text)  # Links
            text = text.replace('$', '')
            # sanitize_text handles all special characters
            pdf.add_paragraph(text)
        
        i += 1


def convert_markdown_to_pdf(md_file: Path, output_pdf: Path):
    """Convert a Markdown file to PDF"""
    print(f"Converting {md_file.name} to PDF...")
    
    # Read markdown content
    with open(md_file, 'r', encoding='utf-8') as f:
        md_content = f.read()
    
    # Create PDF
    pdf = MarkdownPDF()
    
    try:
        parse_markdown_to_pdf(md_content, pdf)
    except Exception as e:
        # On error, print more details and try simpler approach
        import traceback
        print(f"    Debug: Error during parsing - {e}")
        # traceback.print_exc()
        
        # Simple fallback: just output text
        pdf = MarkdownPDF()
        for line in md_content.split('\n'):
            line = sanitize_text(line)
            if line.strip():
                if line.startswith('#'):
                    level = len(line) - len(line.lstrip('#'))
                    pdf.chapter_title(line.lstrip('#').strip(), level=min(level, 4))
                else:
                    try:
                        pdf.add_paragraph(line[:200])  # Limit line length
                    except:
                        pass  # Skip problematic lines
    
    # Save PDF
    pdf.output(str(output_pdf))
    print(f"  [OK] Created: {output_pdf.name}")


def convert_html_to_pdf(html_file: Path, output_pdf: Path):
    """Convert an HTML presentation file to PDF"""
    print(f"Converting {html_file.name} to PDF...")
    
    # Read HTML content
    with open(html_file, 'r', encoding='utf-8') as f:
        html_content = f.read()
    
    # Extract slides content
    pdf = MarkdownPDF()
    
    # Parse slides from HTML
    slide_pattern = r'<div class="slide"[^>]*>(.*?)</div>\s*(?=<div class="slide"|$)'
    slides = re.findall(slide_pattern, html_content, re.DOTALL)
    
    if not slides:
        # Try alternate pattern
        slides = re.findall(r'<section[^>]*>(.*?)</section>', html_content, re.DOTALL)
    
    if slides:
        for i, slide_content in enumerate(slides):
            if i > 0:
                pdf.add_page()
            
            # Extract title
            title_match = re.search(r'<h[12][^>]*>([^<]+)</h[12]>', slide_content)
            if title_match:
                pdf.chapter_title(title_match.group(1).strip(), level=1)
            
            # Extract other headings
            for h_match in re.finditer(r'<h([3-6])[^>]*>([^<]+)</h\1>', slide_content):
                level = int(h_match.group(1))
                pdf.chapter_title(h_match.group(2).strip(), level=min(level, 4))
            
            # Extract paragraphs and list items
            for p_match in re.finditer(r'<(?:p|li)[^>]*>([^<]+)</(?:p|li)>', slide_content):
                text = p_match.group(1).strip()
                text = re.sub(r'<[^>]+>', '', text)  # Remove any remaining HTML tags
                if text:
                    pdf.add_paragraph(text)
    else:
        # Fallback: just extract text
        text = re.sub(r'<style[^>]*>.*?</style>', '', html_content, flags=re.DOTALL)
        text = re.sub(r'<script[^>]*>.*?</script>', '', text, flags=re.DOTALL)
        text = re.sub(r'<[^>]+>', '\n', text)
        text = re.sub(r'\n\s*\n', '\n\n', text)
        
        for para in text.split('\n\n'):
            para = para.strip()
            if para:
                pdf.add_paragraph(para)
    
    # Save PDF
    pdf.output(str(output_pdf))
    print(f"  [OK] Created: {output_pdf.name}")


def main():
    print("=" * 60)
    print("PDF Conversion for Lie-Poisson MBQC Presentation")
    print("=" * 60)
    print()
    
    # Files to convert
    files = [
        ("Lie-Poisson-MBQC-Presentation-Streamlined.html", "html"),
        ("MATHEMATICAL_READING_GUIDE_Streamlined.md", "md"),
        ("RESEARCH_DOCUMENTATION_Streamlined.md", "md"),
    ]
    
    converted = 0
    
    for filename, file_type in files:
        input_file = PRESENTATION_DIR / filename
        output_pdf = PRESENTATION_DIR / f"{input_file.stem}.pdf"
        
        if not input_file.exists():
            print(f"⚠ File not found: {filename}")
            continue
        
        try:
            if file_type == "md":
                convert_markdown_to_pdf(input_file, output_pdf)
            elif file_type == "html":
                convert_html_to_pdf(input_file, output_pdf)
            converted += 1
        except Exception as e:
            print(f"✗ Error converting {filename}: {e}")
    
    print()
    print("=" * 60)
    print(f"Conversion complete: {converted}/{len(files)} files converted")
    print("=" * 60)
    
    # List generated PDFs
    print("\nGenerated PDF files:")
    for pdf in PRESENTATION_DIR.glob("*.pdf"):
        size_kb = pdf.stat().st_size / 1024
        print(f"  • {pdf.name} ({size_kb:.1f} KB)")


if __name__ == "__main__":
    main()
