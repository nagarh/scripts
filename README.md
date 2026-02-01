# scripts

Miscellaneous scripts and configs I use.

---

## localcolabfold

Scripts in `localcolabfold/` are taken from the original [**YoshitakaMo/localcolabfold**](https://github.com/YoshitakaMo/localcolabfold) repo (ColabFold on your local PC), with a few tweaks that worked for me.

I was trying to install the **GPU version** of ColabFold but it was not working for me. Before installation I ran `module load cuda/12.4.0`, then installed using these tweaks and made some changes in the example bash file (`run_colabfoldbatch_sample.sh`) to run `colabfold_batch`. With that, it worked for me.

**Included:**

- `pyproject.toml` — Pixi project config for installing ColabFold (Linux + macOS).
- `run_colabfoldbatch_sample.sh` — Sample run script for `colabfold_batch`.

**Original project:** [https://github.com/YoshitakaMo/localcolabfold](https://github.com/YoshitakaMo/localcolabfold)

Install and usage follow the [original LocalColabFold instructions](https://github.com/YoshitakaMo/localcolabfold#installation) (clone, `pixi install`, `pixi run setup`, then run the sample script). Use these files in place of the ones from the upstream repo if you want the same tweaks.
