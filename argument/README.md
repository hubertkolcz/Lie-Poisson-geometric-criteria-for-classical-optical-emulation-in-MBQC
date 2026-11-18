# Argument graph

`graph.yaml` records the logical structure of the study: the research question, definitions, assumptions, cited
results with their conditions, Proposition 0 (as its two directions), Lemmas A-C, Theorems 1-3, the corollaries, the
optical strategies S1-S5 and the numerical checks - and what each statement rests on. It encodes
`archive/docs/MATHEMATICAL_READING_GUIDE_Streamlined.md` ("Summary: Logical Dependencies") and
`archive/docs/RESEARCH_DOCUMENTATION_v2.md`, Sec. 4, without changing the mathematics.

`ARGUMENT.md` is generated from it: a skeleton in reading order, the argument map, the standing of the main results
and the checker's findings. Edit the graph, not the page.

How to read it:

- A node's status is its own step as the documents present it ("proven" = its own proof is given). The standing is
  computed for the whole chain: a theorem whose proof is complete but which uses a sketched lemma is proven,
  effectively provisional.
- `depends_on` lists premises; `validated_by` lists numerical checks, which corroborate and never prove;
  `conditional_on` would list explicit conditions.
- An "if and only if" is two theorems, one per direction (Proposition 0: `P0-fwd`, `P0-bwd`).
- Steps marked `derivation: logical` are checked by truth table over the atoms declared at the top.
- `notes` record what the encoding made visible. They are questions for the author, not corrections.

The format and the checks come from research-methodology-core (`rmcore`, not yet public). With it on the path:

```bash
python -m rmcore check
python -m rmcore page --out argument/ARGUMENT.md
```
