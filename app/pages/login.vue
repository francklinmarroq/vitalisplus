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
  <div class="flex-1 grid justify-center content-center px-4">
    <Card>
      <div class="text-center mb-6">
        <h3 class="text-2xl font-bold text-slate-800">
          Login
        </h3>

        <p class="text-slate-500">
          Inicia Sesión y empieza a adminitrar tu laboratorio
        </p>
      </div>

      <form id="loginForm" @submit.prevent="handleLogin">
        <div>
          <label for="email" class="block text-sm font-medium text-slate-700 mb-1.5">E-mail</label>
          <Input v-model="formData.email" input-type="email" placeholder="miemail@dominio.com" />
        </div>
        <div>
          <label for="email" class="block text-sm font-medium text-slate-700 mb-1.5">Contraseña</label>
          <Input v-model="formData.password" input-type="password" placeholder="********" />
        </div>
        <div class="pt-2">
          <Button
            form="loginForm"
            class="w-full"
            :content="isLoading ? 'Iniciando Sesión...' : 'Iniciar Sesión'"
            color="bg-indigo-500 hover:bg-indigo-600 transition-colors"
            text-color="text-white"
            :loading="isLoading"
          />
        </div>
      </form>
    </Card>
  </div>
</template>
