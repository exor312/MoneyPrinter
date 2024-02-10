// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },
  modules: [
    "@bg-dev/nuxt-naiveui",
    "@vueuse/nuxt",
    "@nuxtjs/tailwindcss",
    "@nuxt/content",
    "nuxt-icon"
  ],
});