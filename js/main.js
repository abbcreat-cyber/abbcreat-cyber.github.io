/* 个人主页 · 交互脚本（很小，只有两件事） */

// 1. 页脚年份自动更新
const yearEl = document.getElementById("year");
if (yearEl) yearEl.textContent = String(new Date().getFullYear());

// 2. 进入视口时显现（配合 CSS 里的 .reveal）
const revealEls = document.querySelectorAll(".reveal");
const cards = document.querySelectorAll(".work-card");

// 作品卡片错开显现（动画结束后清掉延迟，避免影响 hover）
cards.forEach((card, i) => {
  card.style.transitionDelay = i * 90 + "ms";
});

if ("IntersectionObserver" in window) {
  const io = new IntersectionObserver(
    (entries) => {
      for (const entry of entries) {
        if (entry.isIntersecting) {
          const el = entry.target;
          el.classList.add("is-in");
          io.unobserve(el);
          // 等入场动画结束，把延迟清掉，hover 效果才不卡顿
          setTimeout(() => {
            el.style.transitionDelay = "";
          }, 1200);
        }
      }
    },
    { threshold: 0.12, rootMargin: "0px 0px -8% 0px" }
  );
  revealEls.forEach((el) => io.observe(el));
} else {
  // 老浏览器兜底：直接全部显示
  revealEls.forEach((el) => el.classList.add("is-in"));
}
