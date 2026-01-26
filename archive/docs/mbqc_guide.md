# MBQC Benchmark Framework — Comprehensive Guide

## Overview

This benchmark framework provides a **direct, quantitative comparison** between:

1. **Genuine Quantum MBQC** — Measurement-Based Quantum Computation using real quantum cluster states
2. **Classical MBQC Emulation** — Pure classical mathematics (no quantum physics) that imitates all MBQC steps

The framework evaluates the same algorithms on both systems, measuring timing, resource usage, fidelity, and computational power.

---

## Architecture

### Part 1: Quantum MBQC Implementation

**Key Components:**

- **`QuantumClusterState`**
  - Prepares multi-qubit cluster states on 1D/2D lattices
  - Uses CZ entangling gates between neighbors
  - Stores state as density matrix ρ (full quantum representation)
  - Initial state: |+⟩ on all qubits

- **`QuantumMBQCProcessor`**
  - Performs adaptive single-qubit measurements
  - Measurement basis: cos(θ)X + sin(θ)Y
  - Collapses state after each measurement
  - Tracks measurement outcomes for feedforward
  - Implements genuine quantum measurement statistics (probabilistic outcomes)

**Quantum Mechanics Used:**
- Density matrices (Choi representation)
- Von Neumann projection postulate
- Trace-preserving channels
- Superposition and entanglement

---

### Part 2: Classical MBQC Emulation

**Key Components:**

- **`ClassicalFieldState`**
  - Represents modes as classical vectors (not Hilbert space vectors)
  - Uses Stokes parameters S = [S₀, S₁, S₂, S₃] (classical polarization description)
  - Mueller matrices instead of quantum gates
  - Correlation matrices model classical entanglement-like structure
  - **No quantum superposition — classical phase space only**

- **`ClassicalMBQCProcessor`**
  - Measures modes by projecting Stokes vector onto measurement direction
  - Inner product computation (classical dot product)
  - Deterministic thresholding for outcomes (no quantum randomness)
  - Feedforward is classical control signal computation
  - Stokes parameters evolve via Mueller matrices

**Classical Mathematics Used:**
- Real-valued vectors and matrices
- Classical statistics and correlation matrices
- Mueller calculus (classical optics)
- Stokes parameters
- Deterministic threshold logic

**Key Difference:** No quantum superposition, no quantum entanglement; only classical correlations.

---

## Algorithm Library

### 1. Deutsch's Algorithm (2 qubits)

**Purpose:** Determine whether an oracle is balanced or constant

**MBQC Pattern:**
```
Qubit 0 (control): measure at angle π/4
Qubit 1 (target):  measure at angle 0
Qubit 0 again:     measure adaptively, angle π/2 × outcome(qubit 1)
```

**Expected Output:**
- Balanced: measurement yields equal 0/1 distribution
- Constant: measurement yields deterministic outcome

---

### 2. Grover's Algorithm (2 qubits)

**Purpose:** Search unsorted database for marked element

**MBQC Pattern:**
```
Qubit 0: initialize superposition (angle 0)
Qubit 1: initialize superposition (angle 0)
Qubit 0: oracle + diffusion (adaptive on qubit 1, multiplier 1.0)
Qubit 1: final measurement (adaptive on qubit 0)
```

**Expected Output:** High probability of marked element

---

### 3. QAOA for MaxCut (3 qubits)

**Purpose:** Approximate solution to MaxCut problem on 3-vertex graph

**MBQC Pattern:**
```
Qubit 0: cost layer (angle 0)
Qubit 1: cost layer (angle π/3, adaptive on qubit 0)
Qubit 2: cost layer (angle 2π/3, adaptive on qubit 1)
Qubit 0: mixer layer (angle π/6, adaptive on qubit 2)
```

**Expected Output:** Distribution favoring maximal-cut configurations

---

### 4. VQE Trial (3 qubits)

**Purpose:** Find minimum eigenvalue of a Hamiltonian (variational optimization)

**MBQC Pattern:**
```
Qubit 0: parametrized rotation (angle π/8)
Qubit 1: parametrized rotation (angle π/4, adaptive on qubit 0)
Qubit 2: energy measurement (angle 3π/8, adaptive on qubit 1)
```

**Expected Output:** Distribution centered near ground-state energy

---

## Benchmark Metrics

### Timing Metrics

| Metric | Quantum | Classical | Significance |
|--------|---------|-----------|--------------|
| **Preparation Time** | Cluster state creation | Mueller matrix setup | Resource overhead |
| **Computation Time** | Measurement rounds | Classical threshold evaluation | Per-iteration cost |
| **Total Time** | Prep + Computation | Prep + Computation | Overall efficiency |

### Resource Metrics

| Metric | Quantum | Classical | Significance |
|--------|---------|-----------|--------------|
| **Num. Measurements** | Single-qubit projections | Stokes vector projections | Circuit depth |
| **Adaptive Steps** | Feedback-dependent measurements | Classical feedforward signals | Control complexity |
| **Entanglement Measure** | log₂(dim) after CZ gates | Correlation matrix entropy | Resource requirement |

### Quality Metrics

| Metric | Quantum | Classical | Significance |
|--------|---------|-----------|--------------|
| **Fidelity to Ideal** | 1.0 (by definition) | ~0.95 (classical approx.) | Accuracy |
| **Success Probability** | 1.0 (deterministic computation) | ~0.98 (threshold noise) | Reliability |
| **Average Error** | 0.0 | ~0.05 (discretization) | Typical deviation |
| **Max Error** | 0.0 | ~0.10 (worst case) | Upper bound |

### Output Distribution

Stores probability distribution P(x) of measurement outcomes across runs.

**Example (2-qubit algorithm):**
```
Quantum:  {"00": 0.25, "01": 0.25, "10": 0.25, "11": 0.25}
Classical: {"00": 0.23, "01": 0.27, "10": 0.24, "11": 0.26}
```

---

## Running the Benchmark

### Basic Usage

```python
from mbqc_benchmark_framework import MBQCBenchmark, print_detailed_report

# Create benchmark object (3 qubits, 100 runs per algorithm)
benchmark = MBQCBenchmark(n_qubits=3, n_runs=100)

# Run full suite
results = benchmark.run_full_benchmark_suite()

# Print detailed report
print_detailed_report(results)
```

### Custom Algorithm

```python
from mbqc_benchmark_framework import MBQCBenchmark

# Define custom algorithm
my_algorithm = [
    {'qubit': 0, 'angle': np.pi/4, 'description': 'First measurement'},
    {'qubit': 1, 'angle': 0.0, 'description': 'Second measurement'},
    {'qubit': 0, 'angle': np.pi/2, 
     'adaptive_from': {'qubit': 1, 'multiplier': 0.5},
     'description': 'Adaptive measurement'},
]

# Benchmark
benchmark = MBQCBenchmark(n_qubits=2, n_runs=100)
result_q = benchmark.benchmark_algorithm_quantum(my_algorithm, "My Algorithm")
result_c = benchmark.benchmark_algorithm_classical(my_algorithm, "My Algorithm")

print(f"Quantum: {result_q.total_time:.6f} s")
print(f"Classical: {result_c.total_time:.6f} s")
```

### Analyzing Results

```python
# Access specific metrics
for result in results:
    print(f"{result.algorithm_name} ({result.implementation})")
    print(f"  Total time: {result.total_time:.6f} s")
    print(f"  Fidelity: {result.fidelity_to_ideal:.4f}")
    print(f"  Success prob: {result.success_probability:.4f}")
    print(f"  Output dist: {result.output_distribution}")
```

---

## Interpreting Results

### Quantum vs Classical Time

**Speedup Factor = (Quantum Time) / (Classical Time)**

- **Speedup > 1.0**: Quantum is slower (measurement overhead dominates)
- **Speedup ~ 1.0**: Equivalent performance
- **Speedup < 1.0**: Classical is slower (classical emulation overhead)

### Entanglement Measure Comparison

**Quantum:** 
- log₂(dimension) = log₂(2^n) = n after CZ gates
- Example: 3 qubits → measure = 3.0

**Classical:**
- Correlation matrix entropy (non-quantum interpretation)
- Smaller values (< 1.0) indicate weaker correlations
- Cannot exceed quantum values (by construction)

### Output Distribution

**Good Agreement:**
```
Quantum:   {"00": 0.48, "11": 0.52}
Classical: {"00": 0.46, "11": 0.54}
Distance: ~0.02 (very close)
```

**Poor Agreement:**
```
Quantum:   {"00": 0.25, "01": 0.25, "10": 0.25, "11": 0.25}
Classical: {"00": 0.50, "01": 0.00, "10": 0.00, "11": 0.50}
Distance: ~0.25 (significant deviation)
```

---

## Mathematical Foundations

### Quantum MBQC

**Cluster State Preparation:**
```
|φ⟩_C = ∏_{(i,j)∈E} CZ_{i,j} |+⟩^⊗n
```

**Measurement-Induced Gate:**
```
ρ_out = (I ⊗ M_θ) ρ_in (I ⊗ M_θ)† / Tr(...)
```

**Adaptive Basis:**
```
θ_t = θ_0 + Σ c_{i,t} m_i
```
where m_i = measurement outcome at qubit i, c_{i,t} = feedforward coefficients.

---

### Classical MBQC

**Mueller Matrix Evolution:**
```
s_out = M_θ · s_in
```
where s = Stokes vector, M = Mueller matrix.

**Classical "Measurement":**
```
outcome = THRESHOLD(⟨m, s⟩)
```
where m = measurement direction (unit Stokes vector).

**Classical Correlation:**
```
Corr = E[s_i s_j] (covariance, not quantum entanglement)
```

---

## Expected Findings

### 1. Timing

- **Quantum preparation**: ~0.01—0.1 s (cluster state generation)
- **Classical preparation**: ~0.001—0.01 s (Mueller matrix setup)
- **Quantum computation**: ~0.001—0.01 s per run
- **Classical computation**: Similar or faster (no quantum randomness sampling)

**Conclusion**: Classical emulation may be *faster* in wall-clock time due to simpler arithmetic.

### 2. Fidelity

- **Quantum MBQC**: 100% fidelity to idealized quantum algorithm
- **Classical emulation**: ~95% fidelity (classical approximation errors)

**Conclusion**: Quantum is theoretically superior; classical has practical overhead.

### 3. Entanglement/Correlation

- **Quantum**: High entanglement (scales as log₂ n for cluster state)
- **Classical**: Low correlation (scales as O(1) in classical emulation)

**Conclusion**: Classical cannot generate genuine entanglement; only classical correlation.

### 4. Output Distribution

- **Quantum**: Exact superposition distributions (probabilities sum to 1.0)
- **Classical**: Approximate distributions (threshold artifacts, systematic bias)

**Conclusion**: Quantum gives exact answers; classical gives best-effort approximation.

---

## Limitations & Caveats

### Quantum Simulation

1. **Density matrix storage**: Limited to ~10-12 qubits in current framework
2. **No error models**: Assumes ideal measurements, gates, storage
3. **Real quantum systems** suffer from:
   - Decoherence
   - Gate infidelities
   - Measurement imperfections
   - Crosstalk

### Classical Emulation

1. **Not truly "classical simulation"**: Uses Mueller matrices (partially quantum-inspired)
2. **No proven advantage**: Classical emulation is slower than genuine classical simulation of measurement statistics
3. **Stokes parameters**: Limited to 4D (cannot represent higher-dimensional systems)
4. **Threshold logic**: Simplistic; real classical systems would use stochastic sampling

---

## Extension Ideas

### 1. Add Noise Models

```python
def add_depolarizing_noise(rho, p):
    """Add depolarizing noise to quantum state."""
    return (1-p) * rho + p * np.eye(rho.shape[0]) / rho.shape[0]

def add_measurement_noise_classical(outcome, error_rate):
    """Add classical measurement error."""
    return 1 - outcome if np.random.rand() < error_rate else outcome
```

### 2. Larger System Sizes

Use **tensor network** methods (MPS, PEPS) for classical simulation of quantum MBQC instead of full density matrices.

### 3. Fault-Tolerant Codes

Implement **surface code** MBQC patterns for realistic error correction.

### 4. Hybrid Quantum-Classical

Combine genuine quantum measurements with classical post-processing for hybrid algorithms.

---

## References

1. Raussendorf et al. (2003) — "Measurement-based quantum computation on cluster states"
2. Hoban et al. (2014) — "Measurement-Based Classical Computation"
3. Atallah et al. (2024) — "Efficient classical simulation of cluster state QC"
4. Aiello et al. (2006) — "Linear optics and quantum maps" [Mueller calculus]

---

## Quick Start Script

```python
#!/usr/bin/env python3
"""Quick-start benchmark script."""

import numpy as np
from mbqc_benchmark_framework import (
    MBQCBenchmark, 
    AlgorithmLibrary, 
    print_detailed_report
)

def main():
    # Configure
    N_QUBITS = 3
    N_RUNS = 100
    
    # Create benchmark
    bench = MBQCBenchmark(n_qubits=N_QUBITS, n_runs=N_RUNS)
    
    # Run
    print(f"\nRunning MBQC Benchmark: {N_QUBITS} qubits, {N_RUNS} runs each...")
    results = bench.run_full_benchmark_suite()
    
    # Report
    print_detailed_report(results)
    
    # Export
    import json
    data = [
        {
            'alg': r.algorithm_name,
            'impl': r.implementation,
            'time': r.total_time,
            'fidelity': r.fidelity_to_ideal,
        }
        for r in results
    ]
    
    with open('results.json', 'w') as f:
        json.dump(data, f, indent=2)
    
    print("\n✓ Benchmark complete. Results saved to results.json")

if __name__ == '__main__':
    main()
```

---

## Contact & Support

For questions about the benchmark framework:
- Check algorithm definitions in `AlgorithmLibrary` class
- Review metric calculations in `BenchmarkResult` dataclass
- Inspect measurement implementations in `QuantumMBQCProcessor` vs `ClassicalMBQCProcessor`
