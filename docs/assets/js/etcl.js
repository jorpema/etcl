/* ETCL · interaccions de la web
   S'executa a cada canvi de pàgina gràcies a document$ (navigation.instant) */

(function () {
  const reduced = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

  function revealOnScroll() {
    const els = document.querySelectorAll(
      ".md-typeset .grid.cards > ul > li, .md-typeset .tl-item, .md-typeset .xifra, .md-typeset .admonition, .md-typeset details"
    );
    if (reduced || !("IntersectionObserver" in window)) return;
    const io = new IntersectionObserver((entries) => {
      entries.forEach((e) => {
        if (e.isIntersecting) { e.target.classList.add("is-visible"); io.unobserve(e.target); }
      });
    }, { rootMargin: "0px 0px -40px 0px" });
    els.forEach((el, i) => {
      const r = el.getBoundingClientRect();
      if (r.top < window.innerHeight) return; // el que ja es veu no s'amaga
      el.classList.add("reveal");
      el.style.transitionDelay = (i % 4) * 60 + "ms";
      io.observe(el);
    });
  }

  function counters() {
    document.querySelectorAll(".xifra b[data-n]").forEach((el) => {
      const target = parseInt(el.dataset.n, 10);
      if (reduced) { el.textContent = target; return; }
      const t0 = performance.now(), dur = 1200;
      const step = (t) => {
        const p = Math.min(1, (t - t0) / dur), ease = 1 - Math.pow(1 - p, 3);
        el.textContent = Math.round(target * ease);
        if (p < 1) requestAnimationFrame(step);
      };
      requestAnimationFrame(step);
    });
  }

  // Progrés del curs: sessions passades / sessions totals
  function progress() {
    const bar = document.querySelector(".progres > div");
    const txt = document.querySelector("#progres-text");
    if (!bar) return;
    const dates = (bar.parentElement.dataset.dates || "").split(",").filter(Boolean);
    const now = new Date();
    const fetes = dates.filter((d) => new Date(d + "T23:59:59") < now).length;
    const pct = dates.length ? Math.round((fetes / dates.length) * 100) : 0;
    requestAnimationFrame(() => (bar.style.width = pct + "%"));
    if (txt) txt.textContent = `${fetes} de ${dates.length} sessions fetes (${pct} %)`;
  }

  // Filtre del calendari (Tots / Prof. 1 / Prof. 2) i ressaltat de la propera sessió
  function calendar() {
    const box = document.querySelector(".filtres");
    const items = document.querySelectorAll(".tl-item[data-date]");
    if (!items.length) return;
    const now = new Date(); now.setHours(0, 0, 0, 0);
    let next = null;
    items.forEach((it) => {
      const d = new Date(it.dataset.date + "T00:00:00");
      if (d < now) it.style.opacity = it.classList.contains("festiu") ? ".45" : ".7";
      if (!next && d >= now && !it.classList.contains("festiu")) next = it;
    });
    if (next) {
      const tag = document.createElement("span");
      tag.className = "tag estat"; tag.textContent = "Pròxima sessió";
      const host = next.querySelector("p:last-of-type") || next;
      host.appendChild(document.createTextNode(" ")); host.appendChild(tag);
      next.style.outline = "2px solid var(--etcl-1)";
    }
    if (!box) return;
    box.querySelectorAll("button").forEach((b) => {
      b.addEventListener("click", () => {
        box.querySelectorAll("button").forEach((x) => x.classList.remove("actiu"));
        b.classList.add("actiu");
        const f = b.dataset.f;
        items.forEach((it) => {
          it.style.display = f === "tots" || it.classList.contains(f) ? "" : "none";
        });
        document.querySelectorAll(".tl-week").forEach((w) => (w.style.display = f === "tots" ? "" : "none"));
      });
    });
  }

  const run = () => { revealOnScroll(); counters(); progress(); calendar(); };
  if (window.document$) window.document$.subscribe(run);
  else document.addEventListener("DOMContentLoaded", run);
})();
