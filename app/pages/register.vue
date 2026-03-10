<script setup lang="ts">
const supabase = useSupabaseClient()
const formData = reactive({
  labName: '',
  phone: '',
  username: '',
  email: '',
  password: '',
})

const isLoading = ref(false)

definePageMeta({
  layout: 'public',
})
async function handleRegistration() {
  isLoading.value = true
  const { data, error } = await supabase.auth.signUp({ email: formData.email, password: formData.password, options: { data: {
    name: formData.username,
    labName: formData.labName,
    phone: formData.phone,
  } } })
  if (error) {
    console.error(error) // TODO: Mejorar este error
  }

  isLoading.value = false
}
</script>

<template>
  <div class="flex-1 grid justify-center content-center px-4">
    <Card
      class="w-full max-w-md p-6 border border-slate-200 shadow-xl shadow-slate-200/50 rounded-2xl bg-white"
    >
      <div class="text-center mb-6">
        <h3 class="text-2xl font-bold text-slate-800">
          Registrarse
        </h3>
        <p class="text-sm text-slate-500 mt-1">
          Crea tu cuenta de laboratorio
        </p>
      </div>

      <form id="registerForm" class="space-y-4" @submit.prevent="handleRegistration">
        <div>
          <label for="labName" class="block text-sm font-medium text-slate-700 mb-1.5">Nombre del Laboratorio</label>
          <Input
            id="labName"
            v-model="formData.labName"
            input-type="text"
            placeholder="Mi Laboratorio"
          />
        </div>

        <div>
          <label for="username" class="block text-sm font-medium text-slate-700 mb-1.5">Nombre Completo</label>
          <Input
            id="username"
            v-model="formData.username"
            input-type="text"
            placeholder="Juan Perez"
          />
        </div>

        <div>
          <label for="phone" class="block text-sm font-medium text-slate-700 mb-1.5">Número de Teléfono</label>
          <Input
            id="phone"
            v-model="formData.phone"
            input-type="text"
            placeholder="82371823"
          />
        </div>

        <div>
          <label for="email" class="block text-sm font-medium text-slate-700 mb-1.5">E-mail</label>
          <Input
            id="email"
            v-model="formData.email"
            input-type="email"
            placeholder="miemail@dominio.com"
          />
        </div>

        <div>
          <label for="password" class="block text-sm font-medium text-slate-700 mb-1.5">Contraseña</label>
          <Input
            id="password"
            v-model="formData.password"
            input-type="password"
            placeholder="********"
          />
        </div>

        <div class="pt-2">
          <Button
            form="registerForm"
            class="w-full"
            :content="isLoading ? 'Registrando...' : 'Registrarse'"
            color="bg-indigo-500 hover:bg-indigo-600 transition-colors"
            text-color="text-white"
            :loading="isLoading"
          />
        </div>
      </form>

      <p class="text-center text-sm text-slate-500 mt-5">
        ¿Ya tienes cuenta?
        <NuxtLink to="/login" class="text-indigo-500 hover:text-indigo-600 font-medium ml-1">
          Iniciar sesión
        </NuxtLink>
      </p>
    </Card>
  </div>
</template>
