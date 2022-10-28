# thomabir.github.io
The source for my website, based on [pandoc-markdown-css-theme](https://github.com/jez/pandoc-markdown-css-theme).

To build the site, run
```
make clean
make
```

The root of the site is `dist/`. To deploy it to Github Pages, run
```
git subtree push --prefix dist origin gh-pages
```
