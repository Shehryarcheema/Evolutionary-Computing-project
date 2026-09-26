# Population-Based Metaheuristics: PSO vs. Differential Evolution

A comparative study of two population-based optimisation algorithms —
**Particle Swarm Optimisation (PSO)** and **Differential Evolution (DE)** —
on an unconstrained and a constrained benchmark problem, with median-based
convergence analysis and a PSO parameter study.

Companion code for the MSc coursework report *"Evolutionary Computing"*
(P2952028 — SHEHRYAR) — De Montfort University, MSc Artificial Intelligence.

## Highlights

- **Two metaheuristics implemented from scratch in MATLAB**: PSO with
  inertia-weight damping (w = 0.9, wdamp = 0.98, c1 = c2 = 2) and DE using
  the classic **DE/rand/1/bin** scheme (pCR = 0.9, β = 0.5 + 0.2·rand).
- **Two benchmark problems**: the unconstrained **Rosenbrock** function
  (with small stochastic noise added to harden the landscape) and the
  **Himmelblau** function with two inequality constraints handled via a
  **static penalty method** (quadratic penalty, coefficient 50).
- **Statistically sound comparison**: 15 independent runs per algorithm per
  problem, reporting **median** best cost rather than best-of-N, and
  plotting the median run's convergence curve.
- **Parameter sensitivity study**: PSO inertia weight swept over
  w ∈ {0.4, 0.7, 0.9} on the Rosenbrock problem to quantify the
  exploration/exploitation trade-off.
- **Three complementary visualisations**: log-scale convergence plots
  (PSO vs. DE), 40-level contour maps of both landscapes, and
  swarm-evolution snapshots showing particle positions at initial, middle,
  and final iterations overlaid on the contours.

## Experiment protocol

1. Each algorithm is run **15 times** per problem (2-D search space,
   bounds [−5, 5], 250 iterations, population of 25).
2. Median best cost is computed for PSO and DE separately; the run whose
   final cost is closest to the median is selected as the representative
   run for visualisation.
3. Convergence curves of the two median runs are compared on a log scale.
4. The PSO parameter study re-runs Rosenbrock with different inertia
   weights (via `PSO_param.m`).
5. Particle trajectory snapshots are overlaid on the true contour
   landscapes to inspect exploration vs. premature convergence.

Findings (as documented in the report): adjusting population size and
iteration count alone yielded little improvement, while tuning the PSO
inertia weight and allowing more iterations moved solutions materially
closer to the optimum. DE showed stronger exploration and generally
higher accuracy — particularly on the constrained Himmelblau problem —
with faster average convergence than PSO.

## Algorithms

| Algorithm | Key settings | Output recorded |
| --- | --- | --- |
| **PSO** (`PSO.m`) | w = 0.9 damped by 0.98/iter, c1 = c2 = 2, zero initial velocity, boundary clamping | BestCost, BestCostHistory, full per-iteration swarm `History` |
| **DE** (`DE.m`) | DE/rand/1/bin, pCR = 0.9, β = 0.5 + 0.2·rand, boundary clamping | BestCost, BestCostHistory |
| **PSO (parameter variant)** (`PSO_param.m`) | Same core as PSO, initial inertia weight passed as an argument | BestCost |

## Benchmark problems

| Problem | File | Type | Constraints |
| --- | --- | --- | --- |
| Rosenbrock, (1−x₁)² + 100(x₂−x₁²)² | `rosenbrock.m` | Unconstrained | — |
| Himmelblau, (x₁²+x₂−11)² + (x₁+x₂²−7)² | `himmelblau_penalty.m` | Constrained | g₁ = x₁+x₂−5 ≤ 0; g₂ = x₁²+x₂²−20 ≤ 0 (static penalty, coeff. 50) |

Both cost functions add a small stochastic term (`0.001·rand`) to make the
landscapes harder. Note that `plotContour.m` and `plotEvolution.m`
visualise the clean (noise-free) functions.

## Repository structure

| File | Purpose |
| --- | --- |
| `main.m` | Entry point: experiment protocol — runs PSO and DE × 15 on both problems, prints median best costs, runs the inertia-weight parameter study, and generates all plots |
| `PSO.m` | Particle Swarm Optimisation implementation (returns best cost, convergence history, full swarm history) |
| `DE.m` | Differential Evolution (DE/rand/1/bin) implementation |
| `PSO_param.m` | PSO variant accepting the initial inertia weight as a parameter, used by the parameter study |
| `rosenbrock.m` | Unconstrained Rosenbrock cost function |
| `himmelblau_penalty.m` | Himmelblau cost function with static penalty constraint handling |
| `plotConvergence.m` | Log-scale convergence plot comparing PSO and DE |
| `plotContour.m` | Contour map (40 levels) of either benchmark landscape |
| `plotEvolution.m` | Contour map with PSO swarm positions at initial, middle, and final iterations |
| `P2952028- SHEHRYAR.pdf` | Accompanying coursework report |
| `README.md` | This file |

## Getting started

Requires MATLAB (any recent release; no toolboxes needed).

1. Clone the repository and open MATLAB in the repo folder.
2. Run the entry script:
   ```matlab
   main
   ```
3. The script prints median best costs and the parameter-study results to
   the console, and opens five figures: two convergence plots, two contour
   plots, and two swarm-evolution overlays (one per problem).

## Citation

If you use this work, please cite the accompanying report:

> SHEHRYAR (P2952028). *Evolutionary Computing.* De Montfort University,
> Leicester, MSc Artificial Intelligence, 2026.

## Author

**SHEHRYAR** — MSc Artificial Intelligence, De Montfort University.
GitHub: [@Shehryarcheema](https://github.com/Shehryarcheema)

## License

MIT — see [LICENSE](LICENSE) for details.
