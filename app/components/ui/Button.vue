<script setup lang="ts">
defineProps<{
  color: string
  content: string
  textColor: string
  loading?: boolean
}>()
</script>

<template>
  <button :class="`${color} ${textColor}`" class="p-2 rounded-xl flex items-center justify-center gap-2" :disabled="loading">
    <Spinner v-if="loading" size="w-5 h-5" />
    <span :class="{ 'opacity-50': loading }">{{ content }}</span>
  </button>
</template>
