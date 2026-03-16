<!-- pages/confirm.vue -->
<script setup lang="ts">
// El módulo @nuxtjs/supabase v2 maneja el intercambio de tokens
// automáticamente via su plugin. Solo necesitamos esperar y redirigir
// una vez que la sesión esté disponible.
const supabase = useSupabaseClient()
const router = useRouter()

onMounted(async () => {
  const { data } = await supabase.auth.getSession()
  if (data.session) {
    router.push('/dashboard')
  }
  else {
    router.push('/login')
  }
})
</script>

<template>
  <div>Procesando autenticación...</div>
</template>
