# Research Documentation
## Lie-Poisson Geometric Criteria for Classical Optical MBQC Emulation
### Streamlined Presentation Documentation

---

## Document Information

| Field | Value |
|-------|-------|
| **Title** | Lie-Poisson Geometric Criteria for Classical Optical MBQC Emulation |
| **Version** | Streamlined (17 slides) |
| **Target Duration** | 15-20 minutes |
| **Venue** | 46th Winter School Geometry and Physics |
| **Location** | Srní, Czech Republic |
| **Dates** | January 17-24, 2026 |
| **Document Created** | January 21, 2026 |

---

## 1. Research Abstract

This work develops a unified geometric framework characterizing when Measurement-Based Quantum Computation (MBQC) admits efficient classical optical emulation. By connecting the Dynamical Lie Algebra (DLA) of an MBQC protocol to Lie-Poisson geometry on coadjoint orbits, we establish that classical simulability is equivalent to polynomial scaling of the DLA dimension.

**Central Result (Proposition 0)**: An MBQC protocol admits efficient classical simulation if and only if $\dim(\mathfrak{g}_{\text{dyn}}) \in O(\text{poly}(n))$ or the DLA is abelian on relevant observables.

---

## 2. Motivation and Background

### 2.1 The Classical-Quantum Boundary Problem

A fundamental question in quantum computation is: *When can quantum processes be efficiently simulated classically?*

This question has both:
- **Theoretical importance**: Understanding quantum computational advantage
- **Practical importance**: Validating quantum devices, designing hybrid systems

### 2.2 Why MBQC?

MBQC provides an ideal setting for this question because:
1. Computation proceeds through **measurements** on entangled states
2. The cluster state is a **universal quantum resource**
3. Classical light (polarization states) naturally maps to **Poincaré sphere** geometry
4. The **symplectic structure** connects to classical phase space methods

### 2.3 Why Lie-Poisson Geometry?

The Lie-Poisson framework is natural because:
- Quantum observable algebras are **Lie algebras**
- Expectation values evolve on the **dual space** $\mathfrak{g}^*$
- The **Kirillov-Kostant-Souriau theorem** provides canonical symplectic structure
- Classical mechanics is **integrable** when the phase space is low-dimensional

---

## 3. Mathematical Framework

### 3.1 Key Definitions

The presentation introduces 8 definitions building the framework:

| Definition | Name | Purpose |
|------------|------|---------|
| 1 | Poincaré Sphere | Maps qubits to classical polarization geometry |
| 2 | Cluster State | Defines MBQC computational resource |
| 3 | MBQC Protocol | Formalizes computation as 5-tuple |
| 4 | Dynamical Lie Algebra | Central algebraic object for complexity |
| 5 | Quantum Momentum Map | Connects states to coadjoint orbits |
| 6 | Lie-Poisson Bracket | Defines Poisson structure on $\mathfrak{g}^*$ |
| 7 | Contextual Fraction | Quantifies nonclassical correlations |
| 8 | Classically Exchangeable | Characterizes poly-dim primitives |

### 3.2 Theorem Structure

```
                    PROPOSITION 0
              (Integrability Criterion)
                        |
        ┌───────────────┼───────────────┐
        ↓               ↓               ↓
    LEMMA A         LEMMA B         LEMMA C
  (Gottesman-      (Bounded        (g-sim
   Knill)          Treewidth)      Algorithm)
        ↓               ↓               ↓
        └───────────────┼───────────────┘
                        ↓
                   THEOREM 1
           (Sufficient Conditions)

    DEFINITION 7 ───→ THEOREM 2
                   (Contextuality Barrier)
                          ↓
    DEFINITION 8 ───→ THEOREM 3
                   (Classification)
```

### 3.3 Core Mathematical Objects

#### 3.3.1 Dynamical Lie Algebra
$$\mathfrak{g}_{\text{MBQC}} = \langle \{iH_{\text{CZ}}, i\sigma_k^{(v)}\}_{v \in V, k \in \{x,y,z\}} \rangle_{\text{Lie}}$$

#### 3.3.2 Momentum Map
$$\mu: \mathcal{S}(\mathcal{H}) \to \mathfrak{g}^* \quad \text{via} \quad \mu(\rho)_\alpha = \text{Tr}(\rho \, S_\alpha)$$

#### 3.3.3 Lie-Poisson Bracket
$$\{f, g\}(\mu) = \langle \mu, [df(\mu), dg(\mu)] \rangle$$

---

## 4. Main Results

### 4.1 Central Criterion (Proposition 0)

**Claim**: Classical simulability ⟺ Polynomial DLA dimension

**Significance**: Reduces an algorithmic question to a static algebraic property.

### 4.2 Sufficient Conditions (Theorem 1)

Three independent paths to classical simulation:
1. **Clifford/Pauli restriction** → Gottesman-Knill theorem
2. **Bounded graph treewidth** → Tensor network contraction
3. **General poly-dim DLA** → g-sim algorithm

### 4.3 Obstruction (Theorem 2)

**Claim**: Contextuality bounds success probability for nonlinear functions.

**Significance**: Shows quantum advantage requires nonzero contextual fraction.

### 4.4 Classification (Theorem 3)

Complete classification of 5 MBQC primitives:
- 3 always classically exchangeable (qubits, graph, algorithm in Clifford case)
- 2 require universal resources (cluster state, non-Clifford measurements)

---

## 5. Research Methodology

### 5.1 Approach

1. **Geometric reformulation**: Translate MBQC to Lie-Poisson language
2. **Dimension analysis**: Track DLA dimension scaling
3. **Known results integration**: Unify Gottesman-Knill, treewidth, g-sim
4. **Contextuality connection**: Link to nonclassicality measures

### 5.2 Proof Techniques

| Result | Technique |
|--------|-----------|
| Proposition 0 | Dimensional analysis + g-sim complexity |
| Lemma A | Stabilizer formalism |
| Lemma B | Tensor network contraction |
| Lemma C | Heisenberg picture propagation |
| Theorem 1 | Unification via DLA criterion |
| Theorem 2 | Contextuality polytope methods |
| Theorem 3 | Case analysis + obstruction |

---

## 6. Slide-by-Slide Content Guide

| Slide | Title | Content | Time |
|-------|-------|---------|------|
| 1 | Title | Winter School presentation info | 30s |
| 2 | Motivation | Classical-quantum boundary question | 1m |
| 3 | Definitions I | Poincaré sphere, cluster states | 1.5m |
| 4 | Definitions II | MBQC protocol, DLA | 1.5m |
| 5 | KKS Theorem | Coadjoint orbit symplectic structure | 1m |
| 6 | Lie-Poisson Framework | Momentum map, bracket | 1.5m |
| 7 | Proposition 0 | Central integrability criterion | 1.5m |
| 8 | Lemmas A-C | Sufficient conditions (consolidated) | 1.5m |
| 9 | Theorem 1 | Unified sufficient conditions | 1m |
| 10 | Theorem 2 | Contextuality barrier | 1.5m |
| 11 | Theorem 3 | Classification of primitives | 1.5m |
| 12 | Classification Table | Visual summary | 1m |
| 13 | Complexity Summary | DLA scaling summary | 1m |
| 14 | Open Problems | Future research directions | 1m |
| 15 | Conclusions | Key takeaways | 1m |
| 16 | References | 8 cited works | 30s |
| 17 | Thank You | Q&A invitation | 30s |

**Total: ~17 minutes**

---

## 7. References

### 7.1 Primary Sources Cited

1. **Raussendorf & Briegel (2001)** - One-way quantum computation
2. **Nielsen (2006)** - Cluster-state quantum computation
3. **Browne & Briegel (2006)** - One-way quantum computation tutorial
4. **Raussendorf (2013)** - Contextuality in MBQC
5. **Marsden & Ratiu (1999)** - Introduction to mechanics and symmetry
6. **Kirillov (2004)** - Orbit method lectures
7. **Goh et al. (2025)** - DLA structure in quantum computing
8. **Saleh & Teich (2019)** - Fundamentals of photonics

### 7.2 Reference Classification

| Type | References |
|------|------------|
| MBQC foundations | [1], [2], [3] |
| Contextuality | [4] |
| Lie-Poisson geometry | [5], [6] |
| Classical simulation | [7] |
| Optical implementation | [8] |

---

## 8. Open Problems and Future Directions

### 8.1 Problems Identified in Presentation

1. **Explicit photonic architectures** achieving polynomial DLA scaling
2. **Experimental verification** of contextuality bounds
3. **Extension to continuous-variable MBQC** (beyond qubits)

### 8.2 Potential Research Extensions

| Direction | Description | Difficulty |
|-----------|-------------|------------|
| CV-MBQC | Extend to infinite-dimensional systems | High |
| Fault tolerance | Incorporate error correction | Medium |
| Hardware mapping | Design optical circuits from DLA | Medium |
| Complexity refinement | Tighter bounds on simulation overhead | Medium |

---

## 9. Presentation Technical Details

### 9.1 File Information

| Property | Value |
|----------|-------|
| Filename | `Lie-Poisson-MBQC-Presentation-Streamlined.html` |
| Format | HTML with embedded CSS |
| Framework | Custom slide framework with keyboard navigation |
| Line count | ~686 lines |
| Original version | 34 slides, 1543 lines |

### 9.2 Navigation

- **Arrow keys** or **Page Up/Down**: Navigate slides
- **G + number**: Jump to specific slide
- **H**: Toggle help

### 9.3 Mathematical Rendering

- Equations rendered via **KaTeX**
- Inline math: `$...$`
- Display math: `$$...$$`

---

## 10. Version History

| Version | Date | Changes |
|---------|------|---------|
| Original | Jan 2026 | Full 34-slide presentation |
| Streamlined | Jan 21, 2026 | Reduced to 17 slides |
| v1.1 | Jan 21, 2026 | Added missing Definitions 7-8 |
| v1.2 | Jan 21, 2026 | Fixed theorem numbering (5→3) |
| v1.3 | Jan 21, 2026 | Removed unused reference [8] (KLM) |

---

## 11. Contact and Attribution

**Venue**: 46th Winter School Geometry and Physics  
**Location**: Srní, Czech Republic  
**Conference Dates**: January 17-24, 2026

---

## Appendix A: Notation Reference

| Symbol | Meaning |
|--------|---------|
| $\mathfrak{g}$ | Lie algebra |
| $\mathfrak{g}^*$ | Dual of Lie algebra |
| $\mathfrak{g}_{\text{dyn}}$ | Dynamical Lie algebra |
| $\mu$ | Momentum map |
| $\omega$ | Symplectic form |
| $\rho$ | Density matrix |
| $\vec{S} = (S_1, S_2, S_3)$ | Stokes parameters |
| $\{f,g\}$ | Poisson bracket |
| $[A,B]$ | Lie bracket / commutator |
| $C_F$ | Contextual fraction |
| $\text{CZ}$ | Controlled-Z gate |
| $\text{tw}(G)$ | Treewidth of graph $G$ |
| $O(\cdot)$ | Big-O complexity |
| $\Omega(\cdot)$ | Big-Omega complexity |

---

## Appendix B: Theorem Statement Summary

### Proposition 0
$$\text{Classical sim} \Longleftrightarrow \dim(\mathfrak{g}_{\text{dyn}}) \in O(\text{poly}(n))$$

### Theorem 1
$$(\text{Pauli meas.}) \lor (\text{tw}(G) = O(1)) \lor (\dim(\mathfrak{g}) = O(\text{poly})) \Longrightarrow \text{Classical sim}$$

### Theorem 2
$$p_s \leq 1 - (1 - C_F(\rho_G)) \cdot \frac{d_H(f, \text{Aff}_n)}{2^n}$$

### Theorem 3
$$\exists P_i \text{ with } \dim(\mathfrak{g}_i) \in \Omega(4^n) \Longrightarrow \text{Required for quantum advantage}$$
