// theme.js — single responsibility: drive the light/dark toggle in the
// header. Persists choice in localStorage; updates the
// `<html data-theme>` attribute that theme.css reads.

(function () {
  var KEY = 'theme';
  var MEDIA = window.matchMedia('(prefers-color-scheme: dark)');
  var root = document.documentElement;
  var buttons = document.querySelectorAll('[data-theme-set]');

  function resolvedTheme() {
    var cur = root.dataset.theme || 'system';
    if (cur === 'system') {
      return MEDIA.matches ? 'dark' : 'light';
    }
    return cur;
  }

  function paint() {
    var cur = resolvedTheme();
    buttons.forEach(function (b) {
      b.setAttribute('aria-pressed', b.dataset.themeSet === cur ? 'true' : 'false');
    });
  }
  paint();

  buttons.forEach(function (b) {
    b.addEventListener('click', function () {
      var v = b.dataset.themeSet;
      localStorage.setItem(KEY, v);
      root.dataset.theme = v;
      paint();
    });
  });

  MEDIA.addEventListener('change', function () {
    if ((root.dataset.theme || 'system') === 'system') {
      paint();
    }
  });

  // Re-render math glyphs when the user flips theme — KaTeX inlines color.
  // (Not strictly necessary here since theme.css uses currentColor, but cheap.)
  window.addEventListener('storage', function (e) {
    if (e.key === KEY) {
      root.dataset.theme = e.newValue || 'system';
      paint();
    }
  });
})();
