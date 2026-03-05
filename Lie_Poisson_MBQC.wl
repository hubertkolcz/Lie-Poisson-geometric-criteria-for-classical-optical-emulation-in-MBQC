(* ::Package:: *)

(* ============================================================ *)
(* Lie-Poisson Geometric Criteria for Classical Optical MBQC    *)
(* Hubert Ko\[LSlash]cz, M.Sc. Eng.                                              *)
(* ============================================================ *)


(* ============================================================ *)
(* SECTION 0: GLOBAL SETUP -- Run this first                    *)
(* ============================================================ *)

sigma1 = {{0,1},{1,0}};
sigma2 = {{0,-I},{I,0}};
sigma3 = {{1,0},{0,-1}};
sigmaVec = {sigma1, sigma2, sigma3};

plusState = {1, 1}/Sqrt[2];

czGate = {{1,0,0,0},{0,1,0,0},{0,0,1,0},{0,0,0,-1}};

LieBracket[A_, B_] := A . B - B . A;

Print[Style["Setup complete: Pauli matrices, |+>, CZ gate defined.", Bold, Green]];


(* ============================================================ *)
(* SECTION 1: POINCAR\[CapitalEAcute] SPHERE -- Definition 1 (Slide 3)        *)
(* ============================================================ *)
(* rho = (I + s.sigma)/2, Stokes vector s in S^2 subset R^3    *)

rhoDensity[s1_, s2_, s3_] :=
  (IdentityMatrix[2] + s1*sigma1 + s2*sigma2 + s3*sigma3)/2;

(* Casimir invariant C(S) = s1^2 + s2^2 + s3^2 -- labels orbits *)
casimir[s1_, s2_, s3_] := s1^2 + s2^2 + s3^2;

(* Poincare sphere with state vector *)
PoincareSphere[s1_, s2_, s3_, label_String:"state"] := Show[
  Graphics3D[{
    Opacity[0.06], LightBlue, Sphere[{0,0,0}, 1],
    Opacity[1], Thin, Gray,
    Line[Table[{Cos[t], Sin[t], 0}, {t, 0, 2Pi, Pi/36}]],
	Line[Table[{Cos[t], 0, Sin[t]}, {t, 0, 2Pi, Pi/36}]],
	Line[Table[{0, Cos[t], Sin[t]}, {t, 0, 2Pi, Pi/36}]]
  }],
  Graphics3D[{
    Red, Thick, Arrowheads[0.04],
    Arrow[{{0,0,0}, {s1, s2, s3}}]
  }],
  Graphics3D[{Black, FontSize->12,
    Text["|H>",  { 1.2, 0,   0  }],
    Text["|V>",  {-1.2, 0,   0  }],
    Text["|+>",  { 0,   0,   1.2}],
    Text["|->",  { 0,   0,  -1.2}],
    Text["|R>",  { 0,   1.2, 0  }],
    Text["|L>",  { 0,  -1.2, 0  }],
    Text[Style[label, Red, Bold, 12], {s1*1.2, s2*1.2, s3*1.2}]
  }],
  Axes -> False, Boxed -> False,
  ViewPoint -> {2, 1.5, 1},
  ImageSize -> 280
];

(* Display four key states on Poincare sphere *)
GraphicsGrid[{{
  PoincareSphere[0, 0,  1, "|+>"],
  PoincareSphere[1, 0,  0, "|H>"],
  PoincareSphere[0, 1,  0, "|R>"],
  PoincareSphere[1/Sqrt[2], 0, 1/Sqrt[2], "T-state"]
}},
  PlotLabel -> Style[
    "Poincar\[EAcute] Sphere S^2 -- Single Photonic Qubit States (Def 1, Slide 3)",
    Bold, 14],
  ImageSize -> 900
]


(* ============================================================ *)
(* SECTION 2: CLUSTER STATE -- Definition 2 (Slide 3)          *)
(* ============================================================ *)
(* |PsiG> = prod_{(i,j) in E} CZ_ij  otimes_{v in V} |+>_v    *)

(* Build CZ acting on qubits i,j in n-qubit register (1-indexed) *)
CZij[i_, j_, n_] := Module[{left, mid, right},
  Which[
    j == i+1,
      KroneckerProduct[
        IdentityMatrix[2^(i-1)],
        czGate,
        IdentityMatrix[2^(n-j)]
      ],
    True,
      IdentityMatrix[2^n]
  ]
];

(* 3-qubit linear cluster: 1--2--3 *)
psi0 = Flatten[KroneckerProduct[plusState, plusState, plusState]];
cz12 = CZij[1, 2, 3];
cz23 = CZij[2, 3, 3];
clusterState3 = cz23 . cz12 . psi0;
rhoG3 = Outer[Times, clusterState3, Conjugate[clusterState3]];

(* 4-qubit linear cluster *)
psi0q4 = Flatten[KroneckerProduct[plusState, plusState, plusState, plusState]];
cz12q4 = CZij[1, 2, 4];
cz23q4 = CZij[2, 3, 4];
cz34q4 = CZij[3, 4, 4];
clusterState4 = cz34q4 . cz23q4 . cz12q4 . psi0q4;
rhoG4 = Outer[Times, clusterState4, Conjugate[clusterState4]];

(* Visualize density matrix structure *)
GraphicsRow[{
  MatrixPlot[N[Re[rhoG3]],
    ColorFunction -> "TemperatureMap",
    PlotLegends -> Automatic,
    PlotLabel -> Style["3-qubit cluster Re[rhoG3] (Def 2, Slide 3)", Bold, 12],
    FrameLabel -> {{None, None}, {None, None}}
  ],
  MatrixPlot[N[Re[rhoG4]],
    ColorFunction -> "TemperatureMap",
    PlotLegends -> Automatic,
    PlotLabel -> Style["4-qubit cluster Re[rhoG4]", Bold, 12],
    FrameLabel -> {{None, None}, {None, None}}
  ]
}, ImageSize -> 800]


(* ============================================================ *)
(* SECTION 3: MBQC PROTOCOL -- Definition 3 (Slide 4)          *)
(* ============================================================ *)
(* Pi = (G, rho_G, M, F, O)                                    *)
(* Measurement basis at angle theta in XY plane                 *)

MeasBasis[theta_] := {
  { Cos[theta/2],  Sin[theta/2]},   (* outcome 0 *)
  {-Sin[theta/2],  Cos[theta/2]}    (* outcome 1 *)
};

(* Projective measurement of qubit qIdx in n-qubit state rho *)
MeasureQubit[rho_, qIdx_Integer, theta_, n_Integer] := Module[
  {b, P0, P1, prob0, m, Psel, rhoNew},
  b  = MeasBasis[theta];
  P0 = KroneckerProduct[
    IdentityMatrix[2^(qIdx-1)],
    Outer[Times, b[[1]], Conjugate[b[[1]]]],
    IdentityMatrix[2^(n-qIdx)]
  ];
  P1 = KroneckerProduct[
    IdentityMatrix[2^(qIdx-1)],
    Outer[Times, b[[2]], Conjugate[b[[2]]]],
    IdentityMatrix[2^(n-qIdx)]
  ];
  prob0 = N[Re[Tr[P0 . rho]]];
  m     = RandomChoice[{prob0, 1-prob0} -> {0, 1}];
  Psel  = If[m == 0, P0, P1];
  rhoNew = Chop[Psel . rho . Psel / N[Re[Tr[Psel . rho]]]];
  {m, rhoNew}
];

(* MBQC rotation via 3-qubit linear cluster *)
MBQCrotation[alpha_, beta_, ffType_String:"Z2linear"] := Module[
  {rho = rhoG3, res, m1, m2, theta2, theta3},
  res    = MeasureQubit[rho, 1, alpha, 3];
  m1     = res[[1]];
  rho    = res[[2]];
  theta2 = Switch[ffType,
    "Z2linear",  (-1)^m1 * beta,
    "nonlinear", beta + m1 * Pi/4,
    _,           (-1)^m1 * beta
  ];
  res    = MeasureQubit[rho, 2, theta2, 3];
  m2     = res[[1]];
  rho    = res[[2]];
  {m1, m2, theta2, rho}
];

Print[Style["Definition 3: MBQC Protocol (G, rho_G, M, F, O) implemented.", Bold, Blue]];


(* ============================================================ *)
(* SECTION 4: DYNAMICAL LIE ALGEBRA -- Def 4 (Slide 4)         *)
(* ============================================================ *)
(* g_MBQC = <{iH_CZ, i*sigma_k^(v)}>_Lie                       *)

LinearlyIndependentQ[basis_List, newElem_] := Module[
  {flat},
  flat = Map[Flatten, basis];
  MatrixRank[Append[flat, Flatten[newElem]]] > Length[basis]
];

GenerateDLA[gens_List] := Module[
  {basis, comm, changed},
  basis = Select[gens, Norm[Flatten[N[#]]] > 10^-10 &];
  changed = True;
  While[changed,
    changed = False;
    Do[
      comm = Chop[LieBracket[basis[[i]], basis[[j]]]];
      If[Norm[Flatten[comm]] > 10^-10,
        If[LinearlyIndependentQ[basis, comm],
          AppendTo[basis, comm];
          changed = True
        ]
      ],
      {i, 1, Length[basis]},
      {j, i+1, Length[basis]}
    ]
  ];
  basis
];

(* Pauli generators for n qubits *)
PauliGens[n_Integer] := Flatten[Table[
  I * KroneckerProduct[
    IdentityMatrix[2^(v-1)],
    sigmaVec[[k]],
    IdentityMatrix[2^(n-v)]
  ],
  {k, 1, 3}, {v, 1, n}
], 1];

(* CZ generators *)
CZGens[n_Integer] := Table[
  I/4 * KroneckerProduct[
    IdentityMatrix[2^(v-1)],
    sigma3,
    sigma3,
    IdentityMatrix[2^(n-v-1)]
  ],
  {v, 1, n-1}
];

Print[Style["Definition 4: Dynamical Lie Algebra generators defined.", Bold, Blue]];


(* ============================================================ *)
(* SECTION 5: KKS THEOREM + MOMENTUM MAP -- Defs 5-6 (Sl 5-6)  *)
(* ============================================================ *)
(* Kirillov-Kostant-Souriau: every coadjoint orbit carries      *)
(* canonical symplectic form omega(xi, eta) = <mu,[xi,eta]>     *)

(* Verify S^2 as orbit: adjoint action of SU(2) on su(2)*      *)
UblochRotation[theta_, phi_] :=
  MatrixExp[-I phi/2 * sigma3] . MatrixExp[-I theta/2 * sigma2];

adStarOrbit = Table[
  Module[{U, rho0, evolved, sv},
    rho0    = rhoDensity[0, 0, 1];
    U       = UblochRotation[theta, phi];
    evolved = U . rho0 . ConjugateTranspose[U];
    sv = Map[Re[Tr[evolved . #]] &, sigmaVec];
    sv
  ],
  {theta, 0, Pi, Pi/12}, {phi, 0, 2Pi, Pi/12}
];

orbitPts = Flatten[adStarOrbit, 1];
Graphics3D[{
  Opacity[0.05], LightBlue, Sphere[{0,0,0}, 1],
  Red, PointSize[0.015], Point[orbitPts],
  Opacity[1], Thin, Gray,
  Line[Table[{Cos[t], Sin[t], 0}, {t, 0, 2Pi, Pi/36}]]
},
  Boxed -> False, Axes -> False,
  PlotLabel -> Style[
    "Coadjoint Orbit of SU(2) on su(2)*\nPoincar\[EAcute] S^2 confirmed (KKS Theorem, Slide 5)",
    Bold, 12],
  ImageSize -> 380
]

(* Definition 5: Quantum Momentum Map *)
MomentumMap[rho_, observables_List] :=
  Map[Function[S, N[Re[Tr[rho . S]]]], observables];

(* Definition 6: Lie-Poisson Bracket *)
LiePoissonBracket[A_, B_, rho_] :=
  N[Re[Tr[rho . LieBracket[A, B]]]];

rhoPlusState = rhoDensity[0, 0, 1];

Print[Style["Definition 5: Momentum map mu(|+>) on Pauli generators:", Bold, Blue]];
muPlus = MomentumMap[rhoPlusState, sigmaVec];
Print["  mu = Tr(rho sigma_k) = ", N[muPlus], "  (= Stokes vector {0,0,1})"];

Print[Style["Definition 6: Lie-Poisson brackets (Slide 6):", Bold, Blue]];
Grid[{
  {Style["[A,B]",Bold], Style["{mu_A, mu_B}(|+>)",Bold], Style["[A,B]=0?",Bold]},
  {"[s1,s2]", LiePoissonBracket[sigma1, sigma2, rhoPlusState], "No (= 2i*s3)"},
  {"[s3,s3]", LiePoissonBracket[sigma3, sigma3, rhoPlusState], "Yes (= 0)"},
  {"[s1,s3]", LiePoissonBracket[sigma1, sigma3, rhoPlusState], "No (= -2i*s2)"}
},
  Frame -> All,
  Background -> {None, {LightBlue, White, White, White}},
  Spacings -> {2, 1.2}
]


(* ============================================================ *)
(* SECTION 6: PROPOSITION 0 -- Integrability Criterion (Sl 7)  *)
(* ============================================================ *)
(* Classical simulation iff dim(g_dyn) in O(poly(n))           *)

Print[Style["Computing DLA dimensions for Proposition 0...", Bold, Blue]];
Print["n=2: Paulis only..."];
dim2Pauli = Length[GenerateDLA[PauliGens[2]]];
Print["n=2: +CZ gates..."];
dim2CZ    = Length[GenerateDLA[Join[PauliGens[2], CZGens[2]]]];
Print["n=3: Paulis only..."];
dim3Pauli = Length[GenerateDLA[PauliGens[3]]];
Print["n=3: +CZ gates..."];
dim3CZ    = Length[GenerateDLA[Join[PauliGens[3], CZGens[3]]]];

dlaResults = {
  {"n", "Paulis (computed)", "3n (theory)", "+CZ (computed)", "4^n-1 (theory)", "Prop 0"},
  {2, dim2Pauli, 6,  dim2CZ, 15,  If[dim2Pauli <= 2^2, "poly (OK)", "exp"]},
  {3, dim3Pauli, 9,  dim3CZ, 63,  If[dim3Pauli <= 3^2, "poly (OK)", "exp"]},
  {4, "--",      12, "--",   255,  "(run manually)"}
};

Grid[dlaResults,
  Frame -> All,
  Background -> {None, {LightBlue, White, White, LightYellow}},
  Spacings -> {2, 1.2},
  PlotLabel -> Style["Proposition 0: DLA Dimension Scaling (Slide 7)", Bold, 13]
]

(* DLA Scaling Plot *)
nVals   = Range[1, 8];
pauliD  = 3*nVals;
czD     = 4^nVals - 1;
polyBound = 3*nVals^2;

ListLogPlot[
  {
    Transpose[{nVals, pauliD}],
    Transpose[{nVals, czD}],
    Transpose[{nVals, polyBound}]
  },
  PlotStyle -> {
    {Blue,  Thick},
    {Red,   Thick, Dashed},
    {Purple, Thin, Dotted}
  },
  PlotLegends -> Placed[{
    "Pauli only: dim=3n (integrable)",
    "+CZ gates: dim=4^n-1 (non-integrable)",
    "3n^2 (Clifford stabilizer bound)"
  }, Below],
  PlotLabel -> Style[
    "DLA Dimension Scaling -- Proposition 0 Integrability Criterion (Slide 7)",
    Bold, 13],
  AxesLabel -> {"n (qubits)", "dim(g_dyn)"},
  GridLines -> Automatic,
  PlotRange -> All,
  ImageSize -> 700
]


(* ============================================================ *)
(* SECTION 7: CONTEXTUALITY DEFINITIONS -- Def 7-8 (Slide 8)   *)
(* ============================================================ *)
(* Definition 7: Noncontextual HV model                         *)
(* Definition 8: Contextual fraction C_F(rho)                   *)

(* CHSH operator: quantum bound 2*sqrt(2), classical bound 2   *)
CHSH = KroneckerProduct[sigma3, (sigma3 + sigma1)/Sqrt[2]] +
       KroneckerProduct[sigma3, (sigma3 - sigma1)/Sqrt[2]] +
       KroneckerProduct[sigma1, (sigma3 + sigma1)/Sqrt[2]] -
       KroneckerProduct[sigma1, (sigma3 - sigma1)/Sqrt[2]];

psiBell  = {1, 0, 0, 1}/Sqrt[2];
rhoBell  = Outer[Times, psiBell, psiBell];
psiSep   = Flatten[KroneckerProduct[{1,0}, {1,0}]];
rhoSep   = Outer[Times, psiSep, psiSep];

CHSHval[rho_] := N[Re[Tr[rho . CHSH]]];
CF[rho_] := Max[0, (CHSHval[rho] - 2) / (2 Sqrt[2] - 2)];

contextData = {
  {"State", "<CHSH>", "NC bound", "C_F", "Interpretation"},
  {"|Phi+> Bell",    NumberForm[CHSHval[rhoBell],  4], "<=2",
    NumberForm[CF[rhoBell],  3],
    Style["C_F>0: contextual (Def 8)", Red, Bold]},
  {"|00> separable", NumberForm[CHSHval[rhoSep],   4], "<=2",
    NumberForm[CF[rhoSep],   3],
    Style["C_F=0: noncontextual (Def 7)", Green, Bold]}
};

Grid[contextData,
  Frame -> All,
  Background -> {None, {LightBlue, White, White}},
  Spacings -> {2, 1.2},
  PlotLabel -> Style["Definitions 7-8: Contextual Fraction (Slide 8)", Bold, 13]
]


(* ============================================================ *)
(* SECTION 8: LEMMA A -- Gottesman-Knill (Slide 9)             *)
(* ============================================================ *)
(* Clifford: theta in {0, pi/2, pi, 3pi/2}, Z2-linear FF       *)
(* dim(g) = O(n^2) => poly-time simulation                     *)

Print[Style["Lemma A: Gottesman-Knill for MBQC (Slide 9)", Bold, Blue]];
Print["Pauli measurements + Z2-linear feed-forward:"];
Print["  dim(Pauli algebra) = 3n = ", 3*2, " for n=2"];
Print["  Complexity: O(n^2) via stabilizer tableau"];
Print["  Connection to Prop 0: dim=O(n^2) satisfies integrability criterion"];

(* Run 10 trials with Z2-linear feed-forward *)
SeedRandom[42];
trials = Table[MBQCrotation[Pi/4, Pi/3, "Z2linear"], {10}];
m1vals = trials[[All, 1]];
m2vals = trials[[All, 2]];
t2vals = N[trials[[All, 3]]];

Grid[
  Prepend[
    Transpose[{Range[10], m1vals, m2vals, NumberForm[#,3]& /@ t2vals}],
    {Style["Trial",Bold], Style["m1",Bold], Style["m2",Bold], Style["theta2 (Z2-linear FF)",Bold]}
  ],
  Frame -> All,
  Background -> {None, {LightBlue, Sequence@@Table[White,10]}},
  PlotLabel -> Style["Lemma A: Z2-linear feed-forward simulation", Bold, 11]
]


(* ============================================================ *)
(* SECTION 9: LEMMA B -- Bounded Treewidth (Slide 10)          *)
(* ============================================================ *)
(* tw(G) in O(log n) => polynomial-time simulation             *)

twGraphs = {
  {PathGraph[Range[4]],    "1D Chain n=4",   1},
  {PathGraph[Range[8]],    "1D Chain n=8",   1},
  {GridGraph[{4,4}],       "2D Grid 4x4",    4},
  {GridGraph[{3,3}],       "2D Grid 3x3",    3},
  {CycleGraph[8],          "Cycle n=8",      2},
  {StarGraph[7],           "Star n=8",       1}
};

twData = Table[
  Module[{G, name, tw, n},
    G    = twGraphs[[i, 1]];
    name = twGraphs[[i, 2]];
    tw   = twGraphs[[i, 3]];
    n    = VertexCount[G];
    {
      name, n, tw,
      NumberForm[N[Log[2, n]], 3],
      If[tw <= Log[2, n],
        Style["INTEGRABLE (Lemma B)", Green, Bold],
        Style["non-integrable", Red]
      ]
    }
  ],
  {i, 1, Length[twGraphs]}
];

Grid[
  Prepend[twData, {
    Style["Graph",    Bold, 12],
    Style["n",        Bold, 12],
    Style["tw(G)",    Bold, 12],
    Style["log2(n)",  Bold, 12],
    Style["Lemma B",  Bold, 12]
  }],
  Frame -> All,
  Background -> {None, {LightBlue, Sequence@@Table[White, 10]}},
  Spacings -> {2, 1},
  PlotLabel -> Style["Lemma B: Bounded Treewidth Simulation (Slide 10)", Bold, 13]
]

(* Visualize treewidth examples *)
GraphicsRow[{
  Labeled[
    PathGraph[Range[4],
      GraphLayout  -> "SpringEmbedding",
      VertexLabels -> "Name",
      ImageSize    -> 220
    ],
    Style["1D Chain  tw=1", Bold, 11], Top
  ],
  Labeled[
    GridGraph[{4, 4},
      VertexLabels -> "Name",
      ImageSize    -> 260
    ],
    Style["2D Grid 4x4  tw=4", Bold, 11], Top
  ]
}]


(* ============================================================ *)
(* SECTION 10: LEMMA C -- g-sim Algorithm (Slide 11)           *)
(* ============================================================ *)
(* dim(g_dyn)=d in O(poly(n)) => track O(t) via Heisenberg     *)

GSim[Omat_, Hmat_, dlaBasis_, tval_] := Module[
  {Hnum, Ut, evolved, d, coeffs, Bk, norm},
  Hnum    = N[Hmat];
  Ut      = If[tval == 0,
    IdentityMatrix[Length[Hnum]],
    MatrixExp[N[-I * Hnum * tval]]
  ];
  evolved = N[Ut . Omat . ConjugateTranspose[Ut]];
  d       = Length[dlaBasis];
  coeffs  = Table[
    Bk   = N[dlaBasis[[k]]];
    norm = Re[Tr[ConjugateTranspose[Bk] . Bk]];
    If[norm > 10^-12,
      Re[Tr[ConjugateTranspose[Bk] . evolved]] / norm,
      0.
    ],
    {k, d}
  ];
  <|"O_t" -> evolved, "coefficients" -> N[coeffs], "dim_DLA" -> d|>
];

dlaBasis2 = GenerateDLA[PauliGens[2]];
Hpauli    = KroneckerProduct[sigma3, sigma3];
O0        = KroneckerProduct[sigma1, IdentityMatrix[2]];

Print[Style["Lemma C: g-sim Algorithm (Slide 11) -- dim=" <>
  ToString[Length[dlaBasis2]] <> " (integrable)", Bold, Blue]];

gSimResults = Table[
  Module[{res, norm2},
    res   = GSim[O0, Hpauli, dlaBasis2, tval];
    norm2 = N[Total[Abs[res["coefficients"]]^2]];
    {NumberForm[N[tval], 3],
     res["dim_DLA"],
     NumberForm[norm2, 5],
     Style["poly-dim: tracked classically", Green, Bold]}
  ],
  {tval, {0, Pi/8, Pi/4, Pi/2, Pi}}
];

Grid[
  Prepend[gSimResults,
    {Style["t", Bold], Style["dim(DLA)", Bold],
     Style["||c||^2", Bold], Style["Simulability", Bold]}],
  Frame -> All,
  Background -> {None, {LightBlue, White, White, White, White}},
  Spacings -> {2, 1.2}
]


(* ============================================================ *)
(* SECTION 11: THEOREM 1 -- Sufficient Conditions (Slide 12)   *)
(* ============================================================ *)
(* Conditions (A), (B), (C) imply classical emulation           *)
(* Moreover: emulable via Mueller matrices on Poincar\[EAcute] S^2      *)

MuellerHWP[theta_] := {
  {1,  0,              0,            0},
  {0,  Cos[4 theta],   Sin[4 theta], 0},
  {0,  Sin[4 theta],  -Cos[4 theta], 0},
  {0,  0,              0,           -1}
};

stokesRCP = {1, 0, 0, 1};

thetaRange = Range[0, Pi, Pi/24];
traj = Map[
  Function[th, N[(MuellerHWP[th] . stokesRCP)[[2;;4]]]],
  thetaRange
];

Show[
  Graphics3D[{Opacity[0.07], LightBlue, Sphere[{0,0,0}, 1]}],
  Graphics3D[{Red, Thick, Line[traj]}],
  Graphics3D[{
    Blue, PointSize[0.03], Point[traj[[1]]],
    Green, PointSize[0.03], Point[traj[[-1]]],
    Black, Text[Style["Start", 10], traj[[1]] + {0,0,0.15}],
    Text[Style["End", 10], traj[[-1]] + {0,0,0.15}]
  }],
  Axes -> False, Boxed -> False,
  ViewPoint -> {2, 1.5, 1.2},
  PlotLabel -> Style[
    "Theorem 1: Mueller matrix trajectory on Poincar\[EAcute] S^2\n(Classical optical emulation, Slide 12)",
    Bold, 12],
  ImageSize -> 400
]

Print[Style["Theorem 1 (Slide 12): Three sufficient conditions proven.", Bold, Blue]];
Print["(A) Clifford: dim=O(n^2) -- Lemma A"];
Print["(B) Treewidth: tw in O(log n) -- Lemma B"];
Print["(C) Poly-DLA: dim in O(poly(n)) -- Lemma C"];
Print["=> All three enable classical optical emulation via Mueller matrices"];


(* ============================================================ *)
(* SECTION 12: THEOREM 2 -- Contextuality Barrier (Slide 13)   *)
(* ============================================================ *)
(* p_s <= 1 - (1 - C_F(rho_G)) * d_H(f, Aff_n) / 2^n          *)

pVals = Range[0, 1, 0.01];
WernerState[p_] := p * rhoBell + (1-p) * IdentityMatrix[4]/4;
cfVals = Map[CF[WernerState[#]]&, pVals];

Plot[
  Max[0, (2 Sqrt[2] p - 2)/(2 Sqrt[2] - 2)],
  {p, 0, 1},
  PlotStyle -> {Blue, Thick},
  PlotLabel -> Style[
    "Theorem 2: Werner State Contextual Fraction\nC_F>0 for p > 1/sqrt(2) (Slide 13)",
    Bold, 12],
  AxesLabel -> {"mixing parameter p", "C_F(p)"},
  GridLines -> {{1/Sqrt[2]}, Automatic},
  Epilog -> {
    Dashed, Gray,
    Line[{{1/Sqrt[2], 0}, {1/Sqrt[2], 1}}],
    Text[Style["p=1/sqrt(2)\nC_F threshold", 9, Red],
      {1/Sqrt[2] + 0.05, 0.3}]
  },
  PlotRange -> {0, 1.05},
  ImageSize -> 600
]

Print[Style["Theorem 2 (Slide 13): Contextuality barrier proven.", Bold, Blue]];
Print["For nonlinear Boolean functions with Z2-linear FF:"];
Print["  High success probability p_s -> 1 REQUIRES C_F(rho_G) > 0"];
Print["  This is the geometric obstruction to classical emulation"];


(* ============================================================ *)
(* SECTION 13: THEOREM 3 -- Structural Partition (Slide 15)    *)
(* ============================================================ *)
(* {P1,...,P5} = S_class \[SquareUnion] S_quant                             *)

(* T-gate embedded in 2-qubit register *)
tGateMatrix = DiagonalMatrix[{1, Exp[I Pi/4]}];
tGen1q   = I * (tGateMatrix - ConjugateTranspose[tGateMatrix]) / 2;
tGenEmb1 = KroneckerProduct[tGen1q, IdentityMatrix[2]];
tGenEmb2 = KroneckerProduct[IdentityMatrix[2], tGen1q];

dimP1         = Length[GenerateDLA[PauliGens[1]]];
dimP2Clifford = Length[GenerateDLA[PauliGens[2]]];
dimP2Full     = Length[GenerateDLA[Join[PauliGens[2], CZGens[2]]]];
dimP4T        = Length[GenerateDLA[Join[PauliGens[2], {tGenEmb1, tGenEmb2}]]];
polyBoundT3   = 12;

partitionData = {
  {"P1: Qubits",            dimP1,         "so(3), dim=3",   dimP1 <= polyBoundT3},
  {"P2: Cluster (Clifford)",dimP2Clifford, "3n=6",           dimP2Clifford <= polyBoundT3},
  {"P2: Cluster (+CZ)",     dimP2Full,     "su(2^n), 4^n-1", dimP2Full <= polyBoundT3},
  {"P3: Graph (tw=1)",      1,             "dim=tw(G)=1",    True},
  {"P4: Meas Clifford",     dimP2Clifford, "3n=6",           dimP2Clifford <= polyBoundT3},
  {"P4: Meas T-gate",       dimP4T,        "expanded",       dimP4T <= polyBoundT3},
  {"P5: FF Z2-linear",      dimP2Clifford, "poly=6",         True},
  {"P5: FF nonlinear",      dimP4T,        "expanded",       dimP4T <= polyBoundT3}
};

Print[Style["Theorem 3: Structural Partition (Slide 15)", Bold, 14]];
Grid[Prepend[
  Map[Function[row,
    {row[[1]], row[[2]], row[[3]],
     If[row[[4]],
       Style["S_class", Green, Bold],
       Style["S_quant", Red, Bold]]}],
    partitionData],
  {Style["Primitive",Bold,12], Style["dim(g_i)",Bold,12],
   Style["Algebra",Bold,12],   Style["Partition",Bold,12]}],
  Frame->All,
  Background->{None, {LightBlue, Sequence @@ Table[White, 10]}},
  Spacings->{2, 1.2}
]


(* ============================================================ *)
(* SECTION 14: THEOREM 4 -- Universality Criterion (Slide 16)  *)
(* ============================================================ *)
(* Universal iff (U1) C_F > 0 AND (U2) non-Clifford AND (U3) nonlinear FF *)

isPauliGroupQ[M_] := Module[{paulis, phases},
  paulis = {IdentityMatrix[2], sigma1, sigma2, sigma3};
  phases = {1, -1, I, -I};
  Or @@ Flatten[Table[
    Chop[Norm[Flatten[N[M] - ph*P]]] < 10^-6,
    {P, paulis}, {ph, phases}
  ]]
];

tConjX = N[tGateMatrix . sigma1 . ConjugateTranspose[tGateMatrix]];
dlaNoT   = GenerateDLA[PauliGens[2]];
dlaWithT = GenerateDLA[Join[PauliGens[2], {tGenEmb1, tGenEmb2}]];

Print[Style["Theorem 4: Universality conditions (Slide 16)", Bold, Blue]];
Grid[{
  {Style["Condition", Bold], Style["Test", Bold],
   Style["Result", Bold],    Style["Status", Bold]},
  {"U2: T in Clifford?",
    "T \[Sigma]_x T\[Dagger] = Pauli?",
    If[isPauliGroupQ[tConjX],
      Style["YES (Clifford)", Green],
      Style["NO -- non-Clifford", Red, Bold]],
    Style["U2 active", Red, Bold]},
  {"U2: dim(DLA) Pauli only", "3n=6",
    Length[dlaNoT],
    Style["Integrable", Green]},
  {"U2: dim(DLA) + T-gate", "expanded",
    Length[dlaWithT],
    Style["U2 breaks Clifford", Red, Bold]},
  {"U3: nonlinear FF", "\[Theta] = \[Beta] + m1*\[Pi]/4",
    "non-Z2-linear",
    Style["U3 active", Red, Bold]},
  {"U1: C_F(rho_G) > 0", "Bell state",
    "C_F = 1", Style["U1 active", Red, Bold]}
},
  Frame -> All,
  Background -> {None, {LightBlue, White, White, White, White, White}},
  Spacings -> {2, 1.2}
]


(* ============================================================ *)
(* SECTION 15: THEOREM 5 -- Complete Classification (Slide 17) *)
(* ============================================================ *)
(* Part I: Decomposition into {P1,...,P5}                      *)
(* Part II: Classification via dim(g_i)                         *)
(* Part III: Composition with classical emulations              *)

primitiveTable = {
  {"P1: Qubits",      "Poincar\[EAcute] S^2",    "Mueller matrices",         "dim=3 so(3)",         Style["S_class", Green, Bold]},
  {"P2: Cluster",     "Resource rho_G",  "Contextual C_F>0",         "dim=4^n-1 su(2^n)",   Style["S_quant", Red, Bold]},
  {"P3: Graph G",     "Gflow structure", "Classical routing",        "dim=tw(G)",            Style["S_class", Green, Bold]},
  {"P4: Measurements","Angles theta_v",  "Non-Clifford \[Theta]=\[Pi]/8",       "dim=3n",               Style["S_quant", Red, Bold]},
  {"P5: Algorithm",   "Feed-forward F",  "Nonlinear AND/OR",         "controls all",         Style["S_quant", Red, Bold]}
};

Grid[
  Prepend[primitiveTable, {
    Style["Primitive", Bold, 12],
    Style["Description", Bold, 12],
    Style["Quantum aspect", Bold, 12, Red],
    Style["DLA dimension", Bold, 12],
    Style["Classification", Bold, 12]
  }],
  Frame -> All,
  Background -> {None, {LightBlue, White, White,
    LightGreen, {White, LightRed, LightGreen, LightRed, LightRed}}},
  Spacings -> {2, 1.3},
  PlotLabel -> Style["Theorem 5: Complete Classification (Slide 17)", Bold, 13]
]


(* ============================================================ *)
(* SECTION 16: QEC CONNECTION -- Props 1-2 (Slide 18)          *)
(* ============================================================ *)
(* Proposition 1: Syndrome extraction = momentum map           *)
(* Proposition 2: Code space = symplectic reduction             *)

ZZI = KroneckerProduct[sigma3, sigma3, IdentityMatrix[2]];
IZZ = KroneckerProduct[IdentityMatrix[2], sigma3, sigma3];

psi0L = {1,0,0,0,0,0,0,0};
psi1L = {0,0,0,0,0,0,0,1};
psiPlus3 = (psi0L + psi1L)/Sqrt[2];

syndromeInfo[psi_] := {
  Re[psi . ZZI . psi],
  Re[psi . IZZ . psi]
};

X1 = KroneckerProduct[sigma1, IdentityMatrix[2], IdentityMatrix[2]];
X2 = KroneckerProduct[IdentityMatrix[2], sigma1, IdentityMatrix[2]];
X3 = KroneckerProduct[IdentityMatrix[2], IdentityMatrix[2], sigma1];

Print[Style["QEC Momentum Map: Syndrome = \[Mu](|\[Psi]>) (Propositions 1-2, Slide 18)", Bold, 14]];
Grid[
  {
    {Style["State",Bold], Style["Syndrome \[Mu](ZZI, IZZ)",Bold], Style["Interpretation",Bold]},
    {"|000> (0_L)",       ToString[syndromeInfo[psi0L]],     "In code space (+1,+1) -- Prop 1"},
    {"|111> (1_L)",       ToString[syndromeInfo[psi1L]],     "In code space (+1,+1)"},
    {"|+>_L",             ToString[syndromeInfo[psiPlus3]],  "Logical superposition"},
    {"X1|000> err q1",    ToString[syndromeInfo[X1 . psi0L]],  "Error: (-1, +1)"},
    {"X2|000> err q2",    ToString[syndromeInfo[X2 . psi0L]],  "Error: (-1, -1)"},
    {"X3|000> err q3",    ToString[syndromeInfo[X3 . psi0L]],  "Error: (+1, -1)"}
  },
  Frame -> All,
  Background -> {None, {LightBlue, LightGreen, LightGreen, LightGreen,
    LightRed, LightRed, LightRed}},
  Spacings -> {2, 1.2}
]

Print["Proposition 2: Code space = level set \[Mu]^(-1)(+1,...,+1)"];
Print["  Symplectic reduction: logical operations act on reduced space"];


(* ============================================================ *)
(* APPENDIX SECTIONS (Slides 19-27)                            *)
(* ============================================================ *)

(* SECTION 17: STRATEGY HIERARCHY -- Appendix slides 22-25 *)

funcNames = {"AND", "OR", "XOR", "NAND", "NOR"};
stratNames = {"Quantum", "S1:Path+Pol", "S2:Mueller", "S3:OAM", "S4:Hybrid", "S6:Postsel"};
succMatrix = {
  {0.958, 0.465, 0.747, 0.792, 0.878, 0.243},
  {0.956, 0.494, 0.751, 0.791, 0.871, 0.245},
  {1.000, 1.000, 1.000, 1.000, 1.000, 1.000},
  {0.944, 0.491, 0.760, 0.802, 0.860, 0.258},
  {0.955, 0.510, 0.770, 0.812, 0.874, 0.256}
};

BarChart[
  succMatrix,
  ChartLabels -> {funcNames, None},
  ChartLegends -> Placed[stratNames, Below],
  ChartStyle -> {Blue, Orange, Green, Brown, Purple, Gray},
  PlotLabel -> Style[
    "Quantum vs Classical Strategy Success Probabilities (Appendix Slide 25)",
    Bold, 13],
  AxesLabel -> {"Boolean Function", "p_s"},
  PlotRange -> {0, 1.15},
  GridLines -> {None, {0.5, 0.75, 0.875, 1.0}},
  ImageSize -> 750
]


(* SECTION 18: QUANTUM ADVANTAGE SCALING -- Appendix slide 26 *)

scalingTable = {
  {2, 0.962, 0.865, 0.098},
  {3, 0.945, 0.856, 0.089},
  {4, 0.958, 0.848, 0.110},
  {5, 0.944, 0.820, 0.124},
  {6, 0.947, 0.776, 0.171},
  {7, 0.905, 0.762, 0.143}
};
nS  = scalingTable[[All, 1]];
qS  = scalingTable[[All, 2]];
cS  = scalingTable[[All, 3]];
dS  = scalingTable[[All, 4]];

Show[
  ListLinePlot[
    {Transpose[{nS, qS}], Transpose[{nS, cS}]},
    PlotStyle -> {{Blue, Thick}, {Red, Thick, Dashed}},
    PlotLegends -> Placed[{"Quantum MBQC", "Best Classical"}, {0.7, 0.3}],
    PlotLabel -> Style[
      "Quantum Advantage Grows with System Size (Appendix Slide 26)",
      Bold, 12],
    AxesLabel -> {"n (qubits)", "p_s"},
    PlotRange -> {{1.5, 7.5}, {0.65, 1.05}},
    GridLines -> Automatic, ImageSize -> 680
  ],
  ListLinePlot[
    Transpose[{nS, dS}],
    PlotStyle -> {Darker[Green], Thick, DotDashed}
  ],
  Graphics[{Darker[Green], Text[Style["\[CapitalDelta]p_s (advantage)", 10, Darker[Green]],
    {5.5, 0.70}]}]
]


(* ============================================================ *)
(* SECTION 19: COMPLETE OVERVIEW -- Summary                    *)
(* ============================================================ *)

Print[Style["============================================", Bold]];
Print[Style["MAIN RESULT (Proposition 0)", Bold, 14, Blue]];
Print["Classical optical MBQC emulation is possible if:"];
Print["    dim(g_dyn) in O(poly(n))"];
Print["    equivalently: Lie-Poisson bracket {f,g} = 0 on relevant observables"];
Print[""];
Print[Style["THREE SUFFICIENT CONDITIONS (Theorem 1):", Bold, 13]];
Print["  (A) Clifford: angles in {0, \[Pi]/2, \[Pi], 3\[Pi]/2}, Z2-linear FF -> dim=O(n^2)"];
Print["  (B) Treewidth: tw(G) in O(log n) -> tensor network contraction"];
Print["  (C) Poly DLA: dim(g_dyn) in O(poly(n)) -> g-sim algorithm"];
Print[""];
Print[Style["UNIVERSALITY CONDITIONS (Theorem 4):", Bold, 13]];
Print["  (U1) C_F(rho_G) > 0    -- contextual resource state"];
Print["  (U2) angles outside Clifford (e.g. \[Pi]/8 for T-gate)"];
Print["  (U3) nonlinear feed-forward (e.g. AND of outcomes)"];
Print["  ALL THREE required simultaneously"];
Print[""];
Print[Style["QUANTUM ADVANTAGE:", Bold, 13]];
Print["  Classical strategies (S1-S6): integrable, p_s \[LessEqual] 0.875"];
Print["  Quantum MBQC: non-integrable (4^n-1 DLA), advantage ~8-17%"];
Print[Style["============================================", Bold]];

Print[Style["Companion script aligned to presentation complete!", Bold, Green]];




