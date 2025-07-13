# ① Clone the empty repo and cd into it
git clone https://github.com/<your‑org>/<your‑repo>.git
cd <your‑repo>

# ② Create the base folders GitHub likes
mkdir -p .github/workflows

# ③ Drop three text files (see blocks below)
#    • .gitignore
#    • README.md
#    • .github/workflows/godot-ci.yml

# ④ Launch Godot 4, click “New Project” → choose this folder → “Create & Edit”.
#    Godot writes:
#       project.godot
#       default_env.tres
#       (an empty .godot/ dir you’ll ignore)
#    Close the editor for now.

# ⑤ Stage & commit
git add .
git commit -m "Bootstrap Godot 4 project: repo scaffolding + CI stub"
git push origin main
