<script setup lang="ts">
import Button from '~/components/ui/Button.vue'
</script>

<template>
  <div class="min-h-screen flex flex-col">
    <nav class="shadow-md shadow-slate-200 shrink-0">
      <div class="bg-white p-4">
        <div class="flex w-full justify-between items-center">
          <div class="font-semibold text-slate-800">
            Lab Name
          </div>
          <div class="flex gap-3">
            <Button
              content="Iniciar Sesión"
              color="bg-transparent border-2 border-indigo-500 hover:bg-indigo-50"
              text-color="text-indigo-500 hover:text-indigo-600"
              @click="navigateTo('/login')"
            />
            <Button
              content="Registrarse"
              color="bg-indigo-500 hover:bg-indigo-600"
              text-color="text-white"
              @click="navigateTo('/register')"
            />
          </div>
        </div>
      </div>
    </nav>
    <main class="flex-1 overflow-hidden">
      <slot />
    </main>
  </div>
</template>
