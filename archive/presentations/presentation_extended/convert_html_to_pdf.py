"""
Convert HTML Presentation to PDF using multiple approaches.
Supports KaTeX math, CSS styling, and slide-based layouts.

Best approaches ranked:
1. Playwright (best quality, handles JS/CSS/KaTeX perfectly)
2. Chrome/Edge command line (no Python dependencies)
3. WeasyPrint (good for simpler HTML, limited JS support)
"""

import subprocess
import sys
from pathlib import Path


def convert_with_playwright(html_path: str, output_pdf: str = None):
    """
    Best method: Uses Playwright (headless Chromium) for perfect rendering.
    Handles KaTeX, CSS, and all JavaScript.
    Outputs each slide as a separate page matching the slide dimensions.
    
    Install: pip install playwright && playwright install chromium
    """
    try:
        from playwright.sync_api import sync_playwright
    except ImportError:
        print("Installing playwright...")
        subprocess.run([sys.executable, "-m", "pip", "install", "playwright"], check=True)
        subprocess.run([sys.executable, "-m", "playwright", "install", "chromium"], check=True)
        from playwright.sync_api import sync_playwright
    
    html_path = Path(html_path).resolve()
    if output_pdf is None:
        output_pdf = html_path.with_suffix('.pdf')
    
    print(f"Converting {html_path.name} to PDF using Playwright...")
    
    with sync_playwright() as p:
        browser = p.chromium.launch()
        page = browser.new_page()
        
        # Load the HTML file
        page.goto(f"file:///{html_path}")
        
        # Wait for KaTeX to render (important for math)
        page.wait_for_timeout(3000)
        
        # Inject print styles to make each slide a separate page
        page.add_style_tag(content="""
            @media print {
                body {
                    background: white !important;
                    margin: 0 !important;
                    padding: 0 !important;
                }
                .slide {
                    width: 960px !important;
                    height: 600px !important;
                    margin: 0 !important;
                    padding: 2.5rem !important;
                    page-break-after: always !important;
                    break-after: page !important;
                    box-shadow: none !important;
                    border-radius: 0 !important;
                }
                .slide:last-child {
                    page-break-after: avoid !important;
                    break-after: avoid !important;
                }
            }
        """)
        
        # Generate PDF - use exact slide dimensions (960x600 pixels = 10" x 6.25" at 96dpi)
        page.pdf(
            path=str(output_pdf),
            width="960px",
            height="600px",
            print_background=True,  # Keep CSS backgrounds
            display_header_footer=False,  # No headers or footers
            margin={"top": "0", "bottom": "0", "left": "0", "right": "0"},
        )
        
        browser.close()
    
    print(f"✓ PDF saved to: {output_pdf}")
    return output_pdf


def convert_with_chrome_cli(html_path: str, output_pdf: str = None):
    """
    Uses Chrome/Edge command line (no Python packages needed).
    Works on Windows with Edge or Chrome installed.
    Outputs landscape orientation with no headers/footers.
    """
    html_path = Path(html_path).resolve()
    if output_pdf is None:
        output_pdf = html_path.with_suffix('.pdf')
    
    # Try Edge first (more common on Windows), then Chrome
    browsers = [
        r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe",
        r"C:\Program Files\Microsoft\Edge\Application\msedge.exe",
        r"C:\Program Files\Google\Chrome\Application\chrome.exe",
        r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",
    ]
    
    browser_exe = None
    for path in browsers:
        if Path(path).exists():
            browser_exe = path
            break
    
    if not browser_exe:
        raise RuntimeError("Chrome or Edge not found. Install one or use Playwright method.")
    
    print(f"Converting {html_path.name} to PDF using {Path(browser_exe).stem}...")
    
    # Use headless printing - landscape, no headers/footers
    cmd = [
        browser_exe,
        "--headless",
        "--disable-gpu",
        "--no-sandbox",
        f"--print-to-pdf={output_pdf}",
        "--print-to-pdf-no-header",  # No header/footer
        "--no-pdf-header-footer",    # Additional flag to ensure no metadata
        f"file:///{html_path}"
    ]
    
    result = subprocess.run(cmd, capture_output=True, text=True)
    
    if Path(output_pdf).exists():
        print(f"✓ PDF saved to: {output_pdf}")
        return output_pdf
    else:
        raise RuntimeError(f"Failed to create PDF: {result.stderr}")


def convert_with_weasyprint(html_path: str, output_pdf: str = None):
    """
    WeasyPrint method - good for simpler HTML.
    Note: Limited JavaScript support, may not render KaTeX perfectly.
    
    Install: pip install weasyprint
    """
    try:
        from weasyprint import HTML
    except ImportError:
        print("Installing weasyprint...")
        subprocess.run([sys.executable, "-m", "pip", "install", "weasyprint"], check=True)
        from weasyprint import HTML
    
    html_path = Path(html_path).resolve()
    if output_pdf is None:
        output_pdf = html_path.with_suffix('.pdf')
    
    print(f"Converting {html_path.name} to PDF using WeasyPrint...")
    
    HTML(filename=str(html_path)).write_pdf(str(output_pdf))
    
    print(f"✓ PDF saved to: {output_pdf}")
    return output_pdf


def convert_with_pdfkit(html_path: str, output_pdf: str = None):
    """
    Uses wkhtmltopdf via pdfkit.
    Requires wkhtmltopdf to be installed: https://wkhtmltopdf.org/downloads.html
    
    Install: pip install pdfkit
    """
    try:
        import pdfkit
    except ImportError:
        print("Installing pdfkit...")
        subprocess.run([sys.executable, "-m", "pip", "install", "pdfkit"], check=True)
        import pdfkit
    
    html_path = Path(html_path).resolve()
    if output_pdf is None:
        output_pdf = html_path.with_suffix('.pdf')
    
    print(f"Converting {html_path.name} to PDF using pdfkit/wkhtmltopdf...")
    
    options = {
        'enable-local-file-access': None,
        'javascript-delay': 2000,  # Wait for KaTeX
        'no-stop-slow-scripts': None,
        'print-media-type': None,
    }
    
    pdfkit.from_file(str(html_path), str(output_pdf), options=options)
    
    print(f"✓ PDF saved to: {output_pdf}")
    return output_pdf


def main():
    """Convert presentation HTML files to PDF"""
    import argparse
    
    parser = argparse.ArgumentParser(description="Convert HTML presentation to PDF")
    parser.add_argument("html_file", nargs="?", 
                        default="Lie-Poisson-MBQC-Presentation.html",
                        help="HTML file to convert")
    parser.add_argument("-o", "--output", help="Output PDF path")
    parser.add_argument("-m", "--method", 
                        choices=["playwright", "chrome", "weasyprint", "pdfkit"],
                        default="chrome",
                        help="Conversion method (default: chrome)")
    
    args = parser.parse_args()
    
    html_path = Path(args.html_file)
    if not html_path.is_absolute():
        html_path = Path(__file__).parent / html_path
    
    if not html_path.exists():
        print(f"Error: File not found: {html_path}")
        sys.exit(1)
    
    methods = {
        "playwright": convert_with_playwright,
        "chrome": convert_with_chrome_cli,
        "weasyprint": convert_with_weasyprint,
        "pdfkit": convert_with_pdfkit,
    }
    
    try:
        methods[args.method](str(html_path), args.output)
    except Exception as e:
        print(f"Error with {args.method}: {e}")
        print("\nTrying fallback methods...")
        
        for method_name, method_func in methods.items():
            if method_name != args.method:
                try:
                    print(f"\nTrying {method_name}...")
                    method_func(str(html_path), args.output)
                    break
                except Exception as e2:
                    print(f"  {method_name} failed: {e2}")


if __name__ == "__main__":
    main()
