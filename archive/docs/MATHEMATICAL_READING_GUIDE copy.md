# Mathematical Reading Guide for Oral Presentation

## Lie-Poisson Geometric Criteria for Classical Optical MBQC Emulation
### 46th Winter School Geometry and Physics · Srní, Czech Republic · January 17-24, 2026

---

This guide helps you read all mathematical notation aloud in natural, clear English.

---

## Table of Contents

1. [Greek Letters & Common Symbols](#1-greek-letters--common-symbols)
2. [Set Theory & Logic](#2-set-theory--logic)
3. [Definition 1: Poincaré Sphere](#3-definition-1-poincaré-sphere)
4. [Definition 2: Cluster State](#4-definition-2-cluster-state)
5. [Definition 3: MBQC Protocol](#5-definition-3-mbqc-protocol)
6. [Definition 4: Dynamical Lie Algebra](#6-definition-4-dynamical-lie-algebra)
7. [KKS Theorem: Coadjoint Orbits](#7-kks-theorem-coadjoint-orbits)
8. [Definition 5: Quantum Momentum Map](#8-definition-5-quantum-momentum-map)
9. [Definition 6: Lie-Poisson Bracket](#9-definition-6-lie-poisson-bracket)
10. [Proposition 0: Central Criterion](#10-proposition-0-central-criterion)
11. [Definitions 7-8: Contextuality](#11-definitions-7-8-contextuality)
12. [Lemma A: Gottesman-Knill](#12-lemma-a-gottesman-knill)
13. [Lemma B: Bounded Treewidth](#13-lemma-b-bounded-treewidth)
14. [Lemma C: g-Sim Algorithm](#14-lemma-c-g-sim-algorithm)
15. [Theorem 1: Sufficient Conditions](#15-theorem-1-sufficient-conditions)
16. [Theorem 2: Contextuality Barrier](#16-theorem-2-contextuality-barrier)
17. [Theorem 3: Structural Partition](#17-theorem-3-structural-partition)
18. [Theorem 4: Universality Criterion](#18-theorem-4-universality-criterion)
19. [Theorem 5: Complete Classification](#19-theorem-5-complete-classification)
20. [DLA Dimension Tables](#20-dla-dimension-tables)
21. [Strategies S1-S6](#21-strategies-s1-s6)
22. [Quick Reference Card](#22-quick-reference-card)

---

## 1. Greek Letters & Common Symbols

### Greek Alphabet (as used in presentation)

| Symbol | Name | How to say |
|--------|------|------------|
| α | alpha | "alpha" |
| β | beta | "beta" (BEY-ta or BEE-ta) |
| γ | gamma | "gamma" |
| δ | delta | "delta" |
| ε | epsilon | "epsilon" |
| θ | theta | "theta" (THEY-ta) |
| λ | lambda | "lambda" |
| μ | mu | "mew" or "myoo" |
| ν | nu | "new" or "nyoo" |
| ξ | xi | "ksee" or "zai" |
| π | pi | "pie" |
| ρ | rho | "row" |
| σ | sigma | "sigma" |
| φ, ϕ | phi | "fie" or "fee" |
| ω | omega | "oh-MEG-uh" |
| Λ | Lambda | "capital lambda" |
| Π | Pi | "capital pi" |
| Σ | Sigma | "capital sigma" or "sum" |
| Ω | Omega | "capital omega" |
| Ψ | Psi | "sigh" or "psee" |

### Fraktur (Gothic) Letters

| Symbol | How to say |
|--------|------------|
| 𝔤 (g) | "fraktur g" or just "g" (the Lie algebra) |
| 𝔤* | "g-star" or "g dual" or "the dual of g" |
| 𝔤_dyn | "g-dyn" or "g-dynamical" |
| 𝔤_MBQC | "g-M-B-Q-C" |
| 𝔰𝔲(2) | "s-u-two" or "the Lie algebra s-u-two" |
| 𝔰𝔲(2)* | "s-u-two star" or "the dual of s-u-two" |
| 𝔰𝔬(3) | "s-o-three" or "the Lie algebra s-o-three" |
| 𝔲(1) | "u-one" |

### Common Mathematical Notation

| Symbol | How to say |
|--------|------------|
| ∈ | "is in" or "belongs to" or "is an element of" |
| ⊂ | "is a subset of" |
| ⊆ | "is a subset of or equal to" |
| ∀ | "for all" |
| ∃ | "there exists" |
| ⇒ | "implies" or "then" |
| ⇔ | "if and only if" or "iff" |
| := | "is defined as" or "equals by definition" |
| ≡ | "is identically equal to" or "is equivalent to" |
| ≅ | "is isomorphic to" |
| ∼ | "is similar to" or "scales as" |
| ∝ | "is proportional to" |
| → | "maps to" or "goes to" or "tends to" |
| ↦ | "maps to" (for elements) |
| ⊗ | "tensor product" or "tensor" |
| ⊕ | "direct sum" |
| ⊔ | "disjoint union" |
| × | "times" or "cross product" or "Cartesian product" |
| · | "dot" or "times" (multiplication) |
| ∧ | "wedge" or "and" (logical) |
| ∨ | "or" (logical) |
| † | "dagger" (adjoint) |
| ℏ | "h-bar" (reduced Planck constant) |

---

## 2. Set Theory & Logic

| Expression | How to read aloud |
|------------|-------------------|
| ℝ | "the real numbers" or "R" |
| ℝ³ | "R-three" or "three-dimensional real space" |
| ℂ | "the complex numbers" or "C" |
| ℤ | "the integers" or "Z" |
| ℤ₂ | "Z-two" or "the integers mod two" |
| {0,1} | "the set zero-one" or "the set containing zero and one" |
| {0,1}ⁿ | "zero-one to the n" or "n-bit strings" |
| [0, 2π) | "the interval from zero to two-pi, including zero but not two-pi" |
| \|V\| | "the size of V" or "the cardinality of V" |
| O(n) | "order n" or "big-O of n" |
| O(poly(n)) | "order polynomial in n" |
| Ω(4ⁿ) | "big-Omega of four-to-the-n" |

---

## 3. Definition 1: Poincaré Sphere

### Formula: $S^2 \subset \mathbb{R}^3$

**Read as:** "S-two, a subset of R-three"

**Full sentence:** "The two-sphere, which is a subset of three-dimensional real space"

---

### Formula: $\rho = \frac{1}{2}\left(I + \sum_{i=1}^{3} s_i \sigma_i\right)$

**Read as:** "Rho equals one-half times the quantity I plus the sum from i equals one to three of s-sub-i times sigma-sub-i"

**Alternative:** "Rho equals one-half times open-paren I plus the sum of s-i sigma-i for i from one to three close-paren"

**Conversational:** "The density matrix rho is given by one-half times the identity plus the sum of the Stokes components times the Pauli matrices"

---

### Formula: $\vec{s} = (s_1, s_2, s_3) \in S^2$

**Read as:** "s-vector equals the triple s-one, s-two, s-three, which is an element of S-two"

**Conversational:** "The Stokes vector s, with components s-one, s-two, s-three, lies on the two-sphere"

---

### Pauli matrices: $\sigma_i$

**Read as:** "sigma-i" or "sigma-sub-i" or "the i-th Pauli matrix"

**Note:** Individual Pauli matrices are:
- σ₁ or σₓ: "sigma-one" or "sigma-X"
- σ₂ or σᵧ: "sigma-two" or "sigma-Y"
- σ₃ or σᵤ: "sigma-three" or "sigma-Z"

---

## 4. Definition 2: Cluster State

### Formula: $G = (V, E)$

**Read as:** "G equals the pair V, E" or "Graph G with vertices V and edges E"

---

### Formula: $|\Psi_G\rangle = \prod_{(i,j) \in E} \text{CZ}_{ij} \bigotimes_{v \in V} |+\rangle_v$

**Read as:** "Ket psi-G equals the product over all pairs i,j in E of C-Z-i-j, applied to the tensor product over all vertices v in V of ket-plus at vertex v"

**Piece by piece:**
- $|\Psi_G\rangle$: "ket psi-G" or "the state psi-sub-G"
- $\prod_{(i,j) \in E}$: "the product over all edges i-j in E"
- $\text{CZ}_{ij}$: "C-Z on qubits i and j" or "controlled-Z between i and j"
- $\bigotimes_{v \in V}$: "the tensor product over all vertices v in V"
- $|+\rangle_v$: "ket-plus at vertex v" or "the plus state on qubit v"

**Conversational:** "The cluster state psi-G is formed by applying controlled-Z gates to all edges of the graph, starting from plus states on every vertex"

---

### Formula: $\text{CZ}_{ij} = |0\rangle\langle 0| \otimes I + |1\rangle\langle 1| \otimes Z$

**Read as:** "C-Z-i-j equals ket-zero-bra-zero tensor I, plus ket-one-bra-one tensor Z"

**Conversational:** "Controlled-Z is the projector onto zero tensored with identity, plus the projector onto one tensored with the Z gate"

**Bra-ket notation:**
- $|0\rangle$: "ket-zero"
- $\langle 0|$: "bra-zero"
- $|0\rangle\langle 0|$: "ket-zero-bra-zero" or "the projector onto zero"

---

## 5. Definition 3: MBQC Protocol

### Formula: $\Pi = (G, \rho_G, \mathcal{M}, \mathcal{F}, \mathcal{O})$

**Read as:** "Capital-Pi equals the five-tuple: G, rho-G, script-M, script-F, script-O"

**Conversational:** "An MBQC protocol Pi consists of five components: the graph G, the resource state rho-G, the measurements M, the feed-forward function F, and the output function O"

---

### Formula: $\mathcal{M} = \{M_v(\theta_v)\}_{v \in V}$

**Read as:** "Script-M equals the set of M-sub-v of theta-sub-v, for all v in V"

**Conversational:** "The measurement set M contains a measurement operator at each vertex, parameterized by the angle theta-v"

---

### Formula: $\theta_v \in [0, 2\pi)$

**Read as:** "theta-v is in the interval zero to two-pi"

---

### Formula: $\mathcal{F}: \{0,1\}^{|V|} \times \{0,1\}^k \to [0,2\pi)^{|V|}$

**Read as:** "Script-F is a function from zero-one to the absolute-value-of-V, cross zero-one to the k, mapping to the interval zero to two-pi to the absolute-value-of-V"

**Conversational:** "The feed-forward function F takes measurement outcomes and classical inputs, and returns the measurement angles"

**Breaking it down:**
- $\{0,1\}^{|V|}$: "n-bit strings" (where n = |V|) - the measurement outcomes
- $\{0,1\}^k$: "k-bit strings" - the classical input
- $[0,2\pi)^{|V|}$: "angles for each vertex"

---

### Formula: $\mathcal{O}: \{0,1\}^{|V|} \to \{0,1\}^\ell$

**Read as:** "Script-O maps from zero-one to the V, to zero-one to the ell"

**Conversational:** "The output function O extracts the final ell-bit output from all the measurement outcomes"

---

## 6. Definition 4: Dynamical Lie Algebra

### Formula: $\mathfrak{g}_{\text{MBQC}} = \langle \{iH_{\text{CZ}}, i\sigma_k^{(v)}\}_{v \in V, k \in \{x,y,z\}} \rangle_{\text{Lie}}$

**Read as:** "g-MBQC equals the Lie algebra generated by the set containing i-H-C-Z and i-sigma-k at vertex v, for all vertices v in V and k in x, y, z"

**Piece by piece:**
- $\mathfrak{g}_{\text{MBQC}}$: "g-M-B-Q-C" or "the MBQC Lie algebra"
- $\langle \cdots \rangle_{\text{Lie}}$: "the Lie algebra generated by..." or "the Lie closure of..."
- $iH_{\text{CZ}}$: "i times H-C-Z" (the entangling Hamiltonian)
- $i\sigma_k^{(v)}$: "i times sigma-k at vertex v"

**Conversational:** "The dynamical Lie algebra g-MBQC is generated by the entangling Hamiltonian and all single-qubit Pauli operators, under the Lie bracket"

---

### Formula: $[A,B] = AB - BA$

**Read as:** "The bracket of A and B equals A-B minus B-A"

**Conversational:** "The Lie bracket, or commutator, of A and B is A times B minus B times A"

---

## 7. KKS Theorem: Coadjoint Orbits

### Formula: $\mathcal{O}_\mu = \{\text{Ad}^*_g \mu : g \in G\} \subset \mathfrak{g}^*$

**Read as:** "Script-O-sub-mu equals the set of Ad-star-g acting on mu, for g in G, which is a subset of g-star"

**Breaking it down:**
- $\mathcal{O}_\mu$: "the coadjoint orbit through mu" or "script-O-mu"
- $\text{Ad}^*_g$: "Ad-star-g" or "the coadjoint action of g"
- $\mathfrak{g}^*$: "g-star" or "the dual of the Lie algebra g"

**Conversational:** "The coadjoint orbit O-mu is the set of all points obtained by acting on mu with the coadjoint action of all group elements"

---

### Formula: $\omega_\mu(\xi_{\mathfrak{g}^*}, \eta_{\mathfrak{g}^*}) = \langle \mu, [\xi, \eta] \rangle$

**Read as:** "Omega-mu of xi-g-star and eta-g-star equals the pairing of mu with the bracket of xi and eta"

**Breaking it down:**
- $\omega_\mu$: "omega-mu" or "the symplectic form at mu"
- $\xi_{\mathfrak{g}^*}$: "xi-g-star" (a vector field)
- $\langle \mu, [\xi, \eta] \rangle$: "the pairing of mu with the bracket xi-eta" or "mu evaluated on the commutator of xi and eta"

**Conversational:** "The symplectic form omega at mu is defined by pairing mu with the Lie bracket of the two vectors"

---

### Formula: $S^2 \cong SU(2)/U(1)$

**Read as:** "S-two is isomorphic to S-U-two modulo U-one"

**Conversational:** "The two-sphere is isomorphic to the quotient of S-U-two by U-one"

---

### Formula: $\omega = \frac{1}{2}\sin\theta \, d\theta \wedge d\phi$

**Read as:** "Omega equals one-half sine-theta, d-theta wedge d-phi"

**Conversational:** "The symplectic form omega is one-half sine-theta times the wedge product of d-theta and d-phi — this is the area form on the sphere"

---

### Formula: $C(\vec{S}) = S_1^2 + S_2^2 + S_3^2$

**Read as:** "C of S-vector equals S-one-squared plus S-two-squared plus S-three-squared"

**Conversational:** "The Casimir invariant C is the sum of squares of the Stokes components — it measures the purity of the quantum state"

---

### Formula: $(S^2)^{\times n}$

**Read as:** "S-two to the n" or "the n-fold Cartesian product of S-two"

**Conversational:** "The product of n copies of the two-sphere"

---

## 8. Definition 5: Quantum Momentum Map

### Formula: $\mu: \mathcal{S}(\mathcal{H}) \to \mathfrak{g}^*$

**Read as:** "Mu is a map from script-S of script-H to g-star"

**Breaking it down:**
- $\mu$: "mu" or "the momentum map"
- $\mathcal{S}(\mathcal{H})$: "script-S of H" or "the state space" or "the space of density matrices on H"
- $\mathfrak{g}^*$: "g-star" or "the dual of g"

**Conversational:** "The momentum map mu sends quantum states to points in the dual of the Lie algebra"

---

### Formula: $\mu(\rho)_\alpha = \text{Tr}(\rho \, S_\alpha)$

**Read as:** "Mu of rho, sub-alpha, equals the trace of rho times S-alpha"

**Conversational:** "The alpha-component of the momentum map is the expectation value of the observable S-alpha in the state rho"

---

## 9. Definition 6: Lie-Poisson Bracket

### Formula: $\{f, g\}(\mu) = \langle \mu, [df(\mu), dg(\mu)] \rangle$

**Read as:** "The Poisson bracket of f and g, evaluated at mu, equals the pairing of mu with the bracket of d-f at mu and d-g at mu"

**Breaking it down:**
- $\{f, g\}$: "the Poisson bracket of f and g" or "curly-bracket f, g"
- $df(\mu)$: "d-f at mu" or "the differential of f at mu"

**Conversational:** "The Lie-Poisson bracket of two functions f and g is computed by pairing mu with the Lie bracket of their differentials"

---

### Formula: $\{\mu_\alpha, \mu_\beta\} = \mu_{[\alpha, \beta]}$

**Read as:** "The Poisson bracket of mu-alpha and mu-beta equals mu of bracket-alpha-beta"

**Conversational:** "The Poisson bracket of coordinate functions reproduces the Lie algebra structure"

---

### Key observation formula: $\{f, g\} = 0 \Leftrightarrow [df, dg] = 0$

**Read as:** "The Poisson bracket of f and g is zero if and only if the bracket of d-f and d-g is zero"

**Conversational:** "The Poisson bracket vanishes precisely when the observables commute — this characterizes classical simulability"

---

## 10. Proposition 0: Central Criterion

### Formula: $\dim(\mathfrak{g}_{\text{dyn}}) \in O(\text{poly}(n))$

**Read as:** "The dimension of g-dynamical is in order polynomial of n"

**Conversational:** "The dimension of the dynamical Lie algebra grows at most polynomially in the number of qubits"

---

### Alternative: $\mathfrak{g}_{\text{dyn}}$ is abelian

**Read as:** "g-dynamical is abelian"

**Conversational:** "The dynamical Lie algebra is abelian, meaning all elements commute"

---

### Formula: $\mu: \mathcal{S}(\mathcal{H}) \to \mathfrak{g}^*_{\text{dyn}}$

**Read as:** "Mu maps from script-S of H to g-dynamical-star"

**Conversational:** "The momentum map factors through a polynomial-dimensional classical phase space"

---

### Proof formula: $O(t) = e^{iHt} O e^{-iHt}$

**Read as:** "O of t equals e-to-the-i-H-t, times O, times e-to-the-minus-i-H-t"

**Conversational:** "The Heisenberg evolution of observable O is given by conjugation by the time evolution operator"

---

## 11. Definitions 7-8: Contextuality

### Definition 7: Hidden Variable Model

### Formula: $(\Lambda, \Sigma, \nu)$

**Read as:** "The triple Lambda, Sigma, nu" or "a probability space with sample space Lambda, sigma-algebra Sigma, and measure nu"

---

### Formula: $\xi_M: \Lambda \to \{0,1\}$

**Read as:** "Xi-M is a function from Lambda to zero-one"

**Conversational:** "The response function xi-M maps hidden variables to measurement outcomes"

---

### Formula: $\text{Tr}(\rho \, \Pi_M^{(a)}) = \int_\Lambda \xi_M^{(a)}(\lambda) \, d\nu(\lambda)$

**Read as:** "Trace of rho times Pi-M-superscript-a equals the integral over Lambda of xi-M-superscript-a of lambda, d-nu of lambda"

**Breaking it down:**
- $\Pi_M^{(a)}$: "Pi-M-a" or "the projector onto outcome a for measurement M"
- $\int_\Lambda \cdots d\nu(\lambda)$: "the integral over Lambda with respect to the measure nu"

**Conversational:** "The quantum probability of outcome a for measurement M equals the classical average of the response function over all hidden variables"

---

### Definition 8: Contextual Fraction

### Formula: $C_F(\rho) \in [0,1]$

**Read as:** "C-F of rho is in the interval zero to one"

**Conversational:** "The contextual fraction C-F takes values between zero and one"

---

### Formula: $C_F(\rho) = 1 - \max_{p_{\text{NC}}} \{ p_{\text{NC}} : P(\rho) = p_{\text{NC}} \cdot P_{\text{NC}} + (1-p_{\text{NC}}) \cdot P_{\text{C}} \}$

**Read as:** "C-F of rho equals one minus the maximum over p-N-C of p-N-C, subject to the constraint that P of rho equals p-N-C times P-N-C plus one-minus-p-N-C times P-C"

**Conversational:** "The contextual fraction measures how much of the correlation polytope cannot be explained by a noncontextual model. It's one minus the maximum noncontextual weight."

**Key terms:**
- $P(\rho)$: "P of rho" or "the correlation polytope"
- $P_{\text{NC}}$: "P-N-C" or "the noncontextual polytope"
- $p_{\text{NC}}$: "p-N-C" or "the noncontextual weight"

---

## 12. Lemma A: Gottesman-Knill

### Formula: $\theta_v \in \{0, \frac{\pi}{2}, \pi, \frac{3\pi}{2}\}$

**Read as:** "Theta-v is in the set zero, pi-over-two, pi, three-pi-over-two"

**Conversational:** "The measurement angle theta-v is restricted to the Pauli bases: zero, ninety degrees, one-eighty, or two-seventy"

---

### Formula: $\mathbb{Z}_2$-linear

**Read as:** "Z-two-linear" or "Z-mod-two-linear"

**Conversational:** "Linear over the integers modulo two" or "mod-two linear"

---

### Formula: $O(n^2)$

**Read as:** "Order n-squared"

---

### Formula: $O(n^2/\log n)$

**Read as:** "Order n-squared over log-n"

---

## 13. Lemma B: Bounded Treewidth

### Formula: $\text{tw}(G) = w$

**Read as:** "The treewidth of G equals w"

---

### Formula: $O(2^w \cdot \text{poly}(n))$

**Read as:** "Order two-to-the-w times polynomial of n"

**Conversational:** "The complexity scales exponentially in the treewidth, but polynomially in the number of vertices"

---

### Formula: $w \in O(\log n)$

**Read as:** "w is in order log-n"

**Conversational:** "If the treewidth is logarithmic in n, simulation is polynomial time"

---

### Lie-Poisson connection: $\mathfrak{g} = \bigoplus_i \mathfrak{g}_i$

**Read as:** "g equals the direct sum of g-i"

**Conversational:** "The Lie algebra factorizes as a direct sum of smaller algebras"

---

## 14. Lemma C: g-Sim Algorithm

### Formula: $\mathfrak{g}_{\text{dyn}} = \langle \{iH_{\text{CZ}}, iH_k(\theta)\}_k \rangle_{\text{Lie}}$

**Read as:** "g-dynamical equals the Lie closure of the set i-H-C-Z and i-H-k-of-theta for all k"

---

### Formula: $O(d^3)$ where $d = \dim(\mathfrak{g}_{\text{dyn}})$

**Read as:** "Order d-cubed, where d is the dimension of g-dynamical"

**Conversational:** "The g-sim algorithm has cubic complexity in the dimension of the dynamical Lie algebra"

---

## 15. Theorem 1: Sufficient Conditions

### Condition (A): Clifford

**Read as:** "Condition A: All measurements are in Pauli bases with Z-two-linear feed-forward"

---

### Condition (B): Bounded Treewidth

### Formula: $\text{tw}(G) \in O(\log n)$

**Read as:** "The treewidth of G is in order log-n"

---

### Condition (C): Polynomial DLA

### Formula: $\dim(\mathfrak{g}_{\text{dyn}}) \in O(\text{poly}(n))$

**Read as:** "The dimension of g-dynamical is in order polynomial of n"

---

## 16. Theorem 2: Contextuality Barrier

### Formula: $f: \{0,1\}^n \to \{0,1\}$

**Read as:** "f is a function from n-bit strings to a single bit"

**Conversational:** "f is a Boolean function on n inputs"

---

### Main inequality:
### $p_s \leq 1 - (1 - C_F(\rho_G)) \cdot \frac{d_H(f, \text{Aff}_n)}{2^n}$

**Read as:** "p-s is less than or equal to one minus the quantity one-minus-C-F-of-rho-G, times d-H-of-f-comma-Aff-n, divided by two-to-the-n"

**Breaking it down:**
- $p_s$: "p-s" or "the success probability"
- $C_F(\rho_G)$: "C-F of rho-G" or "the contextual fraction of the resource state"
- $d_H(f, \text{Aff}_n)$: "the Hamming distance from f to the affine functions on n bits"
- $\text{Aff}_n$: "Aff-n" or "the set of affine Boolean functions on n bits"

**Conversational:** "The success probability is bounded by a formula involving the contextual fraction and how far the target function is from being affine"

---

### Hamming distance definition:
### $d_H(f, \text{Aff}_n) = \min_{g \in \text{Aff}_n} |\{x : f(x) \neq g(x)\}|$

**Read as:** "d-H of f and Aff-n equals the minimum over all g in Aff-n of the size of the set of x where f-of-x is not equal to g-of-x"

**Conversational:** "The Hamming distance to affine functions is the minimum number of inputs on which f differs from any affine function"

---

### Corollary: $C_F(\rho_G) > 0$

**Read as:** "C-F of rho-G is strictly greater than zero"

**Conversational:** "The resource state must be contextual"

---

## 17. Theorem 3: Structural Partition

### Formula: $\{P_1, \ldots, P_5\} = S_{\text{class}} \sqcup S_{\text{quant}}$

**Read as:** "The set P-one through P-five equals S-class disjoint-union S-quant"

**Breaking it down:**
- $\{P_1, \ldots, P_5\}$: "the set P-one through P-five" or "the five primitives"
- $\sqcup$: "disjoint union"
- $S_{\text{class}}$: "S-class" or "the classically exchangeable primitives"
- $S_{\text{quant}}$: "S-quant" or "the quantum-essential primitives"

**Conversational:** "The five MBQC primitives partition into two disjoint sets: those that can be classically emulated and those that require quantum resources"

---

### Formula: $|S_{\text{quant}}| \geq 1$

**Read as:** "The size of S-quant is at least one"

**Conversational:** "At least one primitive must be quantum-essential"

---

## 18. Theorem 4: Universality Criterion

### Condition (U1): Contextuality

**Read as:** "Condition U-one: The resource state rho-G is contextual, meaning C-F of rho-G is greater than zero"

---

### Condition (U2): Non-Clifford angles

### Formula: $\theta = \pi/8$

**Read as:** "Theta equals pi over eight"

**Conversational:** "Measurement angles include pi-over-eight for T-gate injection"

---

### Condition (U3): Nonlinear feed-forward

### Formula: $\theta_t = f(m_1 \land m_2)$

**Read as:** "Theta-t equals f of m-one AND m-two"

**Conversational:** "The angle theta-t depends on a nonlinear Boolean combination — specifically, the AND of measurement outcomes m-one and m-two"

**Note:** $\land$ is "AND" (logical conjunction)

---

### Corollary: $\mathsf{BPP}$

**Read as:** "B-P-P" or "bounded-error probabilistic polynomial time"

---

## 19. Theorem 5: Complete Classification

### Formula: $\mathfrak{g}_i \subseteq \mathfrak{g}_{\text{dyn}}$

**Read as:** "g-i is a subset of g-dynamical" or "g-i is a Lie subalgebra of g-dynamical"

---

### Corollary: $\dim(\mathfrak{g}_i) \in \Omega(4^n)$

**Read as:** "The dimension of g-i is in big-Omega of four-to-the-n"

**Conversational:** "The dimension of at least one primitive's Lie algebra grows exponentially — at least as fast as four-to-the-n"

---

## 20. DLA Dimension Tables

### Reading the computed values:

| Expression | How to read |
|------------|-------------|
| $\dim(\mathfrak{g}) = 6$ | "The dimension of g equals six" |
| $3n = 6$ | "Three-n equals six" |
| $4^n - 1 = 63$ | "Four-to-the-n minus one equals sixty-three" |
| $4^n - 1 = 255$ | "Four-to-the-n minus one equals two-fifty-five" |

### Summarizing the table:

"For single-qubit Paulis on two qubits, the computed dimension is six, matching the theoretical maximum three-n."

"For Clifford plus C-Z on three qubits, the computed dimension is sixty-three, matching four-to-the-n minus one — this is exponential."

---

## 21. Strategies S1-S6

### Strategy names:

| Strategy | How to say |
|----------|------------|
| S1 | "Strategy S-one" or "the Path-tensor-Polarization strategy" |
| S2 | "Strategy S-two" or "the Mueller matrix strategy" |
| S3 | "Strategy S-three" or "the Spatial O-A-M strategy" (OAM = orbital angular momentum) |
| S4 | "Strategy S-four" or "the Hybrid strategy" |
| S5 | "Strategy S-five" or "the K-L-M boundary" |
| S6 | "Strategy S-six" or "the Postselection strategy" |

### DLA dimensions for strategies:

| Expression | How to read |
|------------|-------------|
| $\dim(\mathfrak{g}) = 4$ | "Dimension four" |
| $\dim(\mathfrak{g}) = 3n$ | "Dimension three-n" |
| $\dim(\mathfrak{g}) = (2L+1)^2$ | "Dimension two-L-plus-one squared" |
| $\dim(\mathfrak{g}) = 4^n - 1$ | "Dimension four-to-the-n minus one" |

### Lie algebras:

| Expression | How to read |
|------------|-------------|
| $\mathfrak{so}(3)$ | "s-o-three" or "the Lie algebra of S-O-three" |
| $\mathfrak{so}(3)^{\otimes k}$ | "s-o-three tensor k" or "k copies of s-o-three" |
| $\mathfrak{u}(1) \oplus \mathfrak{so}(3)$ | "u-one direct-sum s-o-three" |
| $\mathfrak{su}(2^n)$ | "s-u-two-to-the-n" or "s-u of two-to-the-n" |

---

## 22. Quick Reference Card

### Most Common Expressions

| Expression | Quick pronunciation |
|------------|---------------------|
| $\mathfrak{g}_{\text{dyn}}$ | "g-dyn" |
| $\dim(\mathfrak{g})$ | "dim-of-g" |
| $O(\text{poly}(n))$ | "order poly-n" |
| $C_F(\rho)$ | "C-F of rho" |
| $\text{tw}(G)$ | "treewidth of G" |
| $\mathbb{Z}_2$ | "Z-two" or "Z-mod-two" |
| $S^2$ | "S-two" or "the two-sphere" |
| $\mathfrak{su}(2)$ | "s-u-two" |
| $|+\rangle$ | "ket-plus" |
| $\rho_G$ | "rho-G" |
| $[\cdot, \cdot]$ | "the bracket" or "the commutator" |
| $\langle \cdot, \cdot \rangle$ | "the pairing" or "the inner product" |

### Key Phrases for Transitions

**Introducing a definition:**
- "We define..."
- "Let us denote by..."
- "Consider the quantity..."

**Explaining a formula:**
- "This says that..."
- "In other words..."
- "Geometrically, this means..."

**Stating a result:**
- "We have shown that..."
- "It follows that..."
- "The key observation is..."

**Connecting ideas:**
- "This connects to..."
- "Via Proposition zero, we see..."
- "Applying Lemma A..."

---

## Pronunciation Tips

1. **Pause for subscripts:** "rho *pause* sub G" or slow down slightly

2. **Emphasize key words:** "the dimension is *polynomial*" vs "the dimension is *exponential*"

3. **Use "equals" liberally:** It's clearer than "is" for equations

4. **Simplify on second mention:** First: "the dynamical Lie algebra g-dynamical." Later: "g-dyn" or "the DLA"

5. **Spell out acronyms first:** "MBQC — that is, Measurement-Based Quantum Computation"

6. **Use conversational alternatives:** For complex expressions, state them formally once, then explain conversationally

---

## Practice Sentences

1. **Proposition 0:** "An MBQC protocol admits efficient classical simulation if and only if the dimension of the dynamical Lie algebra g-dyn is at most polynomial in n."

2. **Theorem 2:** "If the target function f is nonlinear over Z-two, then high success probability requires a contextual resource state — that is, C-F of rho-G must be strictly positive."

3. **Key insight:** "Quantum advantage emerges precisely when the Lie-Poisson structure becomes non-integrable — when the DLA dimension grows exponentially."

4. **Strategy classification:** "Strategies S-one through S-four all have polynomial-dimensional Lie algebras, satisfying Proposition zero's integrability criterion. Only S-five, the K-L-M protocol, achieves the full exponential dimension of s-u of two-to-the-n."

---

*Good luck with your presentation!*
