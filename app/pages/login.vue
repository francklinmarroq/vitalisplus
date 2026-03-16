<script setup lang="ts">
const supabase = useSupabaseClient()
const isLoading = ref(false)
const formData = reactive({
  email: '',
  password: '',
})

definePageMeta({
  layout: 'public',
})

async function handleLogin() {
  isLoading.value = true
  const { data, error } = await supabase.auth.signInWithPassword({ email: formData.email, password: formData.password })
  if (error) {
    console.error(error) // TODO: mojorar este error
  }

  isLoading.value = false
}
</script>

<template>
  <div class="grid justify-center content-center min-h-screen">
    <UCard>
      <div class="">
        <h3 class="text-2xl font-bold text-slate-800">
          Login
        </h3>

        <p class="text-slate-500">
          Inicia Sesión y empieza a adminitrar tu laboratorio
        </p>
      </div>

      <form id="loginForm" @submit.prevent="handleLogin">
        <div>
          <UFormField label="Correo electrónico">
            <UInput v-model="formData.email" class="w-full" />
          </UFormField>
          <UFormField label="Contraseña">
            <UInput v-model="formData.password" type="password" class="w-full" />
          </UFormField>
        </div>
        <div class="pt-2">
          <UButton type="submit" form="loginForm" :loading="false" class="w-full justify-center">
            Iniciar Sesión
          </UButton>
        </div>
      </form>
    </UCard>
  </div>
</template>
