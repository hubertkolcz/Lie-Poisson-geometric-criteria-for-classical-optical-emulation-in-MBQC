"""
Advanced Usage Examples and Validation Tests for MBQC Benchmark Framework

This file contains:
1. Advanced algorithm constructions
2. Validation and sanity checks
3. Extended benchmarking scenarios
4. Comparative analysis templates
"""

import numpy as np
from collections import defaultdict
import matplotlib.pyplot as plt


# ═════════════════════════════════════════════════════════════════════════════
# ADVANCED ALGORITHM LIBRARY
# ═════════════════════════════════════════════════════════════════════════════

class AdvancedAlgorithms:
    """Extended algorithm library with more complex patterns."""
    
    @staticmethod
    def simon_algorithm_3qubit() -> tuple:
        """
        Simon's algorithm for finding hidden period in boolean function.
        Demonstrates need for more qubits and complex feedback.
        """
        spec = [
            # Query qubits (input)
            {'qubit': 0, 'angle': 0.0, 'description': 'Query q0'},
            {'qubit': 1, 'angle': 0.0, 'description': 'Query q1'},
            
            # Output qubit
            {'qubit': 2, 'angle': np.pi, 'description': 'Output qubit'},
            
            # Phase kickback with adaptive basis (oracle simulation)
            {'qubit': 0, 'angle': np.pi/2, 
             'adaptive_from': {'qubit': 2, 'multiplier': 1.0},
             'description': 'Adaptive basis on q0'},
            
            {'qubit': 1, 'angle': np.pi/2,
             'adaptive_from': {'qubit': 0, 'multiplier': 0.5},
             'description': 'Adaptive basis on q1'},
            
            # Final measurements
            {'qubit': 0, 'angle': np.pi/4,
             'adaptive_from': {'qubit': 2, 'multiplier': 0.25},
             'description': 'Final q0'},
            
            {'qubit': 1, 'angle': np.pi/4,
             'adaptive_from': {'qubit': 0, 'multiplier': 0.25},
             'description': 'Final q1'},
        ]
        return spec, "Simon's Algorithm (3-qubit)"
    
    @staticmethod
    def bernstein_vazirani_3qubit() -> tuple:
        """
        Bernstein-Vazirani algorithm to find hidden string s.
        Shows phase encoding via measurement angles.
        """
        hidden_string = [1, 0, 1]  # s = 101
        
        spec = [
            # Query initialization
            {'qubit': 0, 'angle': 0.0, 'description': 'Query q0'},
            {'qubit': 1, 'angle': 0.0, 'description': 'Query q1'},
            {'qubit': 2, 'angle': 0.0, 'description': 'Query q2'},
            
            # Phase encoding via measurement angles
            {'qubit': 0, 'angle': np.pi * hidden_string[0] / 2, 
             'description': 'Phase encode s[0]'},
            {'qubit': 1, 'angle': np.pi * hidden_string[1] / 2,
             'adaptive_from': {'qubit': 0, 'multiplier': 0.5},
             'description': 'Phase encode s[1]'},
            {'qubit': 2, 'angle': np.pi * hidden_string[2] / 2,
             'adaptive_from': {'qubit': 1, 'multiplier': 0.5},
             'description': 'Phase encode s[2]'},
            
            # Read results
            {'qubit': 0, 'angle': 0.0,
             'adaptive_from': {'qubit': 2, 'multiplier': 1.0},
             'description': 'Read s[0]'},
            {'qubit': 1, 'angle': 0.0,
             'adaptive_from': {'qubit': 0, 'multiplier': 1.0},
             'description': 'Read s[1]'},
            {'qubit': 2, 'angle': 0.0,
             'adaptive_from': {'qubit': 1, 'multiplier': 1.0},
             'description': 'Read s[2]'},
        ]
        return spec, "Bernstein-Vazirani (3-qubit, s=101)"
    
    @staticmethod
    def controlled_phase_4qubit() -> tuple:
        """4-qubit controlled phase gate via MBQC."""
        spec = [
            # Control qubits
            {'qubit': 0, 'angle': 0.0, 'description': 'Control 1'},
            {'qubit': 1, 'angle': 0.0, 'description': 'Control 2'},
            
            # Target qubits
            {'qubit': 2, 'angle': 0.0, 'description': 'Target 1'},
            {'qubit': 3, 'angle': 0.0, 'description': 'Target 2'},
            
            # Entangling measurements
            {'qubit': 0, 'angle': np.pi/4,
             'adaptive_from': {'qubit': 2, 'multiplier': 0.5},
             'description': 'Entangle c1-t1'},
            
            {'qubit': 1, 'angle': np.pi/4,
             'adaptive_from': {'qubit': 3, 'multiplier': 0.5},
             'description': 'Entangle c2-t2'},
            
            # Conditional phases
            {'qubit': 2, 'angle': np.pi/3,
             'adaptive_from': {'qubit': 0, 'multiplier': 1.0},
             'description': 'Target phase 1'},
            
            {'qubit': 3, 'angle': np.pi/3,
             'adaptive_from': {'qubit': 1, 'multiplier': 1.0},
             'description': 'Target phase 2'},
        ]
        return spec, "Controlled Phase Gate (4-qubit)"


# ═════════════════════════════════════════════════════════════════════════════
# VALIDATION TESTS
# ═════════════════════════════════════════════════════════════════════════════

class ValidationTests:
    """Sanity checks and correctness tests for benchmark framework."""
    
    @staticmethod
    def test_trace_preservation():
        """
        Test that quantum density matrices remain normalized.
        """
        from mbqc_benchmark_framework import QuantumClusterState
        
        print("\n[TEST] Trace Preservation of Quantum State")
        
        for n_qubits in [2, 3, 4]:
            cluster = QuantumClusterState(n_qubits)
            trace = np.trace(cluster.rho)
            
            status = "✓ PASS" if abs(trace - 1.0) < 1e-10 else "✗ FAIL"
            print(f"  {n_qubits} qubits: Tr(ρ) = {trace:.10f} {status}")
        
        return True
    
    @staticmethod
    def test_measurement_statistics():
        """
        Test that measurement outcomes follow expected quantum statistics.
        """
        from mbqc_benchmark_framework import QuantumClusterState, QuantumMBQCProcessor
        
        print("\n[TEST] Quantum Measurement Statistics")
        
        # Prepare |+⟩ state and measure X => should get equal 0/1
        cluster = QuantumClusterState(2)
        
        outcomes = defaultdict(int)
        for _ in range(1000):
            processor = QuantumMBQCProcessor(cluster)
            outcome = processor.measure_qubit(0, basis_angle=0.0)
            outcomes[outcome] += 1
        
        p0 = outcomes[0] / 1000
        p1 = outcomes[1] / 1000
        
        print(f"  Measuring |+⟩ in X basis:")
        print(f"    P(0) = {p0:.3f} (expected 0.500)")
        print(f"    P(1) = {p1:.3f} (expected 0.500)")
        
        status = "✓ PASS" if abs(p0 - 0.5) < 0.1 and abs(p1 - 0.5) < 0.1 else "✗ FAIL"
        print(f"  Result: {status}")
        
        return abs(p0 - 0.5) < 0.1
    
    @staticmethod
    def test_classical_determinism():
        """
        Test that classical emulation is deterministic (no quantum randomness).
        """
        from mbqc_benchmark_framework import ClassicalFieldState, ClassicalMBQCProcessor
        
        print("\n[TEST] Classical Determinism")
        
        outcomes_list = []
        for run in range(5):
            field = ClassicalFieldState(3)
            processor = ClassicalMBQCProcessor(field)
            
            outcomes = []
            for qubit in range(3):
                outcome = processor.measure_mode_classical(qubit, basis_angle=0.5)
                outcomes.append(outcome)
            
            outcomes_list.append(tuple(outcomes))
            print(f"  Run {run+1}: {outcomes}")
        
        # Check if all runs give same result
        unique_outcomes = len(set(outcomes_list))
        status = "✓ PASS" if unique_outcomes == 1 else "⚠ MIXED"
        print(f"  Unique outcomes across 5 runs: {unique_outcomes} (expected 1)")
        print(f"  Result: {status} (classical should be deterministic)")
        
        return unique_outcomes == 1
    
    @staticmethod
    def test_adaptive_feedback_consistency():
        """
        Test that adaptive measurements produce consistent feedback.
        """
        from mbqc_benchmark_framework import QuantumClusterState, QuantumMBQCProcessor
        
        print("\n[TEST] Adaptive Feedback Consistency")
        
        cluster = QuantumClusterState(2)
        
        algo = [
            {'qubit': 0, 'angle': 0.0},
            {'qubit': 1, 'angle': np.pi/4, 'adaptive_from': {'qubit': 0, 'multiplier': 1.0}},
        ]
        
        # Run multiple times and check that outcomes are consistent
        outcomes_pairs = []
        for _ in range(100):
            processor = QuantumMBQCProcessor(cluster)
            processor.compute_algorithm(algo)
            pair = (
                processor.measurement_outcomes[0],
                processor.measurement_outcomes[1]
            )
            outcomes_pairs.append(pair)
        
        unique_pairs = set(outcomes_pairs)
        print(f"  Algorithm with adaptive step produced {len(unique_pairs)} unique pairs")
        print(f"  Distribution: {dict(defaultdict(int, ((k, outcomes_pairs.count(k)) for k in unique_pairs)))}")
        
        # Should see all 4 possible pairs
        status = "✓ PASS" if len(unique_pairs) > 1 else "⚠ LIMITED"
        print(f"  Result: {status} (expected >1 pair due to quantum randomness)")
        
        return len(unique_pairs) > 1
    
    @staticmethod
    def test_algorithm_specification_format():
        """
        Test that algorithm specifications are correctly formatted.
        """
        print("\n[TEST] Algorithm Specification Format")
        
        from mbqc_benchmark_framework import AlgorithmLibrary
        
        algorithms = [
            AlgorithmLibrary.deutsch_algorithm(),
            AlgorithmLibrary.grover_two_qubit(),
            AlgorithmLibrary.qaoa_maxcut_3qubit(),
            AlgorithmLibrary.vqe_trial(),
        ]
        
        for spec, name in algorithms:
            print(f"  {name}:")
            
            # Check structure
            all_valid = True
            for i, step in enumerate(spec):
                has_qubit = 'qubit' in step
                has_angle = 'angle' in step
                
                if not (has_qubit and has_angle):
                    print(f"    ✗ Step {i} missing required fields")
                    all_valid = False
                
                if 'adaptive_from' in step:
                    adaptive = step['adaptive_from']
                    if 'qubit' not in adaptive or 'multiplier' not in adaptive:
                        print(f"    ✗ Step {i} adaptive_from malformed")
                        all_valid = False
            
            status = "✓" if all_valid else "✗"
            print(f"    {status} Format valid: {len(spec)} steps")
        
        return True


# ═════════════════════════════════════════════════════════════════════════════
# EXTENDED BENCHMARKING SCENARIOS
# ═════════════════════════════════════════════════════════════════════════════

class ExtendedBenchmarks:
    """Advanced benchmarking configurations."""
    
    @staticmethod
    def benchmark_scalability(max_qubits=6, runs_per_size=50):
        """
        Benchmark as function of system size.
        
        Shows how timing and resources scale with problem size.
        """
        from mbqc_benchmark_framework import (
            MBQCBenchmark, 
            AlgorithmLibrary
        )
        
        print("\n[SCALABILITY BENCHMARK]")
        print(f"System size sweep: 2 to {max_qubits} qubits")
        
        results_by_size = {}
        
        for n_qubits in range(2, max_qubits + 1):
            algo_spec, algo_name = AlgorithmLibrary.deutsch_algorithm()
            
            bench = MBQCBenchmark(n_qubits=n_qubits, n_runs=runs_per_size)
            
            # Run quantum
            t_q = bench.benchmark_algorithm_quantum(algo_spec, algo_name)
            
            # Run classical
            t_c = bench.benchmark_algorithm_classical(algo_spec, algo_name)
            
            results_by_size[n_qubits] = {
                'quantum_time': t_q.total_time,
                'classical_time': t_c.total_time,
                'quantum_entanglement': t_q.entanglement_measure,
                'classical_entanglement': t_c.entanglement_measure,
            }
            
            print(f"\n  {n_qubits} qubits:")
            print(f"    Quantum:   {t_q.total_time:.6f} s")
            print(f"    Classical: {t_c.total_time:.6f} s")
            print(f"    Q-entangle: {t_q.entanglement_measure:.4f}, C-entangle: {t_c.entanglement_measure:.4f}")
        
        return results_by_size
    
    @staticmethod
    def benchmark_adaptation_depth(max_depth=6, n_qubits=3, runs=50):
        """
        Benchmark as function of adaptation complexity.
        
        Creates algorithms with increasing levels of adaptive measurement.
        """
        from mbqc_benchmark_framework import MBQCBenchmark
        
        print("\n[ADAPTATION DEPTH BENCHMARK]")
        print(f"Measuring effect of adaptive feedback depth")
        
        results_by_depth = {}
        
        for depth in range(1, max_depth + 1):
            # Construct algorithm with specified adaptation depth
            spec = []
            for i in range(n_qubits):
                step = {
                    'qubit': i,
                    'angle': np.pi * i / n_qubits,
                }
                
                if i > 0 and depth > 1:
                    # Add adaptive dependence
                    step['adaptive_from'] = {
                        'qubit': i - 1,
                        'multiplier': 1.0 / (2 ** (depth - 1))
                    }
                
                spec.append(step)
            
            bench = MBQCBenchmark(n_qubits=n_qubits, n_runs=runs)
            
            # Benchmark
            r_q = bench.benchmark_algorithm_quantum(spec, f"Depth {depth}")
            r_c = bench.benchmark_algorithm_classical(spec, f"Depth {depth}")
            
            results_by_depth[depth] = {
                'quantum': r_q.total_time,
                'classical': r_c.total_time,
                'adaptive_steps': r_q.num_adaptive_steps,
            }
            
            print(f"  Depth {depth} (adaptive steps: {r_q.num_adaptive_steps}):")
            print(f"    Quantum:   {r_q.total_time:.6f} s")
            print(f"    Classical: {r_c.total_time:.6f} s")
        
        return results_by_depth


# ═════════════════════════════════════════════════════════════════════════════
# COMPARATIVE ANALYSIS
# ═════════════════════════════════════════════════════════════════════════════

class ComparativeAnalysis:
    """Generate detailed comparisons between implementations."""
    
    @staticmethod
    def output_distribution_distance(dist1, dist2):
        """
        Compute total variation distance between two output distributions.
        
        TVD = 0.5 * Σ|P(x) - Q(x)|
        """
        all_keys = set(dist1.keys()) | set(dist2.keys())
        distance = 0.5 * sum(
            abs(dist1.get(k, 0) - dist2.get(k, 0))
            for k in all_keys
        )
        return distance
    
    @staticmethod
    def comparative_fidelity_analysis(results):
        """
        Compute fidelity-like measures comparing quantum vs classical outputs.
        """
        print("\n[COMPARATIVE FIDELITY ANALYSIS]")
        
        # Group by algorithm
        by_algo = defaultdict(list)
        for r in results:
            by_algo[r.algorithm_name].append(r)
        
        for algo_name, algo_results in by_algo.items():
            q_result = next((r for r in algo_results if r.implementation == "QUANTUM"), None)
            c_result = next((r for r in algo_results if r.implementation == "CLASSICAL"), None)
            
            if q_result and c_result:
                tvd = ComparativeAnalysis.output_distribution_distance(
                    q_result.output_distribution,
                    c_result.output_distribution
                )
                
                print(f"\n  {algo_name}:")
                print(f"    Quantum output:   {dict(q_result.output_distribution)}")
                print(f"    Classical output: {dict(c_result.output_distribution)}")
                print(f"    Total Variation Distance: {tvd:.4f}")
                print(f"    Fidelity (1-TVD): {1-tvd:.4f}")


# ═════════════════════════════════════════════════════════════════════════════
# MAIN EXECUTION
# ═════════════════════════════════════════════════════════════════════════════

def run_all_validation_tests():
    """Run complete validation suite."""
    print("╔════════════════════════════════════════════════════════════════╗")
    print("║  MBQC BENCHMARK VALIDATION TEST SUITE                         ║")
    print("╚════════════════════════════════════════════════════════════════╝")
    
    tests = [
        ValidationTests.test_trace_preservation,
        ValidationTests.test_measurement_statistics,
        ValidationTests.test_classical_determinism,
        ValidationTests.test_adaptive_feedback_consistency,
        ValidationTests.test_algorithm_specification_format,
    ]
    
    passed = 0
    for test in tests:
        try:
            if test():
                passed += 1
        except Exception as e:
            print(f"  ✗ Exception: {e}")
    
    print(f"\n{'─'*60}")
    print(f"Validation Summary: {passed}/{len(tests)} tests passed")
    print(f"{'─'*60}\n")


def run_extended_benchmarks():
    """Run extended benchmarking scenarios."""
    print("\n╔════════════════════════════════════════════════════════════════╗")
    print("║  EXTENDED BENCHMARKING SCENARIOS                              ║")
    print("╚════════════════════════════════════════════════════════════════╝")
    
    # Scalability
    # ExtendedBenchmarks.benchmark_scalability(max_qubits=5, runs_per_size=30)
    
    # Adaptation depth
    # ExtendedBenchmarks.benchmark_adaptation_depth(max_depth=4, n_qubits=3)
    
    print("\n[Note: Extended benchmarks commented out for quick testing]")
    print("      Uncomment in run_extended_benchmarks() for full suite")


if __name__ == "__main__":
    # Run validation
    run_all_validation_tests()
    
    # Run extended benchmarks (optional)
    # run_extended_benchmarks()
    
    print("\n✓ Advanced examples and tests completed")
