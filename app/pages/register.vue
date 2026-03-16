<script setup lang="ts">
const supabase = useSupabaseClient()
const isLoading = ref(false)
const formData = reactive({
  labName: '',
  phone: '',
  username: '',
  email: '',
  password: '',
})

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
  <div class="flex-1 grid justify-center content-center px-4 py-10 min-h-screen bg-slate-50">
    <div class="w-full max-w-md bg-white rounded-2xl border border-slate-200 shadow-xl shadow-slate-200/60 p-8">
      <!-- Header -->
      <div class="text-center mb-8">
        <h1 class="text-2xl font-bold text-slate-800 mb-1">
          Registrarse
        </h1>
        <p class="text-sm text-slate-600">
          Crea tu cuenta de laboratorio
        </p>
      </div>

      <form id="registerForm" class="space-y-5" @submit.prevent="handleRegistration">
        <div class="space-y-1.5">
          <label for="labName" class="block text-sm font-semibold text-slate-700">
            Nombre del Laboratorio
          </label>
          <input
            id="labName"
            v-model="formData.labName"
            type="text"
            placeholder="Mi Laboratorio"
            class="field-input"
            autocomplete="organization"
          >
        </div>

        <div class="space-y-1.5">
          <label for="username" class="block text-sm font-semibold text-slate-700">
            Nombre Completo
          </label>
          <input
            id="username"
            v-model="formData.username"
            type="text"
            placeholder="Juan Perez"
            class="field-input"
            autocomplete="name"
          >
        </div>

        <div class="space-y-1.5">
          <label for="phone" class="block text-sm font-semibold text-slate-700">
            Número de Teléfono
          </label>
          <input
            id="phone"
            v-model="formData.phone"
            type="tel"
            placeholder="82371823"
            class="field-input"
            autocomplete="tel"
          >
        </div>

        <div class="space-y-1.5">
          <label for="email" class="block text-sm font-semibold text-slate-700">
            Correo Electrónico
          </label>
          <input
            id="email"
            v-model="formData.email"
            type="email"
            placeholder="miemail@dominio.com"
            class="field-input"
            autocomplete="email"
          >
        </div>

        <div class="space-y-1.5">
          <label for="password" class="block text-sm font-semibold text-slate-700">
            Contraseña
          </label>
          <input
            id="password"
            v-model="formData.password"
            type="password"
            placeholder="Mínimo 8 caracteres"
            class="field-input"
            autocomplete="new-password"
          >
        </div>

        <div class="pt-1">
          <button
            form="registerForm"
            type="submit"
            class="submit-btn"
            :disabled="isLoading"
            :aria-busy="isLoading"
          >
            <Spinner v-if="isLoading" size="w-4 h-4" />
            <span>{{ isLoading ? 'Registrando...' : 'Crear cuenta' }}</span>
          </button>
        </div>
      </form>

      <p class="text-center text-sm text-slate-600 mt-6">
        ¿Ya tienes cuenta?
        <NuxtLink to="/login" class="login-link">
          Iniciar sesión
        </NuxtLink>
      </p>
    </div>
  </div>
</template>

<style scoped>
.field-input {
  display: block;
  width: 100%;
  padding: 0.625rem 0.875rem;
  font-size: 0.9375rem;
  color: #1e293b;
  background: #fff;
  border: 1.5px solid #94a3b8;
  border-radius: 0.625rem;
  transition: border-color 0.15s ease, box-shadow 0.15s ease;
  outline: none;
}
.field-input::placeholder {
  color: #94a3b8;
}
.field-input:hover {
  border-color: #64748b;
}
.field-input:focus {
  border-color: #6366f1;
  box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.2);
}

.submit-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  width: 100%;
  padding: 0.7rem 1.5rem;
  font-size: 0.9375rem;
  font-weight: 600;
  color: #fff;
  background: #4f46e5;
  border: none;
  border-radius: 0.625rem;
  cursor: pointer;
  transition: background 0.15s ease, box-shadow 0.15s ease, transform 0.1s ease;
}
.submit-btn:hover:not(:disabled) {
  background: #4338ca;
  box-shadow: 0 4px 14px rgba(79, 70, 229, 0.35);
}
.submit-btn:active:not(:disabled) {
  transform: scale(0.99);
}
.submit-btn:focus-visible {
  outline: 3px solid #6366f1;
  outline-offset: 2px;
}
.submit-btn:disabled {
  background: #a5b4fc;
  cursor: not-allowed;
}

.login-link {
  font-weight: 600;
  color: #4f46e5;
  margin-left: 0.2rem;
  text-decoration: underline;
  text-underline-offset: 2px;
  text-decoration-color: transparent;
  transition: color 0.15s ease, text-decoration-color 0.15s ease;
}
.login-link:hover {
  color: #4338ca;
  text-decoration-color: #4338ca;
}
.login-link:focus-visible {
  outline: 2px solid #6366f1;
  outline-offset: 2px;
  border-radius: 2px;
}
</style>
