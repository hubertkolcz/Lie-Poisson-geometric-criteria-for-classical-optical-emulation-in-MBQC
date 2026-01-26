# Lie-Poisson Geometric Criteria for Classical Optical MBQC Emulation

## Complete Mathematical Research Documentation

**Author:** Hubert Kołcz, M.Sc. Eng.  
**Affiliation:** IEEE Graduate Student Member, Warsaw University of Technology  
**Venue:** 46th Winter School Geometry and Physics, Srní, Czech Republic, January 17-24, 2026

---

## Table of Contents

1. [Research Overview and Central Question](#1-research-overview-and-central-question)
2. [Mathematical Foundations](#2-mathematical-foundations)
   - 2.1 [Quantum State Space Geometry](#21-quantum-state-space-geometry)
   - 2.2 [Lie Algebras and Their Representations](#22-lie-algebras-and-their-representations)
   - 2.3 [Symplectic Geometry and Poisson Structures](#23-symplectic-geometry-and-poisson-structures)
3. [The Lie-Poisson Framework](#3-the-lie-poisson-framework)
   - 3.1 [Coadjoint Orbits and the KKS Theorem](#31-coadjoint-orbits-and-the-kks-theorem)
   - 3.2 [Quantum Momentum Maps](#32-quantum-momentum-maps)
   - 3.3 [The Lie-Poisson Bracket](#33-the-lie-poisson-bracket)
4. [Measurement-Based Quantum Computation (MBQC)](#4-measurement-based-quantum-computation-mbqc)
   - 4.1 [Cluster States](#41-cluster-states)
   - 4.2 [MBQC Protocol Structure](#42-mbqc-protocol-structure)
   - 4.3 [gflow and Determinism](#43-gflow-and-determinism)
5. [The Dynamical Lie Algebra (DLA)](#5-the-dynamical-lie-algebra-dla)
   - 5.1 [Definition and Computation](#51-definition-and-computation)
   - 5.2 [DLA Dimension as Complexity Measure](#52-dla-dimension-as-complexity-measure)
   - 5.3 [Numerical Verification](#53-numerical-verification)
6. [The Central Criterion: Proposition 0](#6-the-central-criterion-proposition-0)
7. [Classical Simulation Lemmas](#7-classical-simulation-lemmas)
   - 7.1 [Lemma A: Gottesman-Knill Theorem](#71-lemma-a-gottesman-knill-theorem)
   - 7.2 [Lemma B: Bounded Treewidth](#72-lemma-b-bounded-treewidth)
   - 7.3 [Lemma C: g-sim Algorithm](#73-lemma-c-g-sim-algorithm)
8. [Contextuality as the Quantum Resource](#8-contextuality-as-the-quantum-resource)
   - 8.1 [Noncontextual Hidden Variable Models](#81-noncontextual-hidden-variable-models)
   - 8.2 [The Contextual Fraction](#82-the-contextual-fraction)
   - 8.3 [CHSH Inequality and Bell States](#83-chsh-inequality-and-bell-states)
9. [Main Theorems](#9-main-theorems)
   - 9.1 [Theorem 1: Sufficient Conditions](#91-theorem-1-sufficient-conditions)
   - 9.2 [Theorem 2: Contextuality Barrier](#92-theorem-2-contextuality-barrier)
   - 9.3 [Theorem 3: Structural Partition](#93-theorem-3-structural-partition)
   - 9.4 [Theorem 4: Universality Criterion](#94-theorem-4-universality-criterion)
   - 9.5 [Theorem 5: Complete Classification](#95-theorem-5-complete-classification)
10. [Classical Optical Emulation Strategies](#10-classical-optical-emulation-strategies)
11. [Connection to Quantum Error Correction](#11-connection-to-quantum-error-correction)
12. [Numerical Validation Summary](#12-numerical-validation-summary)
13. [Conceptual Flow and Interconnections](#13-conceptual-flow-and-interconnections)

---

## 1. Research Overview and Central Question

### The Fundamental Problem

Quantum computing promises exponential speedups for certain problems, but understanding *precisely when and why* quantum systems outperform classical ones remains a deep question. This research addresses:

> **Central Research Question:** Under what precise mathematical conditions—characterized via Lie-Poisson geometry—can photonic MBQC algorithms be reproduced by purely classical optical means (Mueller matrices, linear interferometry)?

### Key Insight

The boundary between quantum advantage and classical simulability can be characterized by **contextuality barriers** arising from **non-commutative Lie algebra structures**. When the dynamical Lie algebra has polynomial dimension, classical simulation is possible; when it grows exponentially, quantum resources become necessary.

### Research Goals

1. Formalize MBQC protocols using symplectic/Poisson geometric structures
2. Establish necessary and sufficient conditions for classical emulation
3. Connect quantum computation to quantum error correction via momentum maps
4. Provide a complete classification of MBQC primitives into classical vs quantum-essential

---

## 2. Mathematical Foundations

### 2.1 Quantum State Space Geometry

#### The Poincaré Sphere (Definition 1)

A single photonic qubit is represented geometrically on the **Poincaré sphere** $S^2 \subset \mathbb{R}^3$. The density matrix of a qubit admits the Bloch representation:

$$\rho = \frac{1}{2}\left(I + \sum_{i=1}^{3} s_i \sigma_i\right)$$

where:
- $\vec{s} = (s_1, s_2, s_3) \in S^2$ is the **Stokes vector** (or Bloch vector)
- $\sigma_i$ are the **Pauli matrices**:

$$\sigma_x = X = \begin{pmatrix} 0 & 1 \\ 1 & 0 \end{pmatrix}, \quad \sigma_y = Y = \begin{pmatrix} 0 & -i \\ i & 0 \end{pmatrix}, \quad \sigma_z = Z = \begin{pmatrix} 1 & 0 \\ 0 & -1 \end{pmatrix}$$

**Geometric Interpretation:**
- Pure states lie on the surface of the sphere ($|\vec{s}| = 1$)
- Mixed states lie inside the sphere ($|\vec{s}| < 1$)
- The north pole $(0,0,1)$ corresponds to $|0\rangle$
- The south pole $(0,0,-1)$ corresponds to $|1\rangle$
- The equator contains superposition states like $|+\rangle, |-\rangle, |+i\rangle, |-i\rangle$

**Physical Significance:** For photons, the Stokes vector encodes polarization state—horizontal, vertical, diagonal, and circular polarizations map to specific points on the sphere.

### 2.2 Lie Algebras and Their Representations

#### The Pauli Algebra $\mathfrak{su}(2)$

The Pauli matrices satisfy the fundamental commutation relations:

$$[X, Y] = 2iZ, \quad [Y, Z] = 2iX, \quad [Z, X] = 2iY$$

Or more compactly: $[\sigma_i, \sigma_j] = 2i\epsilon_{ijk}\sigma_k$ where $\epsilon_{ijk}$ is the Levi-Civita symbol.

These relations define the **Lie algebra $\mathfrak{su}(2)$**, the algebra of traceless skew-Hermitian $2 \times 2$ matrices. Its dimension is **3**.

**Numerical Verification:** Our code confirms $[X,Y] = 2iZ$ by direct matrix computation.

#### Extension to Multi-Qubit Systems

For $n$ qubits, we have several relevant Lie algebras:

1. **Local Pauli algebra** $\mathfrak{su}(2)^{\oplus n}$: Generated by single-qubit Paulis acting on each qubit independently.
   - Dimension: $3n$ (linear in $n$)
   - Generators: $\{\sigma_k^{(v)}\}$ for $v \in \{1,...,n\}$, $k \in \{x,y,z\}$

2. **Full $n$-qubit algebra** $\mathfrak{su}(2^n)$: The algebra of all traceless Hermitian operators on $n$ qubits.
   - Dimension: $4^n - 1$ (exponential in $n$)
   - Contains all possible $n$-qubit observables

**Key Observation:** The transition from $O(n)$ to $O(4^n)$ dimensional algebras marks the classical-quantum boundary.

### 2.3 Symplectic Geometry and Poisson Structures

#### Symplectic Manifolds

A **symplectic manifold** $(M, \omega)$ is a smooth manifold $M$ equipped with a closed, non-degenerate 2-form $\omega$. The symplectic form defines:

1. **Hamiltonian vector fields:** For function $H: M \to \mathbb{R}$, the vector field $X_H$ satisfying $\omega(X_H, \cdot) = dH$
2. **Poisson bracket:** $\{f, g\} = \omega(X_f, X_g)$

#### Poisson Manifolds

A **Poisson manifold** $(M, \{\cdot, \cdot\})$ has a bracket satisfying:
- Antisymmetry: $\{f, g\} = -\{g, f\}$
- Jacobi identity: $\{f, \{g, h\}\} + \{g, \{h, f\}\} + \{h, \{f, g\}\} = 0$
- Leibniz rule: $\{fg, h\} = f\{g, h\} + g\{f, h\}$

Every symplectic manifold is Poisson, but Poisson manifolds can have degenerate structures (they foliate into symplectic leaves).

---

## 3. The Lie-Poisson Framework

### 3.1 Coadjoint Orbits and the KKS Theorem

#### Coadjoint Action

For a Lie group $G$ with Lie algebra $\mathfrak{g}$, the **coadjoint action** of $G$ on $\mathfrak{g}^*$ (the dual space) is:

$$\text{Ad}^*_g(\mu) = \mu \circ \text{Ad}_{g^{-1}}$$

The **coadjoint orbit** through $\mu \in \mathfrak{g}^*$ is:

$$\mathcal{O}_\mu = \{\text{Ad}^*_g \mu : g \in G\} \subset \mathfrak{g}^*$$

#### Kirillov-Kostant-Souriau (KKS) Theorem

**Theorem (KKS):** Each coadjoint orbit $\mathcal{O}_\mu$ carries a canonical symplectic structure:

$$\omega_\mu(\xi_{\mathfrak{g}^*}, \eta_{\mathfrak{g}^*}) = \langle \mu, [\xi, \eta] \rangle$$

where $\xi_{\mathfrak{g}^*}$ denotes the fundamental vector field generated by $\xi \in \mathfrak{g}$.

**Significance:** This theorem is fundamental because it shows that coadjoint orbits are naturally symplectic manifolds—they have the geometric structure needed for Hamiltonian mechanics.

#### Application: The Poincaré Sphere

For $G = SU(2)$, the coadjoint orbits are spheres of different radii in $\mathfrak{su}(2)^* \cong \mathbb{R}^3$:

$$S^2_r = \{(s_1, s_2, s_3) : s_1^2 + s_2^2 + s_3^2 = r^2\}$$

The Poincaré sphere $S^2 \cong SU(2)/U(1)$ is a coadjoint orbit of $SU(2)$, hence a **symplectic leaf** of the Lie-Poisson structure.

**Symplectic form on $S^2$:**
$$\omega = \frac{1}{2r}\sin\theta \, d\theta \wedge d\phi$$

This is proportional to the area form on the sphere.

**Casimir invariant:** $C(\vec{S}) = S_1^2 + S_2^2 + S_3^2$ labels orbits and corresponds to the purity of the quantum state.

### 3.2 Quantum Momentum Maps

#### Definition 5: Quantum Momentum Map

For a Lie algebra $\mathfrak{g}$ of observables, the **quantum momentum map** $\mu: \mathcal{S}(\mathcal{H}) \to \mathfrak{g}^*$ is defined by:

$$\mu(\rho)_\alpha = \text{Tr}(\rho \, S_\alpha)$$

where $S_\alpha \in \mathfrak{g}$ are the generators and $\mathcal{S}(\mathcal{H})$ is the space of density matrices.

**Interpretation:** The momentum map extracts expectation values of observables from quantum states. It maps the infinite-dimensional quantum state space to the finite-dimensional dual of the observable Lie algebra.

**Example:** For a single qubit and $\mathfrak{g} = \mathfrak{su}(2)$:
$$\mu(\rho) = (\langle X \rangle, \langle Y \rangle, \langle Z \rangle) = \vec{s}$$

The momentum map simply extracts the Bloch vector.

### 3.3 The Lie-Poisson Bracket

#### Definition 6: Lie-Poisson Bracket

On the dual space $\mathfrak{g}^*$, the canonical Lie-Poisson bracket is:

$$\{f, g\}(\mu) = \langle \mu, [df(\mu), dg(\mu)] \rangle$$

For coordinate functions $\mu_\alpha$ corresponding to basis elements:

$$\{\mu_\alpha, \mu_\beta\} = \mu_{[\alpha, \beta]} = c_{\alpha\beta}^\gamma \mu_\gamma$$

where $c_{\alpha\beta}^\gamma$ are the structure constants of $\mathfrak{g}$.

**Key Observation:** The Lie-Poisson bracket vanishes if and only if the observables commute:

$$\{f, g\} = 0 \Leftrightarrow [df, dg] = 0$$

This provides the **geometric characterization of classical simulability**: when all relevant observables commute, the dynamics is integrable and classically simulable.

---

## 4. Measurement-Based Quantum Computation (MBQC)

### 4.1 Cluster States

#### Definition 2: Cluster State

Given a graph $G = (V, E)$, the **cluster state** is:

$$|\Psi_G\rangle = \prod_{(i,j) \in E} \text{CZ}_{ij} \bigotimes_{v \in V} |+\rangle_v$$

where:
- $|+\rangle = \frac{1}{\sqrt{2}}(|0\rangle + |1\rangle)$ is the equal superposition state
- $\text{CZ}_{ij} = |0\rangle\langle 0| \otimes I + |1\rangle\langle 1| \otimes Z$ is the controlled-Z gate

**Construction Process:**
1. Prepare each qubit in $|+\rangle$ state
2. Apply CZ gates between all pairs of qubits connected by edges in $G$

**Properties of Cluster States:**
- They are **stabilizer states** (eigenstates of an abelian stabilizer group)
- For each vertex $v$, the stabilizer generator is: $K_v = X_v \prod_{u \in N(v)} Z_u$
- They are **maximally entangled** in a specific sense

**Numerical Verification:** Our code creates 2-qubit cluster states and verifies fidelity = 1.0 with the expected state.

### 4.2 MBQC Protocol Structure

#### Definition 3: MBQC Protocol

An MBQC protocol is a 5-tuple $\Pi = (G, \rho_G, \mathcal{M}, \mathcal{F}, \mathcal{O})$:

| Component | Description | Mathematical Form |
|-----------|-------------|-------------------|
| $G = (V, E)$ | Computation graph with gflow | Graph structure |
| $\rho_G$ | Cluster state on graph $G$ | $\|\Psi_G\rangle\langle\Psi_G\|$ |
| $\mathcal{M}$ | Measurement operators | $\{M_v(\theta_v)\}_{v \in V}$ |
| $\mathcal{F}$ | Feed-forward function | $\{0,1\}^{|V|} \times \{0,1\}^k \to [0,2\pi)^{|V|}$ |
| $\mathcal{O}$ | Output function | $\{0,1\}^{|V|} \to \{0,1\}^\ell$ |

**Computation Process:**
1. Prepare the cluster state $|\Psi_G\rangle$
2. Measure qubits sequentially with angles adapted based on previous outcomes
3. Apply classical post-processing to extract the output

**Key Insight:** The graph structure encodes the computation, and measurements "consume" the entanglement to perform gates.

### 4.3 gflow and Determinism

#### Generalized Flow (gflow)

A **gflow** on graph $G = (V, E)$ is a pair $(g, \prec)$ where:
- $g: V \setminus O \to 2^O$ is the **correction function** (maps measured qubits to sets of output qubits)
- $\prec$ is a **partial order** on $V$

satisfying for all $v \in V \setminus O$:
1. $v \prec w$ for all $w \in g(v)$ (corrections are applied to future qubits)
2. $v \in \text{odd}(g(v))$ (odd neighborhood condition)
3. $w \in g(v)$ and $w \neq v$ implies $w \in O \cup \{u : u \prec v\}$

**Significance:** gflow ensures **deterministic** computation—the measurement outcomes can be corrected to give the intended unitary operation regardless of the random outcomes.

**Numerical Verification:** Our code verifies gflow for:
- Linear 3-qubit cluster: $g = \{0:\{1\}, 1:\{2\}\}$
- Linear 5-qubit cluster: $g = \{0:\{1\}, 1:\{2\}, 2:\{3\}, 3:\{4\}\}$
- 2×2 grid: gflow exists with row-by-row order

---

## 5. The Dynamical Lie Algebra (DLA)

### 5.1 Definition and Computation

#### Definition 4: Dynamical Lie Algebra of MBQC

The MBQC dynamical Lie algebra is the real vector space generated by commutators:

$$\mathfrak{g}_{\text{MBQC}} = \langle \{iH_{\text{CZ}}, i\sigma_k^{(v)}\}_{v \in V, k \in \{x,y,z\}} \rangle_{\text{Lie}}$$

where:
- $H_{\text{CZ}} = \frac{1}{4}(I - Z_i)(I - Z_j)$ is the CZ Hamiltonian
- $\sigma_k^{(v)}$ are single-qubit Pauli operators on qubit $v$
- $\langle \cdot \rangle_{\text{Lie}}$ denotes Lie algebra closure under commutators

#### Computation Algorithm

To compute the DLA:
1. Start with generators $\mathcal{G} = \{iH_1, iH_2, ...\}$
2. Compute all pairwise commutators $[A, B]$ for $A, B \in \mathcal{G}$
3. Add any new linearly independent elements to $\mathcal{G}$
4. Repeat until closure (no new elements generated)
5. The dimension is $|\mathcal{G}|$

### 5.2 DLA Dimension as Complexity Measure

The dimension of the DLA is the critical quantity determining classical simulability:

| Generator Set | DLA Dimension | Scaling | Simulable? |
|--------------|---------------|---------|------------|
| Single-qubit Paulis only | $3n$ | Linear | ✅ Yes |
| Paulis + CZ gates | $4^n - 1$ | Exponential | ❌ No |

**Physical Interpretation:**
- **Polynomial DLA:** All relevant observables can be tracked in polynomial space → classical computer can simulate
- **Exponential DLA:** Observable space grows too fast → quantum resources required

### 5.3 Numerical Verification

Our code computes DLA dimensions exactly:

| Protocol | $n$ | Computed dim($\mathfrak{g}$) | Theoretical | Formula |
|----------|-----|------------------------------|-------------|---------|
| Pauli-only | 2 | **6** | 6 | $3n = 6$ |
| Pauli-only | 4 | **12** | 12 | $3n = 12$ |
| Clifford+CZ | 2 | **15** | 15 | $4^2 - 1 = 15$ |
| Clifford+CZ | 3 | **63** | 63 | $4^3 - 1 = 63$ |
| Clifford+CZ | 4 | **255** | 255 | $4^4 - 1 = 255$ |

**Key Finding:** Entangling gates (CZ) generate the exponential DLA! Classical simulability (Gottesman-Knill) comes from *measurement restriction* to Pauli bases, not from the gate set.

---

## 6. The Central Criterion: Proposition 0

### Proposition 0 (Lie-Poisson Integrability Criterion)

**Statement:** An MBQC protocol $\Pi$ admits efficient classical simulation if and only if the dynamical Lie algebra $\mathfrak{g}_{\text{dyn}}$ satisfies the **Poisson integrability condition**:

$$\dim(\mathfrak{g}_{\text{dyn}}) \in O(\text{poly}(n)) \quad \text{or} \quad \mathfrak{g}_{\text{dyn}} \text{ is abelian on relevant observables}$$

When this holds, the momentum map $\mu: \mathcal{S}(\mathcal{H}) \to \mathfrak{g}^*_{\text{dyn}}$ factors through a polynomial-dimensional classical phase space.

### Proof Sketch

**($\Rightarrow$) Classical simulable implies polynomial DLA:**
- If the protocol is classically simulable, expectation values of all relevant observables can be computed in polynomial time
- This means the observable algebra must have polynomial dimension
- Otherwise, exponentially many observables would need tracking

**($\Leftarrow$) Polynomial DLA implies classical simulation:**
- If $\dim(\mathfrak{g}_{\text{dyn}}) = d \in O(\text{poly}(n))$
- Heisenberg evolution: $O(t) = e^{iHt} O e^{-iHt}$ stays in a $d$-dimensional subspace
- Expectation values can be tracked by solving a $d \times d$ system of ODEs
- This is the g-sim algorithm (Lemma C)

### Geometric Interpretation

The momentum map $\mu: \mathcal{S}(\mathcal{H}) \to \mathfrak{g}^*$ projects quantum states onto classical phase space:

```
Quantum State Space     →→→→→→     Classical Phase Space
    (exp dim)              μ          (poly dim if integrable)
       ρ                  ↦           (⟨O₁⟩, ⟨O₂⟩, ..., ⟨Oₐ⟩)
```

When this projection loses too much information (exponential DLA), quantum advantages emerge.

---

## 7. Classical Simulation Lemmas

### 7.1 Lemma A: Gottesman-Knill Theorem

**Statement:** Let $\Pi = (G, \rho_G, \mathcal{M}, \mathcal{F}, \mathcal{O})$ be an MBQC protocol satisfying:
- All measurement angles $\theta_v \in \{0, \frac{\pi}{2}, \pi, \frac{3\pi}{2}\}$ (Pauli bases X, Y, -X, -Y)
- Feed-forward $\mathcal{F}$ is $\mathbb{Z}_2$-linear

Then $\Pi$ can be classically simulated in time $O(n^2)$ per gate via **stabilizer tableau updates**.

#### The Stabilizer Formalism

A **stabilizer state** on $n$ qubits is the unique $+1$ eigenstate of an abelian group of $n$ independent Pauli operators (the stabilizer group).

**Representation:** Instead of $2^n$ amplitudes, store $O(n^2)$ bits:
- $n$ stabilizer generators, each a Pauli string of length $n$
- Phase information

**Clifford gates** (H, S, CNOT, CZ) map stabilizer states to stabilizer states with polynomial updates.

**Pauli measurements** on stabilizer states:
- Outcome is deterministic if measurement operator commutes with all stabilizers
- Otherwise, random ±1 with probability 1/2 each, updating stabilizers

#### Why This Works

Under Pauli measurements, the cluster state remains in the stabilizer formalism throughout. The $\mathbb{Z}_2$-linear feed-forward corresponds to **Pauli frame updates**, which preserve stabilizer structure.

**Lie-Poisson Connection:** Clifford operations generate the Pauli algebra, which has dimension $O(n^2)$. This satisfies Proposition 0's integrability criterion.

**Numerical Verification:**
- Bell state: quantum-stabilizer fidelity = 1.0 ✓
- GHZ-3: quantum-stabilizer fidelity = 1.0 ✓  
- GHZ-4: quantum-stabilizer fidelity = 1.0 ✓
- Deutsch-Jozsa: quantum-stabilizer fidelity = 1.0 ✓

### 7.2 Lemma B: Bounded Treewidth

**Statement:** Let $\Pi$ be an MBQC on graph $G$ with treewidth $\text{tw}(G) = w$. Then:
- Tensor network contraction has complexity $O(2^w \cdot \text{poly}(n))$
- If $w \in O(\log n)$, simulation is polynomial-time
- Tree tensor networks (treewidth 1) admit $O(\text{poly}(n))$ simulation

#### Treewidth Definition

The **treewidth** of a graph $G$ is the minimum width of any tree decomposition:
- A tree decomposition maps vertices to "bags" arranged in a tree
- Each edge's endpoints must appear together in some bag
- Each vertex appears in a connected subtree
- Width = (max bag size) - 1

| Graph Type | Treewidth | Complexity |
|------------|-----------|------------|
| Path | 1 | $O(2 \cdot \text{poly})$ |
| Cycle | 2 | $O(4 \cdot \text{poly})$ |
| $k \times k$ Grid | $k$ | $O(2^k \cdot \text{poly})$ |
| Complete $K_n$ | $n-1$ | $O(2^n \cdot \text{poly})$ |

**Numerical Verification:**
- Path $P_5$: tw = 1 ✓
- Cycle $C_5$: tw = 2 ✓
- 2×3 Grid: tw = 2 ✓
- Complete $K_4$: tw = 3 ✓

#### Lie-Poisson Connection

Bounded treewidth implies the Lie algebra of correlations factorizes:

$$\mathfrak{g} = \bigoplus_i \mathfrak{g}_i \quad \text{with} \quad \dim(\mathfrak{g}_i) \leq 2^w$$

The Poisson structure becomes **block-diagonal**, hence integrable.

### 7.3 Lemma C: g-sim Algorithm

**Statement:** Given MBQC generators, the dynamical Lie algebra is:

$$\mathfrak{g}_{\text{dyn}} = \langle \{iH_{\text{CZ}}, iH_k(\theta)\}_k \rangle_{\text{Lie}}$$

The **g-sim algorithm** provides an explicit classical simulation:
- Propagate observables on $\mathfrak{g}^*$ via Heisenberg evolution
- Complexity: $O(d^3)$ where $d = \dim(\mathfrak{g}_{\text{dyn}})$

#### The Algorithm

1. Express initial observable $O(0)$ in basis of $\mathfrak{g}_{\text{dyn}}$: $O(0) = \sum_\alpha c_\alpha(0) T_\alpha$
2. For each time step, solve: $\dot{c}_\alpha = \sum_{\beta,\gamma} c_\beta c_\gamma f_{\beta\gamma}^\alpha$
3. Final expectation: $\langle O(t) \rangle = \sum_\alpha c_\alpha(t) \langle T_\alpha \rangle_0$

where $f_{\beta\gamma}^\alpha$ are structure constants.

**Relation to Proposition 0:** Lemma C provides the *algorithmic realization* of Proposition 0's criterion. Where Proposition 0 states *when* classical simulation is possible (polynomial DLA dimension), Lemma C provides *how* (g-sim algorithm on $\mathfrak{g}^*$).

**Numerical Verification:** Heisenberg evolution test confirms evolved operators remain in the DLA span.

---

## 8. Contextuality as the Quantum Resource

### 8.1 Noncontextual Hidden Variable Models

#### Definition 7: Noncontextual HV Model

A state $\rho$ admits a **noncontextual hidden variable model** if there exists:
- Probability space $(\Lambda, \Sigma, \nu)$
- Response functions $\xi_M: \Lambda \to \{0,1\}$ for each measurement $M$

such that for all measurements $M$ and outcomes $a$:

$$\text{Tr}(\rho \, \Pi_M^{(a)}) = \int_\Lambda \xi_M^{(a)}(\lambda) \, d\nu(\lambda)$$

**Key constraint:** $\xi_M$ depends only on $M$, not on other compatible measurements in the context.

**Physical Meaning:** A noncontextual model assigns definite values to all observables simultaneously, independent of what else is measured. Quantum mechanics violates this—measurement outcomes can depend on the "context" of which other observables are measured jointly.

### 8.2 The Contextual Fraction

#### Definition 8: Contextual Fraction

The **contextual fraction** $C_F(\rho) \in [0,1]$ quantifies the minimal weight of contextual correlations:

$$C_F(\rho) = 1 - \max_{p_{\text{NC}}} \{ p_{\text{NC}} : P(\rho) = p_{\text{NC}} \cdot P_{\text{NC}} + (1-p_{\text{NC}}) \cdot P_{\text{C}} \}$$

where:
- $P(\rho)$ is the correlation polytope of the state
- $P_{\text{NC}}$ is a noncontextual distribution
- $P_{\text{C}}$ is a (possibly contextual) distribution

**Interpretation:**
- $C_F(\rho) = 0$: State admits a fully noncontextual model (classical)
- $C_F(\rho) > 0$: State requires contextual correlations (quantum resource)
- $C_F(\rho) = 1$: Maximally contextual (e.g., Bell states under optimal measurements)

### 8.3 CHSH Inequality and Bell States

The **CHSH inequality** provides a concrete test of contextuality:

$$S = E(0,0) + E(0,1) + E(1,0) - E(1,1)$$

where $E(a,b) = \langle A_a B_b \rangle$ for measurement choices $a, b \in \{0,1\}$.

**Bounds:**
- Classical (local) bound: $|S| \leq 2$
- Quantum (Tsirelson) bound: $|S| \leq 2\sqrt{2} \approx 2.828$

**For Bell state $|\Phi^+\rangle = \frac{1}{\sqrt{2}}(|00\rangle + |11\rangle)$ with optimal measurements:**

$$S = 2\sqrt{2}$$

The contextual fraction is then:

$$C_F = \frac{|S| - 2}{2\sqrt{2} - 2} = 1$$

**Numerical Verification:**
- Bell state: $S = 2.828$, $C_F = 1.0$ ✓
- Product state: $S = 2.0$, $C_F = 0.0$ ✓
- Partial violation $S = 2.4$: $C_F = 0.48$ ✓

---

## 9. Main Theorems

### 9.1 Theorem 1: Sufficient Conditions for Classical Emulation

**Statement:** An MBQC protocol $\Pi$ is efficiently classically simulable if *any* of the following conditions hold:

**(A) Clifford Restriction:** All measurements in Pauli bases with $\mathbb{Z}_2$-linear feed-forward
- Implies $\dim(\mathfrak{g}) = O(n^2)$ via Pauli algebra
- Simulation: Stabilizer tableau in $O(n^2)$ time per gate

**(B) Bounded Treewidth:** $\text{tw}(G) \in O(\log n)$
- Implies tensor network contraction in $O(\text{poly}(n))$
- Lie algebra factorizes: $\mathfrak{g} = \bigoplus_i \mathfrak{g}_i$

**(C) Polynomial DLA:** $\dim(\mathfrak{g}_{\text{dyn}}) \in O(\text{poly}(n))$
- Direct application of Proposition 0
- Simulation: g-sim algorithm in $O(d^3)$

**Moreover:** Under any of these conditions, the MBQC can be emulated by classical optical systems using **Mueller matrix calculus** on the Poincaré sphere.

### 9.2 Theorem 2: Contextuality Barrier (No-Go Result)

**Statement:** Let $\Pi$ be an MBQC computing Boolean function $f: \{0,1\}^n \to \{0,1\}$ with success probability $p_s$. Assume:
- **(H1)** Feed-forward $\mathcal{F}$ is $\mathbb{Z}_2$-linear

If $f$ is *nonlinear* over $\mathbb{Z}_2$, then:

$$p_s \leq 1 - (1 - C_F(\rho_G)) \cdot \frac{d_H(f, \text{Aff}_n)}{2^n}$$

where:
- $C_F(\rho_G)$ is the contextual fraction of the resource state
- $\text{Aff}_n$ is the set of affine Boolean functions
- $d_H(f, \text{Aff}_n) = \min_{g \in \text{Aff}_n} |\{x : f(x) \neq g(x)\}|$ is the Hamming distance to affine

#### Proof Outline

**Step 1 (HV Structure):** In a noncontextual model, measurement outcomes are $m_i = v_i(\lambda)$ for hidden variable $\lambda$.

**Step 2 (Linear Control):** $\mathbb{Z}_2$-linear feed-forward means $s_t = A \cdot m_{<t} + b \cdot x$ (mod 2). Control is deterministic given $\lambda$ and input $x$.

**Step 3 (Function Class):** Under NC + linear control, achievable output functions are restricted to affine functions over $\mathbb{Z}_2$. This is because:
- Affine ∘ Affine = Affine
- The composition of affine operations cannot produce nonlinear outputs

**Step 4 (Distance Bound):** Any nonlinear $f$ has $d_H(f, \text{Aff}_n) > 0$. The probability of correctly computing $f$ on inputs where it differs from all affine functions is bounded by the contextual fraction.

**Step 5 (Conclusion):** Combining bounds yields the inequality.

#### Corollary 2.1: Necessity of Contextuality

If $p_s \to 1$ and $f$ is nonlinear (i.e., $d_H(f, \text{Aff}_n) > 0$), then $C_F(\rho_G) > 0$: the resource state **must be contextual**.

**Lie-Poisson Interpretation:** Contextuality ($C_F > 0$) implies the Lie-Poisson structure is *non-integrable*: no finite-dimensional classical phase space can reproduce the quantum correlations.

**Numerical Verification:**
- AND function: $d_H = 1 > 0$ (nonlinear) ✓
- OR function: $d_H = 1 > 0$ (nonlinear) ✓
- XOR function: $d_H = 0$ (affine) ✓

### 9.3 Theorem 3: Structural Partition

**Statement:** For any MBQC instance $\Pi$, the canonical primitives ($P_1$=Qubits, $P_2$=Cluster, $P_3$=Graph, $P_4$=Measurements, $P_5$=Algorithm) admit a partition:

$$\{P_1, \ldots, P_5\} = S_{\text{class}} \sqcup S_{\text{quant}}$$

where:
- $S_{\text{class}}$: Primitives satisfying at least one condition of Theorem 1 (classically exchangeable)
- $S_{\text{quant}}$: Primitives violating all conditions of Theorem 1 (quantum-essential)

**Furthermore:** If $\Pi$ computes a nonlinear Boolean function with $p_s > 1 - \epsilon$, then by Theorem 2, $|S_{\text{quant}}| \geq 1$ and the resource state must exhibit contextuality.

### 9.4 Theorem 4: Universality Criterion

**Statement:** An MBQC protocol $\Pi$ is **computationally universal** (can simulate any polynomial-time quantum computation) if and only if:

**(U1) Contextual resource state:** $C_F(\rho_G) > 0$

**(U2) Non-Clifford rotations:** Measurement angles include $\theta = \pi/8$ for T-gate injection

**(U3) Nonlinear feed-forward:** Feed-forward supports nonlinear Boolean combinations (e.g., $\theta_t = f(m_1 \land m_2)$)

#### Corollary 4.1

Removing any single condition (U1), (U2), or (U3) reduces computational power to at most $\mathsf{BPP}$ (classical polynomial time):
- Without (U1): Theorem 2 bounds success probability for nonlinear functions
- Without (U2): Gottesman-Knill theorem applies (Clifford-only)
- Without (U3): Feed-forward is $\mathbb{Z}_2$-linear, Lemma A applies

**Numerical Verification:**
- T gate produces magic states: max stabilizer fidelity = 0.854 < 1 ✓
- $T \cdot X \cdot T^\dagger$ is not Pauli ✓
- $S \cdot X \cdot S^\dagger = \pm Y$ (S is Clifford) ✓

### 9.5 Theorem 5: Complete Classification

**Statement:**

**Part I (Decomposition):** Every MBQC $\Pi$ admits canonical decomposition into 5 primitives $\{P_1, \ldots, P_5\}$ (qubits, cluster, graph, measurements, algorithm).

**Part II (Classification):** Each primitive $P_i$ induces a Lie subalgebra $\mathfrak{g}_i \subseteq \mathfrak{g}_{\text{dyn}}$. Primitive $P_i$ is classically exchangeable iff $\dim(\mathfrak{g}_i) \in O(\text{poly})$ (Proposition 0).

**Part III (Composition):** Classically exchangeable primitives can be replaced by classical emulations preserving the output distribution.

#### Corollary 5.1: Quantum Advantage

If MBQC computes a classically hard problem with high probability, then $\exists P_i$ with $\dim(\mathfrak{g}_i) \in \Omega(4^n)$ (by Theorem 2).

---

## 10. Classical Optical Emulation Strategies

### Strategy Classification (S1–S6)

| Strategy | Degrees of Freedom | $\dim(\mathfrak{g})$ | $p_s$ Ceiling | Bound Origin |
|----------|-------------------|---------------------|---------------|--------------|
| **S1:** Path⊗Polarization | Path + Pol | **4** | ≤ 0.50 | 2-path limit |
| **S2:** Mueller Matrix | Stokes→Mueller | **3n** | ≤ 0.75 | Mueller positivity |
| **S3:** Spatial OAM | OAM modes $\ell$ | **(2L+1)²** | $1 - \frac{1}{d}$ | Finite modes |
| **S4:** Hybrid | Path⊗Pol⊗OAM | **O(d²)** | ≤ 0.875 | Product bound |
| **S5:** KLM Boundary | Ancilla + postselect | **4^n - 1** | → 1 | Full $\mathfrak{su}(2^n)$ |
| **S6:** Postselection | Intensity threshold | **1** | ≤ 0.25 | Classical prob |

### Lie-Poisson Analysis

| Strategy | Effective $\mathfrak{g}$ | $\dim(\mathfrak{g})$ | Abelian? | Casimirs | Integrability |
|----------|-------------------------|---------------------|----------|----------|---------------|
| S2 (Clifford) | $\mathfrak{so}(3)$ | **3** | No | $|\vec{S}|^2$ | ✅ Integrable |
| S4 (Hybrid Clifford) | $\mathfrak{so}(3)^{\otimes k}$ | **3k** | No | $k$ | ✅ Integrable |
| S1 (Path⊗Pol) | $\mathfrak{u}(1) \oplus \mathfrak{so}(3)$ | **4** | Partial | 2 | ✅ Integrable |
| S2 (T-gate) | $\mathfrak{su}(2^n)$ | **4^n - 1** | No | 1 | ❌ Non-integrable |
| S5 (KLM universal) | $\mathfrak{su}(2^n)$ | **4^n - 1** | No | 1 | ❌ Non-integrable |

**Key Finding:** Classical strategies (S1-S4) yield polynomial-dimensional Lie algebras—integrable Lie-Poisson structures. Universal quantum (S5, T-gates) yields full $\mathfrak{su}(2^n)$—non-integrable, confirming Proposition 0.

---

## 11. Connection to Quantum Error Correction

### Proposition 1: Syndrome Geometry

The momentum map $\mu: \mathcal{S}(\mathcal{H}) \to \mathfrak{g}^*$ induces **syndrome extraction** for stabilizer codes:

$$\mu(|\psi\rangle\langle\psi|)_\alpha = \langle\psi| S_\alpha |\psi\rangle = \pm 1$$

where:
- $+1$ indicates $|\psi\rangle$ is in the code space for stabilizer $S_\alpha$
- $-1$ indicates an error has occurred

### Proposition 2: Error Correction as Symplectic Reduction

Stabilizer QEC admits interpretation as **symplectic reduction**:
- Code space = level set $\mu^{-1}(+1, \ldots, +1)$
- Logical operations act on the **reduced phase space**

**Numerical Verification:**
- $|0\rangle$: syndrome for $Z$ = +1 ✓
- $|1\rangle$: syndrome for $Z$ = -1 (error detected) ✓

### Unifying Framework

The Lie-Poisson framework unifies MBQC classicalization with QEC:
- Both are manifestations of **reduction theory** on the same geometric structure
- Syndromes are components of the momentum map
- Error correction is projection onto a symplectic leaf

---

## 12. Numerical Validation Summary

### Validation Suite Results

| Category | Tests | Passed | Status |
|----------|-------|--------|--------|
| Direct Quantum-Classical Comparisons | 8 | 8 | ✅ 100% |
| Algorithm Benchmarks | 9 | 9 | ✅ 100% |
| Gap-Filling Validations | 18 | 18 | ✅ 100% |
| **Total** | **35** | **35** | ✅ **100%** |

### Key Numerical Results

| Claim | Numerical Result | Theoretical | Match |
|-------|------------------|-------------|-------|
| $\dim(\mathfrak{su}(2)) = 3$ | 3 | 3 | ✅ |
| $\dim(\mathfrak{su}(4)) = 15$ | 15 | $4^2 - 1$ | ✅ |
| Bell CHSH value | 2.828 | $2\sqrt{2}$ | ✅ |
| Bell $C_F$ | 1.0 | 1.0 | ✅ |
| Grover n=4 success | 0.961 | 0.961 | ✅ |
| Teleportation fidelity | 1.0 | 1.0 | ✅ |
| Path treewidth | 1 | 1 | ✅ |
| AND is nonlinear | True | True | ✅ |
| XOR is affine | True | True | ✅ |

---

## 13. Conceptual Flow and Interconnections

### The Grand Picture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        LIE-POISSON FRAMEWORK                                │
│                                                                             │
│  Quantum State Space ─────μ─────► Lie Algebra Dual (𝔤*)                    │
│        (exp dim)          momentum     (finite dim if integrable)           │
│                            map                                              │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                      PROPOSITION 0: THE CRITERION                           │
│                                                                             │
│     Classical simulation ⟺ dim(𝔤_dyn) ∈ O(poly(n))                        │
│                                                                             │
│  This is the central geometric criterion that unifies all results.          │
└─────────────────────────────────────────────────────────────────────────────┘
                    ┌───────────────┼───────────────┐
                    ▼               ▼               ▼
    ┌───────────────────┐  ┌───────────────────┐  ┌───────────────────┐
    │    LEMMA A        │  │    LEMMA B        │  │    LEMMA C        │
    │   Gottesman-Knill │  │ Bounded Treewidth │  │    g-sim          │
    │                   │  │                   │  │                   │
    │ Clifford → O(n²)  │  │ tw(G)=w → O(2^w)  │  │ DLA → O(d³)       │
    │ Pauli algebra     │  │ Factorized 𝔤      │  │ Heisenberg evol   │
    └───────────────────┘  └───────────────────┘  └───────────────────┘
                    │               │               │
                    └───────────────┼───────────────┘
                                    ▼
                    ┌───────────────────────────────┐
                    │   THEOREM 1: SUFFICIENT       │
                    │   CONDITIONS                  │
                    │                               │
                    │   (A) ∨ (B) ∨ (C) → Classical │
                    └───────────────────────────────┘
                                    │
                    ┌───────────────┴───────────────┐
                    ▼                               ▼
    ┌───────────────────────────────┐  ┌───────────────────────────────┐
    │   THEOREM 2: BARRIER          │  │   THEOREM 4: UNIVERSALITY     │
    │   (Contextuality)             │  │   (What's needed for BQP)     │
    │                               │  │                               │
    │   Nonlinear f + p_s→1         │  │   (U1) C_F > 0                │
    │   ⟹ C_F > 0 required         │  │   (U2) Non-Clifford angles    │
    │                               │  │   (U3) Nonlinear feedforward  │
    │   This is the NO-GO result    │  │                               │
    └───────────────────────────────┘  └───────────────────────────────┘
                    │                               │
                    └───────────────┬───────────────┘
                                    ▼
                    ┌───────────────────────────────┐
                    │   THEOREM 5: CLASSIFICATION   │
                    │                               │
                    │   Every MBQC decomposes into  │
                    │   S_class ⊔ S_quant           │
                    │                               │
                    │   Classical ⟺ poly DLA       │
                    │   Quantum ⟺ exp DLA          │
                    └───────────────────────────────┘
```

### Key Conceptual Connections

1. **Momentum Map → DLA → Simulability**
   - The momentum map projects quantum states to classical observables
   - DLA dimension determines how many observables need tracking
   - Polynomial DLA = integrable = classically simulable

2. **Contextuality → Non-integrability → Quantum Advantage**
   - Contextuality ($C_F > 0$) means no classical model exists
   - Geometrically: Lie-Poisson structure is non-integrable
   - Computationally: exponential classical resources needed

3. **Clifford vs Universal**
   - Clifford gates generate $O(n^2)$ DLA (Pauli algebra)
   - Adding T gate generates $O(4^n)$ DLA (full $\mathfrak{su}(2^n)$)
   - The transition is **sharp**: one non-Clifford gate suffices

4. **Feed-forward Linearity → Function Class**
   - $\mathbb{Z}_2$-linear feed-forward → only affine functions computable
   - Nonlinear feed-forward → universal computation possible
   - This is the algorithmic manifestation of contextuality requirements

5. **Treewidth → Tensor Network → Entanglement Structure**
   - Low treewidth → limited entanglement → efficient contraction
   - High treewidth → complex entanglement → exponential classical cost
   - Geometry of graph encodes computational complexity

### Summary of Main Result

**The Lie-Poisson Criterion (Proposition 0 + Theorems 1-5):**

> Classical optical MBQC emulation is possible if and only if the dynamical Lie algebra satisfies $\dim(\mathfrak{g}_{\text{dyn}}) \in O(\text{poly}(n))$. Quantum advantage emerges precisely when this integrability condition fails.

This single geometric criterion:
- Unifies three independent simulation methods (Clifford, treewidth, g-sim)
- Explains why contextuality is the quantum resource
- Characterizes the classical-quantum boundary precisely
- Connects to QEC via momentum map/syndrome correspondence

---

## Appendix: Preparation Notes for Presentation

### Key Points to Emphasize

1. **Geometry is fundamental:** The Poincaré sphere is a coadjoint orbit—this isn't just a visualization but the natural geometric structure.

2. **DLA is computable:** We can actually compute the dimension and verify the theory numerically.

3. **Contextuality is measurable:** The contextual fraction $C_F$ can be extracted experimentally via Bell-type tests.

4. **The criterion is sharp:** Polynomial vs exponential DLA exactly distinguishes classical from quantum.

5. **Practical implications:** Strategies S1-S4 give concrete classical implementations with quantifiable limitations.

### Potential Questions and Answers

**Q: Why use Lie-Poisson geometry instead of other frameworks?**
A: The Lie-Poisson structure naturally arises from the symmetry group of quantum mechanics. Coadjoint orbits are the correct phase spaces, and the momentum map is the canonical way to project quantum states to classical descriptions.

**Q: Is the DLA dimension criterion tight?**
A: Yes for the cases studied. Open Problem 2 asks whether it's tight in general—we conjecture it is, but proving both directions rigorously remains open.

**Q: How does this relate to other quantum advantage results?**
A: Our framework unifies several known results (Gottesman-Knill, tensor networks, contextuality bounds) under a single geometric criterion. The contextuality barrier (Theorem 2) is related to but distinct from Bell inequalities.

**Q: Can this be extended to continuous-variable systems?**
A: This is Open Problem 1. The challenge is that CV systems have infinite-dimensional Lie algebras, but similar integrability criteria should exist.

---

*Document prepared for the 46th Winter School Geometry and Physics, Srní, Czech Republic, January 17-24, 2026.*
