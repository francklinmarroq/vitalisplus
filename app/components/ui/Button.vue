<script setup lang="ts">
defineProps<{
    color: string;
    content: string;
    textColor: string;
}>();
</script>
<template>
    <button :class="color + ' ' + textColor" class="p-2 rounded-xl">
        {{ content }}
    </button>
</template>
