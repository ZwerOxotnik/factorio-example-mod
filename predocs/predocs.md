# About auto documentation

It uses [emmylua](https://emmylua.github.io/annotations/class.html) as primary doc syntax but it is also compatible with some [ldoc](https://stevedonovan.github.io/ldoc/manual/doc.md.html) tags.

All configurations are stored in `predocs` folder.

Please, use Python 3.6 to use these tools.

Manual installation:

```bash
pip install -r requirements.txt
```

Building html:

```bash
sphinx-build -b html predocs docs/_build/html
```

Dependencies:

* [sphinx][sphinx] - Sphinx is a tool that makes it easy to create intelligent and beautiful documentation
* sphinxcontrib-luadomain - A sphinx lua domain.
* [sphinx-lua][sphinx-lua] - Generates a [sphinx][sphinx] doc using lua doc comment.
* [sphinx-rtd-theme][sphinx-rtd-theme] - A theme for [sphinx][sphinx]
* [m2r2][m2r2] - Markdown to reStructuredText converter