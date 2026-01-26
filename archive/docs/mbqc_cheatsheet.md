# MBQC Benchmark Framework — Quick Reference & Cheat Sheet

## 🚀 One-Minute Start

```python
from mbqc_benchmark_framework import MBQCBenchmark

# Run everything
bench = MBQCBenchmark(n_qubits=3, n_runs=100)
results = bench.run_full_benchmark_suite()
```

Output: Deutsch, Grover, QAOA, VQE benchmarks on quantum + classical.

---

## 📊 Key Metrics at a Glance

| Metric | Quantum | Classical | Why It Matters |
|--------|---------|-----------|----------------|
| **Time** | ~0.01 s | ~0.001 s | Quantum slower for small systems |
| **Fidelity** | 1.0 | 0.95 | Classical approximates well (small n) |
| **Entanglement** | 2.0 (2-qubit) | 0.34 | Quantum has real entanglement |
| **Speedup** | — | 10—50x | Classical faster (paradox!) |

---

## 🧮 Algorithm Patterns

### Deutsch (Controlled oracle)
```python
# Qubit 0: control
# Qubit 1: target  
# Measurement: adaptive on target outcome
```

### Grover (Quantum search)
```python
# Qubits 0,1: superposition
# Measure with oracle-like angle
# Adaptive on previous qubits
```

### QAOA (Optimization)
```python
# Qubits 0,1,2: cost angles
# Angles encode problem structure
# Measurements adaptive on coupled qubits
```

### VQE (Energy estimation)
```python
# Qubits 0,1,2: parametrized rotations
# Different angles for each qubit
# Final measurement gives energy proxy
```

---

## 📝 Algorithm Specification Format

```python
algorithm_spec = [
    {
        'qubit': 0,              # Which qubit to measure
        'angle': np.pi/4,        # Measurement basis angle
        'adaptive_from': {       # OPTIONAL: make adaptive
            'qubit': 1,          # Reference qubit outcome
            'multiplier': 0.5    # Angle coefficient
        }
    },
    # ... more measurements
]
```

---

## 🔬 What's Really Happening

### Quantum Side
```
|+⟩ ──CZ──CZ──CZ─ [cluster state]
      ↓   ↓   ↓
    ┌─ M(θ) ─ M(θ') ─ M(θ'') ─┐
    │  [adaptive feedback]      │
    └────────────────────────────┘
    [Output: bitstring 0/1 seq]
```

### Classical Side
```
S = [1,1,0,0] ──M_θ──M_θ'──M_θ'' ──  [Stokes vectors]
     [Mueller    [Threshold logic]
      matrices]  [No quantum]
    [Output: bitstring 0/1 seq]
```

---

## 🎯 Results Interpretation Quick Guide

### ✓ What to expect:

| Finding | Explanation |
|---------|-------------|
| Q > C timing | Quantum overhead (prep, sampling) |
| Q ≈ C output | Classical emulation works (small n) |
| Q >> C entangle | Quantum has non-local correlations |
| TVD < 0.1 | Good classical approximation |

### ✗ Red flags:

| Issue | Fix |
|-------|-----|
| TVD > 0.3 | Classical model breaking down |
| Entangle < 0.1 | System too simple |
| Prep time >> Comp time | Inefficient state generation |

---

## 💻 Common Usage Patterns

### Custom Algorithm
```python
from mbqc_benchmark_framework import MBQCBenchmark, AlgorithmLibrary

# Define
my_algo = [
    {'qubit': 0, 'angle': 0.0},
    {'qubit': 1, 'angle': np.pi/4, 'adaptive_from': {'qubit': 0, 'multiplier': 1.0}}
]

# Benchmark
bench = MBQCBenchmark(n_qubits=2, n_runs=50)
result_q = bench.benchmark_algorithm_quantum(my_algo, "My Algorithm")
result_c = bench.benchmark_algorithm_classical(my_algo, "My Algorithm")

# Compare
print(f"Quantum: {result_q.total_time:.6f}s")
print(f"Classical: {result_c.total_time:.6f}s")
print(f"Fidelity: {result_q.fidelity_to_ideal:.4f}")
```

### Parameter Sweep
```python
for n_qubits in [2, 3, 4, 5]:
    bench = MBQCBenchmark(n_qubits=n_qubits, n_runs=100)
    r_q = bench.benchmark_algorithm_quantum(algo_spec, algo_name)
    print(f"{n_qubits} qubits: {r_q.total_time:.6f}s, fidelity={r_q.fidelity_to_ideal:.4f}")
```

### Result Extraction
```python
for result in results:
    print(f"  Algorithm: {result.algorithm_name}")
    print(f"  Implementation: {result.implementation}")
    print(f"  Total time: {result.total_time:.6f}s")
    print(f"  Fidelity: {result.fidelity_to_ideal:.4f}")
    print(f"  Output: {dict(result.output_distribution)}")
```

---

## 🔍 Debugging Common Issues

### Issue: "Quantum results all same"
**Cause:** Deterministic algorithm (no quantum randomness)
**Fix:** Add angle diversity or stochastic element

### Issue: "Classical gives all 0s"
**Cause:** Threshold always true/false
**Fix:** Adjust Stokes parameter initialization

### Issue: "TVD very large"
**Cause:** Classical approximation breaking
**Fix:** Reduce system size or simplify algorithm

### Issue: "Quantum slower than expected"
**Cause:** State prep overhead dominates small n
**Fix:** Benchmark on larger systems (n > 6)

---

## 📐 Mathematical Cheat Sheet

### Quantum
```
|ψ⟩ = (|0⟩ + |1⟩)/√2  [superposition]
ρ = |ψ⟩⟨ψ|            [density matrix]
M₀ = |0⟩⟨0|           [measurement projector]
p₀ = Tr(M₀ ρ)         [outcome probability]
```

### Classical
```
S = [S₀, S₁, S₂, S₃]  [Stokes vector]
M = Mueller matrix     [classical gate]
S' = M·S              [evolution]
outcome = (S·m > 0.5) [threshold]
```

---

## 📦 File Structure

```
mbqc_benchmark_framework.py
├── QuantumGates          [X, Y, Z, H, CNOT, CZ]
├── QuantumClusterState   [Prepare |+⟩, apply CZ]
├── QuantumMBQCProcessor  [Measure, collapse, adapt]
├── ClassicalFieldState   [Stokes vectors, Mueller]
├── ClassicalMBQCProcessor [Threshold, feedback]
├── AlgorithmLibrary      [4 algorithms]
├── MBQCBenchmark         [Orchestrator]
└── BenchmarkResult       [Metrics storage]

mbqc_guide.md
├── Architecture
├── Algorithms explained
├── Metrics explained
├── Running guide
└── References

mbqc_examples_tests.py
├── AdvancedAlgorithms    [Simon, BV, 4-qubit CPhase]
├── ValidationTests       [5 sanity checks]
└── ExtendedBenchmarks    [Scalability, adaptation]
```

---

## ⚡ Performance Tips

### Faster Quantum Simulation
```python
# Use sparse matrices for large n
from scipy.sparse import csr_matrix

# Or use approximate methods:
# - Matrix Product States (quimb)
# - Stabilizer formalism (stim)
```

### Faster Classical Emulation
```python
# Use NumPy operations (already optimized)
# Vectorize Mueller matrix multiplications
# Batch multiple runs
```

### Parallel Benchmarking
```python
from multiprocessing import Pool

def benchmark_algo(algo_spec):
    bench = MBQCBenchmark(n_qubits=3, n_runs=50)
    return bench.benchmark_algorithm_quantum(algo_spec, "Algo")

with Pool(4) as p:
    results = p.map(benchmark_algo, algorithm_list)
```

---

## 🎓 Learning Path

1. **Start:** Run `python3 mbqc_benchmark_framework.py`
2. **Understand:** Read `mbqc_guide.md` (20 min)
3. **Extend:** Add custom algorithm to `AlgorithmLibrary`
4. **Validate:** Run `python3 mbqc_examples_tests.py`
5. **Analyze:** Extract metrics from results

---

## 📊 Result Export

### JSON Format
```json
{
  "algorithm": "Deutsch (2-qubit)",
  "implementation": "QUANTUM",
  "total_time": 0.006912,
  "fidelity": 1.0,
  "output_distribution": {
    "00": 0.45,
    "11": 0.55
  }
}
```

### Pandas DataFrame
```python
import pandas as pd

df = pd.DataFrame([
    {
        'algo': r.algorithm_name,
        'impl': r.implementation,
        'time': r.total_time,
        'fidelity': r.fidelity_to_ideal,
    }
    for r in results
])
```

---

## 🔗 Quick Links

**In code:**
- `AlgorithmLibrary.deutsch_algorithm()` — Deutsch's algorithm
- `MBQCBenchmark.run_full_benchmark_suite()` — Run all 4 algorithms
- `QuantumClusterState(3)` — 3-qubit cluster state
- `ClassicalFieldState(3)` — 3-mode classical field

**In guide:**
- See "Algorithm Definitions" for pattern details
- See "Interpreting Results" for metric explanation
- See "Extension Ideas" for customization

---

## 🚨 Important Caveats

1. **Density matrix limitation:** max ~10 qubits (2^10 = 1024 states)
2. **No error models:** assumes ideal measurements
3. **Classical not truly classical:** uses Mueller matrices (quantum-inspired)
4. **Small systems:** classical faster (paradox of small benchmarks!)
5. **No noise:** real systems have decoherence

---

## 💡 Pro Tips

- **Tip 1:** Use `n_runs=100` for statistics, `n_runs=10` for debugging
- **Tip 2:** Compare `entanglement_measure` to see fundamental difference
- **Tip 3:** Plot time vs n_qubits to see scaling
- **Tip 4:** Check output distributions first before analyzing timing
- **Tip 5:** Run validation tests to verify your environment works

---

## 🎯 One-Liner Examples

```python
# Quick quantum
from mbqc_benchmark_framework import QuantumClusterState; cs = QuantumClusterState(3); print(f"Entanglement: {np.log2(cs.rho.shape[0])}")

# Quick classical
from mbqc_benchmark_framework import ClassicalFieldState; fs = ClassicalFieldState(3); print(f"Correlation: {fs.get_classical_entanglement_measure()}")

# Run one algorithm
bench = MBQCBenchmark(3, 50); r = bench.benchmark_algorithm_quantum([{'qubit': 0, 'angle': 0}], "Test"); print(r.total_time)
```

---

**Ready to benchmark? Type:** `python3 mbqc_benchmark_framework.py` 🚀
