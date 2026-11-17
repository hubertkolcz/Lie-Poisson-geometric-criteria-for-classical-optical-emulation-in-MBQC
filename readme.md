# Lie-Poisson geometric criteria for classical optical emulation in MBQC

When can a measurement-based quantum computation (MBQC) be emulated by classical optics? This
repository holds a study that proposes Lie-Poisson geometric criteria for that question, prepared for
the [46th Winter School Geometry and Physics](https://conference.math.muni.cz/srni) (Srní, Czech
Republic, January 2026).

## Contents

- `Introduction - Lie-Poisson geometric criteria for classical optical emulation in measurement-based quantum computing.pdf`:
  introduction to the study.
- `Lie-Poisson-MBQC-Presentation.pdf` and `Appendix - Lie-Poisson-MBQC-Presentation.pdf`: the
  presentation and its appendix.
- `Lie_Poisson_MBQC.wl`: the Wolfram Language model.
- `archive/`: working material, including the Python scripts used for numerical validation (NumPy,
  SciPy, Qiskit, Qiskit Aer), documentation drafts, HTML versions of the presentation and results.
- `related/dynamic-quantumvengers`: the earlier team project this study builds on, included as a git
  submodule (clone with `git clone --recurse-submodules`).

## Origins and acknowledgements

- The study was prepared during and for the 46th Winter School Geometry and Physics (Srní, January
  2026), which shaped its methodology.
- Conceptually, it builds on [dynamic-quantumvengers](https://github.com/hubertkolcz/dynamic-quantumvengers),
  a QRISE 2024 team project by Hubert Kołcz, Umi Yamaguchi and Ayeman Fatima. That project covers
  quantum teleportation, GHZ circuits, randomized benchmarking and error correction in Qiskit. No code
  from it is reused here.
- The code was written with substantial help from an AI coding assistant (Claude). Hubert Kołcz
  designed the study, directed the implementation, and reviewed and validated the results.

## Licence

The contents of this repository are available under the MIT licence (see [LICENSE](LICENSE)). The
`related/dynamic-quantumvengers` submodule is a separate team project and is not covered by it.

## Citation

```bibtex
@software{kolcz_lie_poisson_mbqc_2026,
  author = {Hubert Kołcz},
  title  = {Lie-Poisson geometric criteria for classical optical emulation in measurement-based quantum computing},
  year   = {2026},
  url    = {https://github.com/hubertkolcz/Lie-Poisson-geometric-criteria-for-classical-optical-emulation-in-MBQC},
  note   = {Written with AI assistance}
}
```
