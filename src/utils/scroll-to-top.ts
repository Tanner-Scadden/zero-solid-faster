export const scrollToTop = () => {
  const content = document.getElementById("__content");
  if (content) {
    content.scrollTo({ top: 0, behavior: "smooth" });
  }
};
