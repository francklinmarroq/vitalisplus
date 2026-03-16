// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: { enabled: true },
  modules: ['@nuxtjs/supabase', '@nuxt/ui'],
  css: ['~/assets/css/main.css'],
  components: [{
    path: '~/components',
    pathPrefix: false,
  }],
  supabase: {
    useSsrCookies: true,
    redirectOptions: {
      login: '/login',
      callback: '/confirm',
      include: ['/dashboard(/*)?', '/profile(/*)?'],
      exclude: ['/', '/register', '/login'],
    },
  },

})
