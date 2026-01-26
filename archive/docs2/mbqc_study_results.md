# MBQC Extended Study: Classical vs Quantum Simulation Results

## Executive Summary

This study extends the Lie-Poisson framework analysis to identify precisely where classical light beam simulation fails to reproduce quantum MBQC computations.

**Key Finding**: Classical simulation fundamentally fails whenever:
1. **Entanglement** is required (Bell, GHZ, cluster states)
2. **Non-Clifford operations** are used (T gate, π/8 rotations)
3. **Quantum interference** is essential (Grover, amplitude amplification)
4. **Coherent superposition** must be preserved (teleportation)

---

## 1. Scaling Analysis Results

### GHZ State Correlations (2-8 qubits)

| Qubits | Quantum P(00...0 + 11...1) | Classical P | Gap | Relative Error |
|--------|---------------------------|-------------|-----|----------------|
| 2 | 1.0000 | 0.5000 | 0.50 | 50.0% |
| 3 | 1.0000 | 0.2500 | 0.75 | 75.0% |
| 4 | 1.0000 | 0.1250 | 0.88 | 87.5% |
| 5 | 1.0000 | 0.0625 | 0.94 | 93.8% |
| 6 | 1.0000 | 0.0312 | 0.97 | 96.9% |
| 7 | 1.0000 | 0.0156 | 0.98 | 98.4% |
| 8 | 1.0000 | 0.0078 | 0.99 | 99.2% |

**Conclusion**: Classical success decays as 1/2^(n-1) → 0. Gap approaches 100% as qubit count increases.

---

## 2. Algorithm-Specific Results

### Deutsch-Jozsa Algorithm

| Configuration | Qiskit Success | Classical Success | Gap | Tier |
|--------------|----------------|-------------------|-----|------|
| n=2, constant | 1.0 | 1.0 | 0.0 | Tier 1 |
| n=2, balanced | 1.0 | 0.0 | 1.0 | Quantum-Essential |
| n=4, constant | 1.0 | 1.0 | 0.0 | Tier 1 |
| n=4, balanced | 1.0 | 0.0 | 1.0 | Quantum-Essential |

**Query Complexity**:
- Quantum: 1 query for any n
- Classical: 2^(n-1) + 1 queries

### Grover's Search Algorithm

| Database Size | Quantum Queries | Classical Queries | Speedup |
|--------------|-----------------|-------------------|---------|
| N=4 | 1 | 2 | 2.0x |
| N=16 | 3 | 8 | 2.7x |
| N=64 | 6 | 32 | 5.3x |
| N=256 | 12 | 128 | 10.7x |
| N=1024 | 25 | 512 | 20.5x |
| N=4096 | 50 | 2048 | 41.0x |

**Speedup**: O(√N) quantum vs O(N) classical

---

## 3. Bell/CHSH Inequality Tests

### CHSH Values
- **Classical bound**: S ≤ 2
- **Quantum result**: S = 2√2 ≈ 2.83
- **Gap**: 0.83 (29% violation of classical bound)

### Entanglement Witness
| State | ⟨W⟩ | Status |
|-------|-----|--------|
| Bell |Φ+⟩ | -0.5000 | ✓ ENTANGLED |
| Product |00⟩ | +0.0000 | Separable |
| Maximally mixed | +0.2500 | Separable |

**Conclusion**: Classical optics produces ONLY separable states.

---

## 4. Boundary Identification

### Angle Boundaries
| Angle Type | Range | Classical Simulation |
|------------|-------|---------------------|
| Clifford | 0, π/2, π, 3π/2 | EXACT match |
| Near-Clifford | ±0.01 rad | Approximate match |
| Transition | ±0.1 rad | Increasing error |
| Magic (π/8) | Maximum deviation | FAILS |

### Qubit Boundaries
| Qubits | Classical Error | Status |
|--------|-----------------|--------|
| 2-3 | ~50-75% | Significant gap |
| 4-6 | ~87-97% | Large gap |
| 7+ | >98% | Complete failure |

---

## 5. Fundamental Limitations

### Why Classical Light Beams Fail

1. **No Entanglement**
   - Stokes vectors describe individual beams (separable)
   - Mueller matrices are local operations
   - Cannot create non-classical correlations

2. **Positive Probabilities Only**
   - Classical intensities I ≥ 0
   - No destructive interference
   - Cannot do amplitude amplification

3. **No Contextuality**
   - Classical measurements are non-contextual
   - Cannot violate Bell inequalities
   - Nobel Prize 2022 confirmed this experimentally

4. **Local Realism**
   - Classical physics satisfies local hidden variable models
   - Quantum mechanics violates Bell-CHSH bounds

---

## 6. Lie-Poisson Framework Verification

| Tier | Description | Classical Simulation | Verified |
|------|-------------|---------------------|----------|
| Tier 1 | Clifford gates only | EXACT | ✓ |
| Tier 2 | Low T-count, weak entanglement | Polynomial overhead | ✓ |
| Quantum-Essential | High entanglement, magic angles | IMPOSSIBLE | ✓ |

---

## 7. Files Created

| File | Purpose |
|------|---------|
| `mbqc_classical_quantum_comparison.py` | Basic Q vs C comparison |
| `mbqc_extended_study.py` | Extended boundary analysis |
| `mbqc_final_qiskit_study.py` | Qiskit ground truth comparison |
| `mbqc_detailed_failure_analysis.py` | Complete failure analysis |
| `mbqc_study_results.md` | This summary document |

---

## Conclusion

**Classical light beam simulation CANNOT replace quantum computers for:**
- Any algorithm requiring entanglement
- Non-Clifford gate operations (T gates)
- Amplitude amplification (Grover)
- Coherent state teleportation
- Multi-qubit correlations (GHZ, cluster states)

**The Lie-Poisson framework correctly identifies the boundary between classically simulable and quantum-essential operations.**

---

*Study completed: January 2026*
*Framework: Lie-Poisson MBQC Classification*
*Tools: Qiskit, NumPy, Custom MBQC Simulator*
